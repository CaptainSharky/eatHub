import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: MainViewModel

    init() {
        let requester = APIRequester()
        let service = MealsService(requester: requester)
        _viewModel = StateObject(wrappedValue: MainViewModel(mealsService: service))
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
                        HorizontalScrollSection()
                        VerticalListSection()
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

