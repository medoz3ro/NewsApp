import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, decodingError
}

final class NetworkService {
    private var apiKey: String { AppConfig.newsApiKey }

    func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw NetworkError.requestFailed
        }

        do {
            let result = try JSONDecoder().decode(NewsResponse.self, from: data)
            return result.articles
        } catch {
            throw NetworkError.decodingError
        }
    }
}

