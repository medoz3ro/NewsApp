//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 14.09.2025..
//

import SwiftUI

@MainActor
final class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var alertMessage: String? = nil

    private let service = NetworkService()

    func load() async {
        isLoading = true
        do {
            articles = try await service.fetchTopHeadlines()
        } catch {
            alertMessage = "Unable to fetch news."
        }
        isLoading = false
    }
}
