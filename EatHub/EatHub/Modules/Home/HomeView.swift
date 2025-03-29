//
//  HomeView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 26.03.2025.
//

import SwiftUI

struct HomeView: View {
    private enum Constants {
        static let listSpacing: CGFloat = 16
        static let animationDuration: TimeInterval = 0.5
        static let mainListZIndex: Double = 0
        static let detailZIndex: Double = 1
        static let detailTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom)
        )
    }

    @ObservedObject var viewModel: HomeViewModel
    @Namespace private var animationNamespace
    @State private var selectedMeal: Meal?
    @State private var showDetail: Bool = false

    var body: some View {
        ZStack {

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: Constants.listSpacing) {
                    HorizontalListSection(meals: viewModel.horizontalMeals) { meal in
                        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                            selectedMeal = meal
                            showDetail = true
                        }
                    }
                    VerticalListSection(
                        meals: viewModel.verticalMeals,
                        namespace: animationNamespace
                    ) { meal in
                        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                            selectedMeal = meal
                            showDetail = true
                        }
                    }
                }
                .padding(.vertical)
            }
            .zIndex(Constants.mainListZIndex)

            if let meal = selectedMeal, showDetail {
                openDetailsView(for: meal)
            }
        }
        .onAppear {
            viewModel.fetchMeals()
        }
    }
}

private extension HomeView {
    @ViewBuilder
    func openDetailsView(for meal: Meal) -> some View {
        let viewModel = viewModel.detailsViewModelBuilder(
            DetailsViewModuleInput(
                id: meal.id,
                name: meal.name,
                thumbnail: meal.thumbnail
            )
        )
        DetailsView(
            viewModel: viewModel,
            onClose: {
                withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                    showDetail = false
                    viewModel.isCloseButtonHidden = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) {
                    selectedMeal = nil
                }
            },
            namespace: animationNamespace
        )
        .zIndex(Constants.detailZIndex)
        .transition(Constants.detailTransition)
    }
}

// MARK: - Preview

#Preview {
    let requester = APIRequester()
    let mealsService = MealsService(requester: requester)
    let viewModel = HomeViewModel(
        detailsViewModelBuilder: { input in
            let requester = APIRequester()
            let mealsService = MealsService(requester: requester)
            return DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                mealsService: mealsService
            )
        },
        mealsService: mealsService
    )
    HomeView(viewModel: viewModel)
}
