import Foundation

@MainActor
class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var apiError: APIError? = nil

    private let service = NetworkService.shared

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            articles = try await service.fetchTopHeadlines()
        } catch let apiError as APIError {
            self.apiError = apiError
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                self.apiError = APIError(
                    code: urlError.errorCode,
                    title: "No Internet",
                    description: "Check your internet connection."
                )
            case .cancelled:
                print("Previous request cancelled")
            default:
                self.apiError = APIError(
                    code: urlError.errorCode,
                    title: "Network Error",
                    description: urlError.localizedDescription
                )
            }
        } catch {
            self.apiError = APIError(
                code: 1001,
                title: "Unknown Error",
                description: error.localizedDescription
            )
        }

    }
}
