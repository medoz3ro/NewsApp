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
            List(vm.articles) { article in
                NavigationLink(destination: DetailView(article: article)) {
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline)
                        if let desc = article.description {
                            Text(desc)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .navigationTitle("Top Headlines")
            .refreshable { await vm.load() }
            .overlay { if vm.isLoading { ProgressView("Loading...") } }
            .alert(isPresented: Binding(get: { vm.alertMessage != nil }, set: { _ in vm.alertMessage = nil })) {
                Alert(title: Text("Error"), message: Text(vm.alertMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
        .task { await vm.load() }
    }
}
