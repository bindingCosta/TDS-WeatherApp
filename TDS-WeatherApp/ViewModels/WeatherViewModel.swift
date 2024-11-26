//
//  WeatherViewModel.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 26/11/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: ResponseBody? // Dados do clima atual
    @Published var hourlyForecasts: [HourlyForecast] = [] // Previsões horárias

    /// Busca os dados climáticos para a cidade.
    func fetchWeatherData(for city: City) async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(city.latitude)&lon=\(city.longitude)&appid=fcbb78d3e2d2350c8a58aa828a90137d&units=metric") else {
            print("URL inválida para os dados do clima atual.")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            DispatchQueue.main.async {
                self.weatherData = decodedData
            }
        } catch {
            print("Erro ao buscar dados do clima atual: \(error.localizedDescription)")
        }
    }

    /// Busca a previsão horária para a cidade.
    func fetchHourlyForecast(for city: City) async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(city.latitude)&lon=\(city.longitude)&appid=fcbb78d3e2d2350c8a58aa828a90137d&units=metric") else {
            print("URL inválida para a previsão horária.")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(HourlyForecastResponseWrapper.self, from: data)
            DispatchQueue.main.async {
                self.hourlyForecasts = decodedData.list
            }
        } catch {
            print("Erro ao buscar previsão horária: \(error.localizedDescription)")
        }
    }
}

