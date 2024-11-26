//
//  WeatherManager.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import Foundation
import CoreLocation

/// Gerencia requisições à API de clima.
class WeatherManager {
    private let apiKey = "fcbb78d3e2d2350c8a58aa828a90137d"
    private let baseUrl = "https://api.openweathermap.org/data/2.5"
    private let session = URLSession.shared

    /// Obtém o clima atual com base em coordenadas geográficas.
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        let endpoint = "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        return try await fetch(from: endpoint)
    }
    
    /// Obtém a previsão do tempo detalhada para a localização fornecida.
    func getWeatherForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
        let endpoint = "/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        return try await fetch(from: endpoint)
    }
    
    /// Função genérica para requisições de rede e decodificação de JSON.
    /// - Throws: `WeatherError` em caso de falha na URL, resposta ou decodificação.
    private func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await session.data(for: URLRequest(url: url))
        
        // Verifica a resposta HTTP antes de decodificar.
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw WeatherError.decodingError
        }
    }
}

/// Estrutura para previsão detalhada de clima.
struct ForecastResponse: Decodable {
    var list: [ForecastItem]  // Itens de previsão (cada previsão por hora/dia)
    
    struct ForecastItem: Decodable {
        var dt: TimeInterval  // Data e hora da previsão
        var main: ResponseBody.MainResponse  // Dados principais (temperatura, etc.)
        var weather: [ResponseBody.WeatherResponse]  // Condições climáticas (chuva, neve, etc.)
    }
}

/// Enum para erros relacionados ao gerenciamento de clima.
enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

