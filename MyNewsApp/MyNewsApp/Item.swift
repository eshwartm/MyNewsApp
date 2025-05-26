//
//  Item.swift
//  MyNewsApp
//
//  Created by Eshwar Ramesh on 26/05/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
