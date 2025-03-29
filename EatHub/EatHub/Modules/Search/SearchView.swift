//
//  SearchView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

struct SearchView: View {

    // MARK: - ViewModel
    @ObservedObject var viewModel: SearchViewModel

    // MARK: - UI properties
    @FocusState var isTextFieldFocused: Bool
    @Namespace private var animationNamespace

    @State private var selectedMeal: Meal? = nil
    @State private var showDetail: Bool = false

    // MARK: - Constants
    private enum Constants {
        static let bodySpacing: CGFloat = 16

        static let topPadding: CGFloat = 32
        static let horizontalPadding: CGFloat = 16
        static let imageCornerRadius: CGFloat = 24

        static let searchBarHeight: CGFloat = 36
        static let searchBarIconsPadding: CGFloat = 8
        static let searchBarCornerRadius: CGFloat = 8

        static let searchListZIndex: Double = 0
        static let detailZIndex: Double = 1

        enum Icons {
            static let search: String = "magnifyingglass"
            static let clear: String = "xmark.circle.fill"
        }

        // TODO: подумать над тайтлами
        enum Title {
            static let searchBarTitle: String = "Что хотите найти?"
            static func errorMessage(_ text: String) -> String {
                "Ошибка: \(text)"
            }
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

    // MARK: - View Elements
    var searchBar: some View {
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
                        // TODO: - разобраться почему не сразу стирает, а только после сабмита после нажатия
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
    var bodyView: some View {
        if let error = viewModel.errorMessage {
            Spacer()
            Text(Constants.Title.errorMessage(error))
            Spacer()
        } else if viewModel.searchText.isEmpty {
            Spacer()
            Text(Constants.Title.startTitle)
            Spacer()
        } else if !viewModel.results.isEmpty {
            ScrollView {
                VerticalListSection(
                    meals: viewModel.results,
                    namespace: animationNamespace
                ) { meal in
                    withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                        selectedMeal = meal
                        showDetail = true
                    }
                }
                    .padding(.bottom, 41)
            }
        } else {
            Spacer()
            Text(Constants.Title.emptyResultsTitle)
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

// MARK: - Preview

#Preview {
    let service = MealsService(requester: APIRequester())
    let viewModel = SearchViewModel(
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
        mealService: service
    )
    SearchView(viewModel: viewModel)
}
