//
//  WeatherHelpers.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 26/11/24.
//

import SwiftUI

// MARK: - Funções auxiliares para ícones e formatação de clima

/// Retorna o ícone apropriado para a condição climática.
func getWeatherIcon(for condition: String) -> String {
    switch condition.lowercased() {
    case "sunny", "clear": return "sun.max"
    case "cloudy", "partly cloudy": return "cloud.sun"
    case "rainy", "drizzle", "thunderstorm": return "cloud.rain"
    case "snowy": return "cloud.snow"
    case "foggy": return "cloud.fog"
    default: return "cloud"
    }
}

/// Retorna o gradiente de fundo baseado na condição climática.
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

/// Formata o timestamp para exibir a hora do nascer ou pôr do sol.
func formatTimestamp(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a" // Exibe como "5:14 AM"
    return formatter.string(from: date)
}

/// Retorna o ícone apropriado para as previsões horárias.
func getHourlyWeatherIcon(for condition: String, timeOfDay: String) -> String {
    switch timeOfDay {
    case "dawn": return "sunrise"
    case "morning": return "sun.max"
    case "afternoon": return "cloud.sun"
    case "night": return "moon.stars"
    default: return "cloud"
    }
}

/// Determina o período do dia baseado no horário (amanhecer, manhã, etc).
func getTimeOfDay(for timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    switch hour {
    case 5..<7: return "dawn"
    case 7..<12: return "morning"
    case 12..<17: return "afternoon"
    case 17..<20: return "evening"
    default: return "night"
    }
}
