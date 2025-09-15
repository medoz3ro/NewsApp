//
//  DateExtensions.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 15.09.2025..
//
import SwiftUI

//MARK: - Date format beacuse it's used multiple times
extension DateFormatter {
    static let articleDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

extension ISO8601DateFormatter {
    static let shared = ISO8601DateFormatter()
}
