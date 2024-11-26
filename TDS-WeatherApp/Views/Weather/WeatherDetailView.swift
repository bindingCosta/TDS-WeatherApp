//
//  WeatherDetailView.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 26/11/24.
//

import SwiftUI

// MARK: - Tela de Detalhes do Clima
struct WeatherDetailView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var city: City

    var body: some View {
        ZStack {
            // MARK: - Fundo Dinâmico
            if let weatherCondition = viewModel.weatherData?.weather.first?.main {
                getGradientBackground(for: weatherCondition.localizedWeatherCondition())
                    .ignoresSafeArea()
            }

            VStack {
                // MARK: - Verificação de condição climática
                let isSnowy = viewModel.weatherData?.weather.first?.main.localizedWeatherCondition() == "snowy"

                // MARK: - Botão de Voltar Personalizado
                HStack {
                    Button(action: { NavigationUtil.popView() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(isSnowy ? .black : .white)
                            .font(.system(size: 24, weight: .bold))
                    }
                    .padding()
                    Spacer()
                }

                // MARK: - Dados do Clima
                if let weatherData = viewModel.weatherData {
                    // Nome da cidade
                    Text(city.name.uppercased())
                        .font(Font.custom("Poppins", size: 40))
                        .foregroundColor(isSnowy ? .black : .white)
                        .padding(.top, -15)

                    // Condição climática
                    Text(weatherData.weather.first?.main.localizedWeatherCondition() ?? "Sem descrição")
                        .font(Font.custom("Poppins", size: 25))
                        .foregroundColor((isSnowy ? Color.black : .white).opacity(0.6))

                    // Temperatura principal
                    HStack {
                        Text("\(Int(weatherData.main.temp))")
                            .font(Font.custom("Poppins", size: 120))
                            .foregroundColor(isSnowy ? .black : .white)
                        VStack {
                            Text("ºC")
                                .font(Font.custom("Poppins", size: 25))
                                .foregroundColor(isSnowy ? .black : .white)
                                .padding(.bottom, 5)
                            HStack(spacing: 10) {
                                VStack(spacing: 5) {
                                    Image(systemName: "arrow.up") // Ícone para temperatura máxima
                                        .foregroundColor(isSnowy ? .black : .white)
                                    Image(systemName: "arrow.down") // Ícone para temperatura mínima
                                        .foregroundColor(isSnowy ? .black : .white)
                                }
                                .opacity(0.5)
                                VStack(spacing: 5) {
                                    Text("\(Int(weatherData.main.tempMax))º")
                                        .foregroundColor(isSnowy ? .black : .white)
                                    Text("\(Int(weatherData.main.tempMin))º")
                                        .foregroundColor(isSnowy ? .black : .white)
                                }
                            }
                        }
                    }
                    .padding(.top, -20)

                    // Ícone do clima
                    if let weather = weatherData.weather.first {
                        Image(systemName: getWeatherIcon(for: weather.main.localizedWeatherCondition()))
                            .font(.system(size: 130))
                            .foregroundColor(isSnowy ? .black : .white)
                    }

                    // Previsões Horárias
                    HStack(spacing: 20) {
                        let periods = ["dawn", "morning", "afternoon", "night"] // Períodos do dia
                        ForEach(periods, id: \.self) { period in
                            if let forecast = viewModel.hourlyForecasts.first(where: { getTimeOfDay(for: $0.dt) == period }) {
                                WeatherConditionView(
                                    timeOfDay: period,
                                    icon: getHourlyWeatherIcon(for: forecast.weather.first?.main ?? "cloud", timeOfDay: period),
                                    temperature: "\(Int(forecast.main.temp))ºC",
                                    color: isSnowy ? .black : .white
                                )
                            }
                        }
                    }
                    .padding(.top, 30)
                    .font(Font.custom("Poppins", size: 20))

                    Spacer()

                    // Informações adicionais
                    HStack(spacing: 25) {
                        WeatherInfoView(label: "wind speed", value: "\(weatherData.wind.speed) m/s", color: isSnowy ? .black : .white)
                        WeatherInfoView(label: "sunrise", value: formatTimestamp(weatherData.sys.sunrise), color: isSnowy ? .black : .white)
                        WeatherInfoView(label: "sunset", value: formatTimestamp(weatherData.sys.sunset), color: isSnowy ? .black : .white)
                        WeatherInfoView(label: "humidity", value: "\(weatherData.main.humidity)%", color: isSnowy ? .black : .white)
                    }
                    .padding(.top, 30)
                    .font(Font.custom("Poppins", size: 17))

                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.fetchWeatherData(for: city)
                await viewModel.fetchHourlyForecast(for: city)
            }
        }
    }

    // MARK: - Função para background dinâmico
    func getGradientBackground(for weather: String) -> LinearGradient {
        switch weather.lowercased() {
        case "sunny", "cloudy":
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 88/255, green: 202/255, blue: 220/255),
                Color(red: 59/255, green: 161/255, blue: 181/255)
            ]), startPoint: .top, endPoint: .bottom)
        case "rainy":
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 96/255, green: 105/255, blue: 120/255),
                Color(red: 61/255, green: 68/255, blue: 84/255)
            ]), startPoint: .top, endPoint: .bottom)
        case "snowy":
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 224/255, green: 224/255, blue: 224/255),
                Color(red: 167/255, green: 167/255, blue: 167/255)
            ]), startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(gradient: Gradient(colors: [
                Color.cyan, Color.blue
            ]), startPoint: .top, endPoint: .bottom)
        }
    }

    // MARK: - Função para Ícone do Clima
    func getWeatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case "sunny", "clear":
            return "sun.max"
        case "cloudy", "partly cloudy":
            return "cloud.sun"
        case "rainy", "drizzle", "thunderstorm":
            return "cloud.rain"
        case "snowy":
            return "cloud.snow"
        case "foggy":
            return "cloud.fog"
        default:
            return "cloud"
        }
    }

    // MARK: - Formatação de Timestamp
    func formatTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Exemplo: "5:14 AM"
        return formatter.string(from: date)
    }
}

// MARK: - Função para Ícones de Previsão Horária
func getHourlyWeatherIcon(for condition: String, timeOfDay: String) -> String {
    switch timeOfDay {
    case "dawn":
        return "sunrise" // Ícone de amanhecer
    case "morning":
        return "sun.max" // Ícone de sol
    case "afternoon":
        return "cloud.sun" // Ícone de sol com nuvem
    case "night":
        return "moon.stars" // Ícone de lua
    default:
        return "cloud"
    }
}

// MARK: - Função para Período do Dia
func getTimeOfDay(for timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let hour = Calendar.current.component(.hour, from: date)
    
    switch hour {
    case 5..<7:
        return "dawn"
    case 7..<12:
        return "morning"
    case 12..<17:
        return "afternoon"
    case 17..<20:
        return "evening"
    default:
        return "night"
    }
}

// MARK: - Extensão para Condições Climatológicas
extension String {
    func localizedWeatherCondition() -> String {
        switch self.lowercased() {
        case "clear", "clouds":
            return "sunny"
        case "rain", "drizzle":
            return "rainy"
        case "mist":
            return "misty"
        case "snow":
            return "snowy"
        default:
            return self.capitalized
        }
    }
}

// MARK: - Componentes Auxiliares Atualizados
struct WeatherConditionView: View {
    var timeOfDay: String
    var icon: String
    var temperature: String
    var color: Color

    var body: some View {
        VStack(spacing: 7) {
            Text(timeOfDay)
                .foregroundColor(color)
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
            Text(temperature)
                .foregroundColor(color)
        }
    }
}

struct WeatherInfoView: View {
    var label: String
    var value: String
    var color: Color

    var body: some View {
        VStack(spacing: 7) {
            Text(label)
                .foregroundColor(color)
            Text(value)
                .foregroundColor(color)
        }
    }
}

// MARK: - Preview
#Preview {
    WeatherDetailView(viewModel: WeatherViewModel(), city: City(name: "London", country: "GB", latitude: 51.5074, longitude: -0.1278))
}
