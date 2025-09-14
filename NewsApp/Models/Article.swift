//
//  Article.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 14.09.2025..
//

import Foundation

// MARK: - Response from the news API
struct NewsResponse: Codable {
    let articles: [Article]
}

// MARK: - News Article
struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let urlToImage: String?
    let content: String?
    let publishedAt: String?
    let source: Source?
    let author: String?

    struct Source: Codable {
        let name: String?
    }
}
