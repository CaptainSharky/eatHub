import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init() {
        let requester = APIRequester()
        let service = MealsService(requester: requester)
        _viewModel = StateObject(wrappedValue: HomeViewModel(mealsService: service))
    }

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
    HomeView()
}

