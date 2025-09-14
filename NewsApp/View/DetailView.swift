import SwiftUI

struct DetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                // IMAGE
                if let imageUrl = article.urlToImage,
                   let url = URL(string: imageUrl) {
                    ZStack(alignment: .bottomLeading) {
                        CachedImage(url: url) {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, minHeight: 120)
                        }
                        .frame(height: 220)
                        .clipped()
                        .cornerRadius(8)
                    }
                }
                
                // AUTHOR + DATE
                HStack(alignment: .center, spacing: 12) {
                    Image("NewsBanner")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(6)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        if let author = article.author, !author.isEmpty {
                            Text("Autor: \(author)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        
                        if let dateStr = article.publishedAt {
                            Text(formatDate(dateStr))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 4)
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                    .padding(.horizontal, 16)
                
                // TITLE
                Text(article.title)
                    .font(.title2)
                    .bold()
                    .padding(8)
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                    .padding(.horizontal, 16)
                
                // CONTENT
                if let content = article.content {
                    ForEach(processContent(content), id: \.self) { paragraph in
                        Text(paragraph)
                            .font(.body)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 6)
                    }
                }
            }
            .padding(12)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


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

private func processContent(_ content: String) -> [String] {
    let pattern = #"\[\+\d+\schars\]"#
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return [content]
    }
    
    let nsrange = NSRange(content.startIndex..<content.endIndex, in: content)
    let cleaned = regex.stringByReplacingMatches(in: content, options: [], range: nsrange, withTemplate: "")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    
    var paragraphs: [String] = []
    if !cleaned.isEmpty {
        paragraphs.append(cleaned)
    }
    
    let extra = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "Curabitur non nulla sit amet nisl tempus convallis quis ac lectus."
    ]
    
    let count = Int.random(in: 3...5)
    paragraphs.append(contentsOf: extra.prefix(count))
    
    return paragraphs
}
