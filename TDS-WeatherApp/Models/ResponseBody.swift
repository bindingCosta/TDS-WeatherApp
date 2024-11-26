//
//  ResponseBody.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation

/// Estrutura que mapeia a resposta do clima retornada pela API.
struct ResponseBody: Decodable {
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
    var name: String
    var sys: SysResponse
    
    /// Submodel que descreve a condição climática.
    struct WeatherResponse: Decodable {
        var main: String
        var description: String
        var icon: String
    }
    
    /// Submodel para os dados principais do clima, como temperatura e umidade.
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
        
        // Propriedades convenientes para facilitar o acesso aos valores com nomes mais legíveis
        var feelsLike: Double { return feels_like }
        var tempMin: Double { return temp_min }
        var tempMax: Double { return temp_max }
    }
    
    /// Submodel que descreve os dados do vento, como a velocidade.
    struct WindResponse: Decodable {
        var speed: Double  
    }
    
    /// Submodel que descreve dados do sistema, como o horário do nascer e do pôr do sol.
    struct SysResponse: Decodable {
        var sunrise: Int
        var sunset: Int
    }
}

