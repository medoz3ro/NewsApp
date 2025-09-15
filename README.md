# NewsApp

**NewsApp** is a SwiftUI iOS app that fetches the latest news from a free news API and displays them in a user-friendly interface. The app demonstrates asynchronous data fetching, image caching, error handling, and MVVM architecture.

---

## Features

* **Data Fetching:** Fetches news articles asynchronously from a free API (News API).
* **Parsing:** JSON data is decoded into Swift structs (`Article`, `NewsResponse`).
* **List Display:** Shows a list of news with title, description, source, and published date.
* **Detail View:** Tap an article to see full content and image.

### Bonus Features

* **Image Caching:** Uses `NSCache` to cache images for better performance.
* **Error Handling:** Displays user-friendly alerts for network or API errors.
* **Pull-to-Refresh:** Reload news by pulling down the list.
* **Unit Testing:** Includes a simple test to verify JSON parsing.

---

## Setup

1. Clone the repository and open `NewsApp.xcodeproj` in Xcode.
2. Add `Secrets.plist` with your News API key:

```xml
<key>NEWSAPI_KEY</key>
<string>YOUR_API_KEY_HERE</string>
```

3. Run the app on a simulator or device.

---

## Architecture

* **MVVM:** `Model` (Article), `ViewModel` (NewsListViewModel), `View` (ContentView, DetailView).
* **Utilities:** NetworkService, CachedImage, ImageCacheManager, shared Date formatters.

---
