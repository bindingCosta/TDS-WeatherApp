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

                    let _ = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                    

                    DispatchQueue.main.async {
                        expectation.fulfill() 
                    }
                } catch {
                    XCTFail("Falha ao buscar os dados do clima: \(error)")
                    DispatchQueue.main.async {
                        expectation.fulfill() 
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
