//
//  NewsItem.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import Foundation
import SwiftData

final class NewsItem: Codable, Identifiable {
    let id: UUID
    var title: String
    var description: String?
    var author: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, author, content
    }
    
    init(title: String, description: String? = nil, author: String? = nil, content: String? = nil) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.author = author
        self.content = content
    }
    
    // 👇 Custom decoding to auto-generate ID
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()  // 👈 Create new UUID
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }    
}


