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

        enum Title {
            static let navBarTitle = "Randomizer"
            static let errorText: String = "Error while fetching random item"
        }

        enum Icons {
            static let getRandom = "arrow.trianglehead.2.counterclockwise"
        }
    }

    @EnvironmentObject var tabBarVisibility: TabBarVisibilityManager

    @StateObject var viewModel: RandomViewModel
    @State private var selectedMeal: Meal?
    @State private var showDetail = false

    var body: some View {
        NavigationStack {
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
                .disabled(viewModel.isLoading)
            }
            .padding(.bottom, Constants.bottomPadding)
            .navigationTitle(Constants.Title.navBarTitle)
            .ignoreTabBar()
            .onAppear {
                viewModel.fetchRandom()
            }
            .onShake {
                if !viewModel.isLoading {
                    viewModel.fetchRandom()
                }
            }
            .navigationDestination(for: Meal.self) { meal in
                let input = DetailsViewModuleInput(
                    id: meal.id,
                    name: meal.name,
                    thumbnail: meal.thumbnail
                )
                let detailsViewModel = viewModel.detailsViewModelBuilder(input)
                DetailsView(viewModel: detailsViewModel)
                    .environmentObject(tabBarVisibility)
            }
            .frame(maxWidth: .infinity)
            .background(Color.Custom.backgroundPrimary)
        }
        .onChange(of: viewModel.state) { _, newState in
            viewModel.isLoading = (newState == .loading)
        }
    }
}

extension RandomView {
    @ViewBuilder
    private var bodyView: some View {
        ZStack {
            CircleShadow(isLoading: $viewModel.isLoading)
                .blur(radius: 20)
                .allowsHitTesting(false)
            switch viewModel.state {
                case .loading:
                    RandomItemView()
                case .loaded(let result):

                    NavigationLink(value: result) {
                        RandomItemView(item: result)
                    }
                case .error:
                    CenteredVStaskText(text: Constants.Title.errorText)
            }
        }
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
