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
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(vm.articles) { article in
                        NavigationLink(
                            destination: DetailView(article: article)
                        ) {
                            ArticleRow(article: article)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("NEWS TODAY")
            .refreshable { await vm.load() }
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
        }
        .task { await vm.load() }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
