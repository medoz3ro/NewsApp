
import SwiftUI

struct DetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = article.urlToImage,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image): image.resizable().scaledToFill().frame(maxWidth: .infinity).clipped()
                        case .failure: Rectangle().foregroundColor(.gray)
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(height: 200)
                }

                Text(article.title).font(.title).bold()
                if let content = article.content { Text(content).font(.body) }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
