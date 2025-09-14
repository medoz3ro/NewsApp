//
//  ArticleRow.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 14.09.2025..
//

import SwiftUI

struct ArticleRow: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = article.urlToImage,
                let url = URL(string: imageUrl)
            {
                CachedImage(url: url) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, minHeight: 120)
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .cornerRadius(8)
            }

            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)

            if let desc = article.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack {
                if let sourceName = article.source?.name {
                    Text(sourceName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                if let dateStr = article.publishedAt {
                    Text(formatDate(dateStr))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    //MARK: - Converts date string to a user-friendly format
    private func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: isoDate) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return isoDate
    }
}

// MARK: - Preview
struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(
            article: Article(
                title: "Sample Headline",
                description:
                    "This is a short description of the news article to show layout.",
                urlToImage: "https://via.placeholder.com/300",
                content: nil,
                publishedAt: "2025-09-14T12:34:56Z",
                source: Article.Source(name: "News Source"),
                author: "John Doe"
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
