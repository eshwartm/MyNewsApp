//
//  NetworkManager.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import Foundation

class RequestConfig {
        
    static let baseURL = "https://newsapi.org/v2"
}

enum RequestMethod: String {
    case get
    case post
}

final class NetworkManager {
    
    class func getHeaders() -> [String: String] {
        return [
            "x-api-key": apiKey
        ]
    }
    
    class func request(
        request: URLRequest?,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) async throws -> Result<Data, Error>
    {
        guard var request = request else {
            let error = NSError(domain: "com.eshwar.newsapp", code: 800, userInfo: ["description": "Could not frame the URL"])
            return .failure(error)
        }
        
        let urlSession = URLSession(configuration: .default)
        
        request.allHTTPHeaderFields = getHeaders()
        
        print("request headers : \(String(describing: request.allHTTPHeaderFields))")
        
        if let body,
           let jsonData = try? JSONSerialization.data(withJSONObject: body)
        {
            request.httpBody = jsonData
        }
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            return .success(data)
        }
        catch {
            print("Error : \(error)")
            return .failure(error)
        }
    }
}
