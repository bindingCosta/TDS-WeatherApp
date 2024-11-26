//
//  City.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation

/// Representa uma cidade com suas coordenadas geográficas e nome do país.
struct City: Identifiable {
    var id = UUID()  // Identificador único para cada cidade
    var name: String  // Nome da cidade
    var country: String  // Nome do país
    var latitude: Double  // Latitude da cidade
    var longitude: Double  // Longitude da cidade
}
