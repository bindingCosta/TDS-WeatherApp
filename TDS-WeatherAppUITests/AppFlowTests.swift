//
//  AppFlowTests.swift
//  TDS-WeatherAppUITests
//
//  Created by Marcelo Costa on 26/11/24.
//

import XCTest

class AppFlowTests: XCTestCase {
    
    func testNavigateToWeatherDetails() {
        let app = XCUIApplication()
        app.launch()
        
        let cityCell = app.tables.cells.staticTexts["New York"]
        cityCell.tap()
        
        let cityDetailLabel = app.staticTexts["New York"]
        XCTAssertTrue(cityDetailLabel.exists, "A tela de detalhes não foi carregada corretamente.")
        
        let tempDetailLabel = app.staticTexts["Temp: 20°C"]
        XCTAssertTrue(tempDetailLabel.exists, "A temperatura não está sendo exibida corretamente na tela de detalhes.")
    }
}
