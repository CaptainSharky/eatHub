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

    // MARK: - Constants
    private enum Constants {
        static let bodySpacing: CGFloat = 16

        static let topPadding: CGFloat = 32
        static let horizontalPadding: CGFloat = 16
        static let imageCornerRadius: CGFloat = 24

        static let searchBarHeight: CGFloat = 36
        static let searchBarIconsPadding: CGFloat = 8
        static let searchBarCornerRadius: CGFloat = 8

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
    }

    var body: some View {
        VStack(spacing: Constants.bodySpacing) {
            searchBar
            bodyView
        }
        .frame(maxWidth: .infinity)
    }
}

extension SearchView {

    // MARK: - View Elements
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
    private var bodyView: some View {
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
                VerticalListSection(meals: viewModel.results)
                    .padding(.bottom, 41)
            }
        } else {
            Spacer()
            Text(Constants.Title.emptyResultsTitle)
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    let service = MealsService(requester: APIRequester())
    let viewModel = SearchViewModel(mealService: service)
    return SearchView(viewModel: viewModel)
}
