//
//  ContentView.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import SwiftUI

enum NewsTab: String, CaseIterable, Identifiable {
    case everything = "Everything"
    case topHeadlines = "Top Headlines"
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    @StateObject var viewModel = NewsListViewModel()
    @State private var selectedTab: NewsTab = .everything
    @State private var queryString: String = ""
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 2) {
                HStack {
                    ForEach(NewsTab.allCases) { tab in
                        VStack(spacing: 4) {
                            Text(tab.rawValue)
                                .font(.headline)
                                .foregroundStyle(selectedTab == tab ? .blue : .gray)
                                .onTapGesture {
                                    selectedTab = tab
                                    
                                    if selectedTab == NewsTab.everything {
                                        Task {
                                            await viewModel.makeNetworkRequestForEverything()
                                        }
                                    } else {
                                        Task {
                                            await viewModel.makeNetworkRequestForTopHeadlines()
                                        }
                                    }
                                }
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(selectedTab == tab ? .blue : .clear)
                        }
                    }
                }
            }
            
            if selectedTab == .everything {
                VStack {
                    TextField("Search...", text: $queryString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if let newsList = viewModel.newsList {
                        List(newsList, id: \.id) { news in
                            Text(news.title)
                        }
                        .navigationTitle("News")
                    }
                    else {
                        ProgressView("Loading news...")
                            .navigationTitle("News")
                    }
                }
                .navigationTitle("Everything")
            } else if selectedTab == .topHeadlines {
                if let newsList = viewModel.newsList {
                    List(newsList, id: \.id) { news in
                        Text(news.title)
                    }
                    .navigationTitle("News")
                }
                else {
                    ProgressView("Loading news...")
                        .navigationTitle("News")
                }
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            await viewModel.makeNetworkRequestForEverything(query: queryString)
        }
    }
}

#Preview {
    ContentView()
}
