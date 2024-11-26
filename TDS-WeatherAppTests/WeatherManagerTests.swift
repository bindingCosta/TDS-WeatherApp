import XCTest
@testable import TDS_WeatherApp

class WeatherManagerTests: XCTestCase {
    
    var weatherManager: WeatherManager!
    
    override func setUp() {
        super.setUp()
        weatherManager = WeatherManager()
    }

    override func tearDown() {
        weatherManager = nil
        super.tearDown()
    }

    func testGetCurrentWeather() async {

        let latitude = 40.7128
        let longitude = -74.0060
        
        do {

            let weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
            
            XCTAssertNotNil(weather, "O clima retornado não deve ser nulo.")

            XCTAssertEqual(weather.name, "New York", "A cidade retornada deve ser New York.")
        } catch {
            XCTFail("Erro ao buscar os dados do clima: \(error.localizedDescription)")
        }
    }
}
