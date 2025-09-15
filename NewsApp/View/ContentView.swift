//
//  ContentView.swift
//  NewsApp
//
//  Created by Benjamin Sabo on 12.09.2025..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = NewsListViewModel()

    var body: some View {
        NavigationStack {
            List(vm.articles) { article in
                NavigationLink(destination: DetailView(article: article)) {
                    ArticleRow(article: article)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
            .refreshable {
                await vm.load(isRefreshing: true)
            }
            .overlay {
                if vm.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(item: $vm.apiError) { apiError in
                Alert(
                    title: Text(apiError.title),
                    message: Text(apiError.description),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("NEWS TODAY")
            .task { await vm.load() }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
