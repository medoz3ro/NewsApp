//
//  AppConfig.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 14.09.2025..
//

import Foundation

enum AppConfig {
    static var newsApiKey: String {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let key = dict["NEWSAPI_KEY"] as? String else {
            fatalError("NEWSAPI_KEY not found")
        }
        return key
    }
}
