import Foundation

@MainActor
class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var apiError: APIError? = nil

    private let service = NetworkService.shared
    
    func load(isRefreshing: Bool = false) async {
        if !isRefreshing {
            isLoading = true
        }
        apiError = nil

        defer {
            if !isRefreshing {
                isLoading = false
            }
        }

        do {
            let fetchedArticles = try await service.fetchTopHeadlines()
            articles = fetchedArticles
        } catch let apiError as APIError {
            self.apiError = apiError
        } catch let urlError as URLError {
            if urlError.code == .notConnectedToInternet {
                self.apiError = APIError(
                    code: urlError.errorCode,
                    title: "No Internet",
                    description: "Please check your connection and try again."
                )
            } else if urlError.code == .cancelled {
                print("Request cancelled")
            } else {
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
