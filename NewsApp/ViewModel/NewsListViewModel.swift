import Foundation

//Error Handling: Implement error handling for API calls. If an error occurs (e.g., no
//internet connection), display an appropriate message to the user,
@MainActor
class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var apiError: APIError? = nil

    private let service = NetworkService.shared

    func load(isRefreshing: Bool = false) async {
        if !isRefreshing { isLoading = true }
        apiError = nil

        defer { if !isRefreshing { isLoading = false } }

        do {
            articles = try await service.fetchTopHeadlines()
        } catch {
            self.apiError = mapError(error)
        }
    }

    private func mapError(_ error: Error) -> APIError {
        if let apiError = error as? APIError { return apiError }
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return APIError(
                    code: urlError.errorCode,
                    title: "No Internet",
                    description: "Please check your connection."
                )
            case .cancelled:
                return APIError(
                    code: urlError.errorCode,
                    title: "Cancelled",
                    description: "Request was cancelled."
                )
            default:
                return APIError(
                    code: urlError.errorCode,
                    title: "Network Error",
                    description: urlError.localizedDescription
                )
            }
        }
        return APIError(
            code: 1001,
            title: "Unknown Error",
            description: error.localizedDescription
        )
    }
}
