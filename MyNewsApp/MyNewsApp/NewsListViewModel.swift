//
//  NewsListViewModel.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import Foundation
import SwiftUI

struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [NewsItem]?
}


class NewsListViewModel: ObservableObject {
    
    @Published var newsList: [NewsItem]? = nil
    @Published var errorMessage: String = ""
    
    init(newsList: [NewsItem]? = nil) {
        self.newsList = newsList
    }
    
    func createEverythingRequest(query: String) -> URLRequest? {
        guard let everythingRequest = RequestFactory().makeEverythingRequest(method: .get, parameters: ["q": query]) else {
            return nil
        }
        return everythingRequest
    }
    
    func createTopHeadlinesRequest() -> URLRequest? {
        guard let topHeadlinesRequest = RequestFactory().makeTopHeadlinesRequest(method: .get, parameters: ["country": "us"]) else {
            return nil
        }
        return topHeadlinesRequest
    }
    
    @MainActor
    func makeNetworkRequestForTopHeadlines() async {
        guard let request = createTopHeadlinesRequest() else { return }
        do {
            let result = try await NetworkManager.request(request: request)
            switch result {
            case .success(let data):
                do {
                    let newsItemList = try JSONDecoder().decode(NewsResponse.self, from: data)
                    self.newsList = newsItemList.articles
                }
                catch {
                    print("Error occurred during news request : \(error)")
                    errorMessage = error.localizedDescription
                }
            case .failure(let error):
                print("Error occurred during news request : \(error)")
                errorMessage = error.localizedDescription
            }
        }
        catch {
            print("Error occurred during news request : \(error)")
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func makeNetworkRequestForEverything(query: String = "default") async {
        guard let request = createEverythingRequest(query: query) else { return }
        do {
            let result = try await NetworkManager.request(request: request)
            switch result {
            case .success(let data):
                print("data: \(data)")
                do {
                    let newsItemList = try JSONDecoder().decode(NewsResponse.self, from: data)
                    self.newsList = newsItemList.articles
                }
                catch {
                    print("Error occurred during news request : \(error)")
                    errorMessage = error.localizedDescription
                }
                
            case .failure(let err):
                print("Error occurred during news request : \(err)")
                errorMessage = err.localizedDescription
            }
        }
        catch {
            print("Error occurred during news request : \(error)")
            errorMessage = error.localizedDescription
        }
    }
}
