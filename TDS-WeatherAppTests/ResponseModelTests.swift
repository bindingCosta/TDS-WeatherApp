//
//  ResponseModelTests.swift
//  TDS-WeatherAppTests
//
//  Created by Marcelo Costa on 26/11/24.
//

import XCTest
@testable import TDS_WeatherApp

class ResponseModelTests: XCTestCase {
    
    func testWeatherModelDecoding() {
        let json = """
        {
            "weather": [{"main": "Clear", "description": "Céu limpo", "icon": "01d"}],
            "main": {"temp": 25.0, "feels_like": 27.0, "temp_min": 22.0, "temp_max": 28.0, "humidity": 60},
            "wind": {"speed": 5.0},
            "name": "Rio de Janeiro",
            "sys": {"sunrise": 1625112000, "sunset": 1625164800}
        }
        """
        
        let data = json.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseBody.self, from: data)
            
            XCTAssertEqual(response.name, "Rio de Janeiro", "O nome da cidade deveria ser Rio de Janeiro.")
            XCTAssertEqual(response.weather.first?.main, "Clear", "O clima principal deveria ser Clear.")
            XCTAssertEqual(response.main.temp, 25.0, "A temperatura deveria ser 25.0°C.")
        } catch {
            XCTFail("Erro ao decodificar o modelo: \(error)")
        }
    }
}
