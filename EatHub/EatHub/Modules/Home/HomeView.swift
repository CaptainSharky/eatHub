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
        Group {
            if let error = viewModel.errorMessage {
                Text("Ошибка: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        HorizontalScrollSection(meals: viewModel.horizontalMeals)
                        VerticalListSection(meals: viewModel.verticalMeals)
                    }
                    .padding(.vertical)
                }
                .environmentObject(viewModel)
            }
        }
        .onFirstAppear {
            viewModel.fetchMeals()
        }
    }
}

#Preview {
    let requester = APIRequester()
    let service = MealsService(requester: requester)
    let viewModel = HomeViewModel(mealsService: service)

    return HomeView(viewModel: viewModel)
}
