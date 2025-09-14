import SwiftUI

// MARK: - CachedImage View
struct CachedImage<Placeholder: View>: View {
    @State private var uiImage: UIImage? = nil
    let url: URL
    let placeholder: Placeholder

    // MARK: - Initializer
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
    }

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                placeholder
                    .onAppear {
                        ImageCacheManager.shared.load(url: url as NSURL) {
                            image in
                            self.uiImage = image
                        }
                    }
            }
        }
    }
}
