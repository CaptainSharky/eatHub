//
//  SearchView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

struct SearchView: View {

    // MARK: - ViewModel
    @State var viewModel: SearchViewModel

    // MARK: - UI properties
    @FocusState var isTextFieldFocused: Bool

    // MARK: - Constants
    private enum Constants {
        static let topPadding: CGFloat = 32
        static let horizontalPadding: CGFloat = 16
        static let bottomPadding: CGFloat = 0
        static let imageCornerRadius: CGFloat = 24

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
        VStack(spacing: 0) {
            searchBar
            bodyView
            VerticalListSection(meals: viewModel.results)
        }
        .frame(maxWidth: .infinity)
    }
}

extension SearchView {

    // MARK: - View Elements
    private var searchBar: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Constants.Colors.lightGray)
                    .frame(height: 36)
                HStack(spacing: 0) {
                    Button(action: {
                        isTextFieldFocused.toggle()
                    }, label: {
                        Image(systemName: Constants.Icons.search)
                    })
                    .foregroundColor(Constants.Colors.darkGray)
                    .padding(.leading, 8)
                    TextField(Constants.Title.searchBarTitle, text: $viewModel.searchText)
                        .focused($isTextFieldFocused)
                        .frame(height: 36)
                    Button(action: {
                        viewModel.searchText = ""
                    }, label: {
                        Image(systemName: Constants.Icons.clear)
                    })
                    .foregroundColor(Constants.Colors.darkGray)
                    .padding(.trailing, 8)
                }
            }
        }
        .padding(
            EdgeInsets(
                top: Constants.topPadding,
                leading: Constants.horizontalPadding,
                bottom: Constants.bottomPadding,
                trailing: Constants.horizontalPadding
            )
        )
    }

    @ViewBuilder
    private var bodyView: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
            Spacer()
        } else if let error = viewModel.errorMessage {
            Spacer()
            Text(Constants.Title.errorMessage(error))
            Spacer()
        } else if viewModel.results.isEmpty && !viewModel.searchText.isEmpty {
            Spacer()
            Text(Constants.Title.emptyResultsTitle)
            Spacer()
        } else if viewModel.results.isEmpty {
            Spacer()
            Text(Constants.Title.startTitle)
            Spacer()
        } else {
            ScrollView {
                Spacer()
                // TODO: отображение результатов поиска из вью модельки
                Text("Тут результаты")
                Spacer()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let service = MealsService(requester: APIRequester())
    let viewModel = SearchViewModel(mealService: service)
    return SearchView(viewModel: viewModel)
}
