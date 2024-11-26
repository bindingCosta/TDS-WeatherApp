//
//  HourlyForecastResponse.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation

struct HourlyForecastResponseWrapper: Decodable {
    let list: [HourlyForecast]
}
struct HourlyForecast: Decodable, Identifiable {
    let id = UUID()  // Identificador para uso no ForEach
    let dt: Int
    let main: MainData
    let weather: [Weather]
    
    /// Propriedade computada para formatar o horário.
    var formattedTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"  // Formato de 12 horas
        return formatter.string(from: date)
    }
    
    struct MainData: Decodable {
        let temp: Double
    }
    
    struct Weather: Decodable {
        let main: String
        let icon: String
    }
}

