//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Benjamin Sabo on 12.09.2025..
//

import XCTest

@testable import NewsApp

func testNewsResponseParsing() throws {
    // 1. Sample JSON string
    let json = """
        {
            "articles": [
                {
                    "title": "Test Article",
                    "description": "This is a test description",
                    "urlToImage": "https://example.com/image.jpg",
                    "content": "Test content here",
                    "publishedAt": "2025-09-14T12:34:56Z",
                    "source": { "name": "Test Source" },
                    "author": "John Doe"
                }
            ]
        }
        """.data(using: .utf8)!

    // 2. Decode JSON into your model
    let decoder = JSONDecoder()
    let response = try decoder.decode(NewsResponse.self, from: json)

    // 3. Verify the results
    XCTAssertEqual(response.articles.count, 1)
    let article = response.articles.first
    XCTAssertEqual(article?.title, "Test Article")
    XCTAssertEqual(article?.description, "This is a test description")
    XCTAssertEqual(article?.urlToImage, "https://example.com/image.jpg")
    XCTAssertEqual(article?.content, "Test content here")
    XCTAssertEqual(article?.publishedAt, "2025-09-14T12:34:56Z")
    XCTAssertEqual(article?.source?.name, "Test Source")
    XCTAssertEqual(article?.author, "John Doe")
}
