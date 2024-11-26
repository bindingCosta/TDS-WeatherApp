//
//  ResponseBody.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation

/// Estrutura que mapeia a resposta do clima retornada pela API.
struct ResponseBody: Decodable {
    var weather: [WeatherResponse]  // Lista de condições climáticas (ex: chuva, sol)
    var main: MainResponse  // Dados principais sobre o clima (temperatura, umidade)
    var wind: WindResponse  // Dados sobre o vento
    var name: String  // Nome da cidade (útil para exibição ou localização futura)
    var sys: SysResponse  // Dados adicionais do sistema, como sunrise e sunset
    
    /// Submodel que descreve a condição climática.
    struct WeatherResponse: Decodable {
        var main: String  // Tipo de clima (ex: "Clear", "Rain")
        var description: String  // Descrição detalhada (ex: "Céu limpo", "Chuva leve")
        var icon: String  // Ícone representando o clima (usado para exibição gráfica)
    }
    
    /// Submodel para os dados principais do clima, como temperatura e umidade.
    struct MainResponse: Decodable {
        var temp: Double  // Temperatura atual
        var feels_like: Double  // Temperatura percebida (sensação térmica)
        var temp_min: Double  // Temperatura mínima
        var temp_max: Double  // Temperatura máxima
        var humidity: Double  // Umidade do ar
        
        // Propriedades convenientes para facilitar o acesso aos valores com nomes mais legíveis
        var feelsLike: Double { return feels_like }
        var tempMin: Double { return temp_min }
        var tempMax: Double { return temp_max }
    }
    
    /// Submodel que descreve os dados do vento, como a velocidade.
    struct WindResponse: Decodable {
        var speed: Double  // Velocidade do vento em metros por segundo
    }
    
    /// Submodel que descreve dados do sistema, como o horário do nascer e do pôr do sol.
    struct SysResponse: Decodable {
        var sunrise: Int  // Timestamp UNIX do nascer do sol
        var sunset: Int   // Timestamp UNIX do pôr do sol
    }
}

