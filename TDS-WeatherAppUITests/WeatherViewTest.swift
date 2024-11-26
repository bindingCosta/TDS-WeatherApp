//
//  WeatherViewTest.swift
//  TDS-WeatherAppUITests
//
//  Created by Marcelo Costa on 26/11/24.
//


import XCTest

class WeatherViewTests: XCTestCase {
    
    func testWeatherViewDisplaysCorrectly() {

        let latitude = 40.7128
        let longitude = -74.0060
        
        let app = XCUIApplication()
        app.launch()
        
        let cityLabel = app.staticTexts["New York"]
        XCTAssertTrue(cityLabel.exists, "A cidade deveria ser exibida como New York.")
        
        let tempLabel = app.staticTexts["Temp: 20°C"]
        XCTAssertTrue(tempLabel.exists, "A temperatura não está sendo exibida corretamente.")
        
    }
}
