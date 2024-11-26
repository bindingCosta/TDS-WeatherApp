//
//  City.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation

/// Representa uma cidade com suas coordenadas geográficas e nome do país.
struct City: Identifiable {
    var id = UUID()  
    var name: String
    var country: String
    var latitude: Double
    var longitude: Double
}
