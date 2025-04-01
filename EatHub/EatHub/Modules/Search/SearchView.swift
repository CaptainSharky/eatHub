//
//  SearchView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    @FocusState var isTextFieldFocused: Bool
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

        // TODO: подумать над тайтлами
        enum Title {
            static let searchBarTitle: String = "Что хотите найти?"
            static let errorMessage: String = "Возникла ошибка. Повторите позже"
            static let emptyResultsTitle: String = "Не нашлось рецептов по вашему запросу"
            static let startTitle: String = "Что будем готовить?"
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
        ZStack {
            VStack(spacing: Constants.bodySpacing) {
                searchBar
                bodyView
            }
            .frame(maxWidth: .infinity)
            .zIndex(Constants.searchListZIndex)

            if let meal = selectedMeal, showDetail {
                openDetailsView(for: meal)
            }
        }
    }
}

private extension SearchView {

    private var searchBar: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.searchBarCornerRadius)
                    .fill(Constants.Colors.lightGray)
                    .frame(height: Constants.searchBarHeight)
                HStack(spacing: 0) {
                    Button(action: {
                        isTextFieldFocused.toggle()
                    }, label: {
                        Image(systemName: Constants.Icons.search)
                    })
                    .foregroundColor(Constants.Colors.darkGray)
                    .padding(.leading, Constants.searchBarIconsPadding)
                    TextField(Constants.Title.searchBarTitle, text: $viewModel.searchText)
                        .focused($isTextFieldFocused)
                        .frame(height: Constants.searchBarHeight)
                    Button(action: {
                        viewModel.searchText = ""
                    }, label: {
                        // TODO: - разобраться почему не сразу стирает
                        Image(systemName: Constants.Icons.clear)
                    })
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
            case .idle:
                centeredMessage(Constants.Title.startTitle)
            case .error:
                centeredMessage(Constants.Title.errorMessage)
            case .emptyResults:
                centeredMessage(Constants.Title.emptyResultsTitle)
            case .resultsLoaded(let results):
                ZStack {
                    ScrollView {
                        VerticalListSection(
                            meals: results,
                            namespace: animationNamespace
                        ) { meal in
                            withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                                selectedMeal = meal
                                showDetail = true
                            }
                        }
                        .id(results.map(\.id).joined())
                        .padding(.bottom, Constants.bottomScrollPadding)
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: results)
                    topShadowToBottom
                }
        }
    }

    private var topShadowToBottom: some View {
        VStack {
            Rectangle()
                .fill(.clear)
                .overlay(
                    LinearGradient(
                        gradient:
                            Gradient(colors: [.white, .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: Constants.searchBarShadowHeight, alignment: .top)
            Spacer()
        }
    }

    private func centeredMessage(_ text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
            Spacer()
        }
    }

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

#Preview {
    let service = MealsService(requester: APIRequester())
    let viewModel = SearchViewModel(
        detailsViewModelBuilder: { input in
            let requester = APIRequester()
            let favoritesManager = FavoritesManager()
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
