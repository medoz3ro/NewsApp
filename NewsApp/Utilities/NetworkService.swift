import Foundation
import SwiftUI

// MARK: - API Error
struct APIError: Identifiable, Error {
    let id = UUID()
    let code: Int
    let title: String
    let description: String
}

// MARK: - Network Service
final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private var apiKey: String { AppConfig.newsApiKey }

    func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw APIError(code: 400, title: "Invalid URL", description: "The URL is invalid.")
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError(code: 1002, title: "Invalid Response", description: "Server response is invalid.")
        }

        switch httpResponse.statusCode {
        case 200: break
        case 400: throw APIError(code: 400, title: "Bad Request", description: "The request was invalid.")
        case 401: throw APIError(code: 401, title: "Unauthorized", description: "Check your API key.")
        case 404: throw APIError(code: 404, title: "Not Found", description: "Resource not found.")
        default: throw APIError(code: httpResponse.statusCode, title: "Server Error", description: "Unexpected error occurred.")
        }

        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
        return decoded.articles
    }
}

