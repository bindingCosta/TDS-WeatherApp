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
    let id = UUID()  // Identificador único para uso no ForEach
    let dt: Int  // Timestamp UNIX do horário da previsão
    let main: MainData  // Dados principais (temperatura, umidade, etc.)
    let weather: [Weather]  // Lista de condições climáticas para esse horário
    
    /// Propriedade computada para formatar o horário.
    var formattedTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"  // Formato de 12 horas (ex.: 3 PM)
        return formatter.string(from: date)
    }
    
    struct MainData: Decodable {
        let temp: Double  // Temperatura
    }
    
    struct Weather: Decodable {
        let main: String  // Tipo de clima (ex.: Clear, Rain)
        let icon: String  // Ícone representando o clima
    }
}

