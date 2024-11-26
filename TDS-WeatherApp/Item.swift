//
//  Item.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
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
