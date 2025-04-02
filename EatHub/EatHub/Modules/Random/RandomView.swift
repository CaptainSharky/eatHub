//
//  RandomView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-31.
//

import SwiftUI

struct RandomView: View {

    private enum Constants {

        static let bottomPadding: CGFloat = 90

        static let buttonIconSize: CGFloat = 44
        static let buttonCorberRadius: CGFloat = 12
        static let buttonPaddings: CGFloat = 12

        static let animationDuration: TimeInterval = 0.5
        static let detailTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom)
        )

        enum Title {
            static let errorText: String = "Error while fetching random item"
        }

        enum Icons {
            static let getRandom = "arrow.trianglehead.2.counterclockwise"
        }
    }

    @ObservedObject var viewModel: RandomViewModel

    @Namespace private var animationNamespace
    @State private var selectedMeal: Meal?
    @State private var showDetail = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                bodyView
                Spacer()
                Button {
                    viewModel.fetchRandom()
                } label: {
                    Image(systemName: Constants.Icons.getRandom)
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(
                            width: Constants.buttonIconSize,
                            height: Constants.buttonIconSize
                        )
                        .padding(Constants.buttonPaddings)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.buttonCorberRadius)
                        )
                }
                .disabled(viewModel.state.isLoading)
            }
            .padding(.bottom, Constants.bottomPadding)
            .onAppear {
                viewModel.fetchRandom()
            }
            .onShake {
                if !viewModel.state.isLoading {
                    viewModel.fetchRandom()
                }
            }

            if let meal = selectedMeal, showDetail {
                openDetailsView(for: meal)
            }
        }
    }
}

extension RandomView {
    @ViewBuilder
    private var bodyView: some View {
        switch viewModel.state {
            case .loading:
                RandomItemView()
            case .loaded(let result):
                RandomItemView(item: result)
                    .matchedGeometryEffect(id: result.id, in: animationNamespace)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                            selectedMeal = result
                            showDetail = true
                        }
                    }
            case .error:
                CenteredVStaskText(text: Constants.Title.errorText)
        }
    }

    @ViewBuilder
    func openDetailsView(for meal: Meal) -> some View {
        let detailsVM = viewModel.detailsViewModelBuilder(
            DetailsViewModuleInput(
                id: meal.id,
                name: meal.name,
                thumbnail: meal.thumbnail
            )
        )

        DetailsView(
            viewModel: detailsVM,
            onClose: {
                withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                    showDetail = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) {
                    selectedMeal = nil
                }
            },
            namespace: animationNamespace
        )
        .zIndex(1)
        .transition(Constants.detailTransition)
    }
}

#Preview {
    let service = MealsService(requester: APIRequester())
    let manager = FavoritesManager(store: UserDefaults.standard)
    let viewModel = RandomViewModel(
        detailsViewModelBuilder: { input in
            let requester = APIRequester()
            let mealsService = MealsService(requester: requester)
            return DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                favoritesManager: manager,
                mealsService: mealsService
            )
        },
        mealService: service
    )
    RandomView(viewModel: viewModel)
}
