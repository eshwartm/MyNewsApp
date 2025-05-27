//
//  RequestFactory.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import Foundation

enum Endpoint: String {
    case everything
    case topHeadlines = "top-headlines"
}

class RequestFactory {
    
    let configuration: URLSessionConfiguration = URLSessionConfiguration.default
    var urlString = RequestConfig.baseURL
    
    func makeTopHeadlinesRequest(
        method: RequestMethod,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil
    ) -> URLRequest?
    {
        urlString += "/"+Endpoint.topHeadlines.rawValue
        
        if let params = parameters {
            for (indx, (key, val)) in params.enumerated() {
                if indx == 0 {
                    urlString += "?\(key)=\(val)"
                }
                else {
                    urlString += "&\(key)=\(val)"
                }
            }
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = method.rawValue
        
        if let body,
           let jsonData = try? JSONSerialization.data(withJSONObject: body)
        {
            request.httpBody = jsonData
        }
        
        return request
    }
    
    func makeEverythingRequest(
        method: RequestMethod,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil) -> URLRequest?
    {
        
        urlString += "/"+Endpoint.everything.rawValue
        
        if let params = parameters {
            for (indx, (key, val)) in params.enumerated() {
                if indx == 0 {
                    urlString += "?\(key)=\(val)"
                }
                else {
                    urlString += "&\(key)=\(val)"
                }
            }
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = method.rawValue
        
        if let body,
           let jsonData = try? JSONSerialization.data(withJSONObject: body)
        {
            request.httpBody = jsonData
        }
        
        return request
    }
    
    func makeTopHeadlinesRequest(parameters: [String: Any]? = nil, body: [String: Any]? = nil) -> URLRequest? {
        
        urlString += "/" + Endpoint.topHeadlines.rawValue
        
        if let params = parameters {
            for (indx, (key, val)) in params.enumerated() {
                if indx == 0 {
                    urlString += "?\(key)=\(val)"
                }
                else {
                    urlString += "&\(key)=\(val)"
                }
            }
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = RequestMethod.get.rawValue
        
        if let body,
           let jsonData = try? JSONSerialization.data(withJSONObject: body)
        {
            request.httpBody = jsonData
        }
        
        return request
    }
}
