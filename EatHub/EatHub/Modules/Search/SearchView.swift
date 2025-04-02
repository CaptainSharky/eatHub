//
//  SearchView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @FocusState private var isTextFieldFocused: Bool
    @Namespace private var animationNamespace

    @State private var selectedMeal: Meal?
    @State private var showDetail: Bool = false

    private enum Constants {
        static let bodySpacing: CGFloat = 16

        static let topPadding: CGFloat = 32
        static let horizontalPadding: CGFloat = 16
        static let imageCornerRadius: CGFloat = 24

        static let searchBarHeight: CGFloat = 36
        static let searchBarIconsPadding: CGFloat = 8
        static let searchBarCornerRadius: CGFloat = 8

        static let bottomScrollPadding: CGFloat = 41

        static let searchBarShadowHeight: CGFloat = 40
        static let searchListZIndex: Double = 0

        static let detailZIndex: Double = 1

        enum Icons {
            static let search: String = "magnifyingglass"
            static let clear: String = "xmark.circle.fill"
        }

        static let searchBarTitle: String = "What do you want?"

        enum Colors {
            static let darkGray = Color(uiColor: .systemGray)
            static let lightGray = Color(uiColor: .systemGray6)
        }

        static let animationDuration: TimeInterval = 0.5
        static let detailTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom)
        )
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.bodySpacing) {
                searchBar
                bodyView
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
        }
    }

    private var searchBar: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.searchBarCornerRadius)
                    .fill(Constants.Colors.lightGray)
                    .frame(height: Constants.searchBarHeight)
                HStack(spacing: 0) {
                    Button {
                        isTextFieldFocused.toggle()
                    } label: {
                        Image(systemName: Constants.Icons.search)
                    }
                    .foregroundColor(Constants.Colors.darkGray)
                    .padding(.leading, Constants.searchBarIconsPadding)
                    TextField(Constants.searchBarTitle, text: $viewModel.searchText)
                        .focused($isTextFieldFocused)
                        .frame(height: Constants.searchBarHeight)
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        // TODO: - разобраться почему не сразу стирает
                        Image(systemName: Constants.Icons.clear)
                    }
                    .foregroundColor(Constants.Colors.darkGray)
                    .padding(.trailing, Constants.searchBarIconsPadding)
                }
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.top, Constants.topPadding)
    }

    @ViewBuilder
    private var bodyView: some View {
        switch viewModel.state {
            case .idle, .error, .emptyResults:
                CenteredVStaskText(text: viewModel.state.title)
            case .resultsLoaded(let results):
                ScrollView {
                    VerticalListSection(meals: results)
                        .padding(.bottom, 41)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: results)
        }
    }

    private func centeredMessage(_ text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    let service = MealsService(requester: APIRequester())
    let viewModel = SearchViewModel(
        detailsViewModelBuilder: { input in
            let requester = APIRequester()
            let favoritesManager = FavoritesManager(store: UserDefaults.standard)
            let mealsService = MealsService(requester: requester)
            return DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                favoritesManager: favoritesManager,
                mealsService: mealsService
            )
        },
        mealService: service
    )
    SearchView(viewModel: viewModel)
}
