import SwiftUI

struct DetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let imageUrl = article.urlToImage,
                   let url = URL(string: imageUrl) {
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 220)
                                    .frame(maxWidth: .infinity)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 220)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            case .failure:
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(height: 220)
                                    .frame(maxWidth: .infinity)
                            @unknown default:
                                EmptyView()
                            }
                        }

                        if let content = article.content, !content.isEmpty {
                            Text(content)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(6)
                                .padding([.leading, .bottom], 8)
                        }
                    }
                    .cornerRadius(8)
                }

                Text(article.title)
                    .font(.title2)
                    .bold()

                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                if let author = article.source?.name {
                    Text(author)
                        .font(.body)
                }
            }
            .padding(12)
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
    }
}
