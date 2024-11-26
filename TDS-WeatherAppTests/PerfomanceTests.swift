import XCTest
@testable import TDS_WeatherApp

class PerformanceTests: XCTestCase {
    
    func testWeatherDataFetchPerformance() {
        let weatherManager = WeatherManager()
        let latitude = 40.7128
        let longitude = -74.0060
        
        let expectation = self.expectation(description: "Fetch weather data")
        
        measure {

            Task {
                do {
                    // Espera pela execução da função assíncrona
                    let _ = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                    
                    // Chama a expectativa após a conclusão do código assíncrono
                    DispatchQueue.main.async {
                        expectation.fulfill() // Marca a expectativa como cumprida
                    }
                } catch {
                    XCTFail("Falha ao buscar os dados do clima: \(error)")
                    DispatchQueue.main.async {
                        expectation.fulfill() // Marca a expectativa como cumprida em caso de erro também
                    }
                }
            }
        }
        
        // Espera pela expectativa ser cumprida dentro do tempo limite
        waitForExpectations(timeout: 10, handler: nil)
    }
}
