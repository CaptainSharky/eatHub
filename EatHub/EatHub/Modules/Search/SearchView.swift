//
//  SearchView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

struct SearchView: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var viewModel: SearchViewModel
    @FocusState private var isTextFieldFocused: Bool
    @Namespace private var animationNamespace

    @State private var selectedMeal: Meal?
    @State private var showDetail: Bool = false

    private enum Constants {
        static let bodySpacing: CGFloat = 8

        static let topPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 16
        static let imageCornerRadius: CGFloat = 24

        static let searchBarHeight: CGFloat = 24
        static let searchBarIconsPadding: CGFloat = 8
        static let searchBarCornerRadius: CGFloat = 8

        static let bottomScrollPadding: CGFloat = 41

        static let searchBarShadowHeight: CGFloat = 40
        static let searchListZIndex: Double = 0

        static let detailZIndex: Double = 1

        enum Title {
            static let navBarTitle = "Search"
            static let searchTextFieldPlaceholder = "What do you want?"
        }

        enum Icons {
            static let search: String = "magnifyingglass"
            static let clear: String = "xmark.circle.fill"
        }

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
                ZStack {
                    bodyView
                        .padding(.horizontal, Constants.horizontalPadding)
                    topShadowToBottom
                }
            }
            .navigationTitle(Constants.Title.navBarTitle)
            .navigationDestination(for: Meal.self) { meal in
                let input = DetailsViewModuleInput(
                    id: meal.id,
                    name: meal.name,
                    thumbnail: meal.thumbnail
                )
                let detailsViewModel = viewModel.detailsViewModelBuilder(input)
                DetailsView(viewModel: detailsViewModel)
            }
            .background(Color.Custom.backgroundPrimary)
        }
    }
}

extension SearchView {
    private var topShadowToBottom: some View {
        VStack {
            Rectangle()
                .fill(.clear)
                .overlay(
                    LinearGradient(
                        gradient:
                            Gradient(colors: [Color.Custom.backgroundPrimary, .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: Constants.searchBarShadowHeight, alignment: .top)
            Spacer()
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
                    TextField(
                        Constants.Title.searchTextFieldPlaceholder,
                        text: $viewModel.searchText
                    )
                    .focused($isTextFieldFocused)
                    .frame(height: Constants.searchBarHeight)
                    Button {
                        viewModel.searchText = ""
                    } label: {
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
                        .ignoreTabBar()
                        .padding(.top, 16)
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
