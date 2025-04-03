//
//  HomeView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 26.03.2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Popular")
                        .font(Font.Custom.headline)
                        .padding(.horizontal, .large)
                    HorizontalListSection(meals: viewModel.horizontalMeals)
                    Text("Recent")
                        .font(Font.Custom.headline)
                        .padding(.horizontal, .large)
                    VerticalListSection(meals: viewModel.verticalMeals)
                        .padding(.horizontal, .large)
                }
                .padding(.vertical)
            }
            .navigationDestination(for: Meal.self) { meal in
                let input = DetailsViewModuleInput(
                    id: meal.id,
                    name: meal.name,
                    thumbnail: meal.thumbnail
                )
                let detailsViewModel = viewModel.detailsViewModelBuilder(input)
                DetailsView(viewModel: detailsViewModel)
            }
            .onFirstAppear {
                viewModel.fetchMeals()
            }
            .background(Color.Custom.backgroundPrimary)
        }
    }
}

// MARK: - Preview

#Preview {
    let requester = APIRequester()
    let favoritesManager = FavoritesManager(store: UserDefaults.standard)
    let mealsService = MealsService(requester: requester)
    let viewModel = HomeViewModel(
        detailsViewModelBuilder: { input in
            let requester = APIRequester()
            let mealsService = MealsService(requester: requester)
            return DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                favoritesManager: favoritesManager,
                mealsService: mealsService
            )
        },
        mealsService: mealsService
    )
    HomeView(viewModel: viewModel)
}
