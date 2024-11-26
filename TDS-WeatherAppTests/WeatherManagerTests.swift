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
    
    func testWeatherConditions() {
        let jsonData = """
        {
            "weather": [{"main": "Clear", "description": "Clear sky", "icon": "01d"}],
            "main": {"temp": 25.0, "feels_like": 24.0, "temp_min": 22.0, "temp_max": 27.0, "humidity": 60.0},
            "wind": {"speed": 3.5},
            "name": "Test City",
            "sys": {"sunrise": 1638231234, "sunset": 1638271234}
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(ResponseBody.self, from: jsonData)
            XCTAssertEqual(weather.weather.first?.main, "Clear", "O clima deveria ser 'Clear'.")
            
            // Teste para clima rain
            let jsonRainData = """
            {
                "weather": [{"main": "Rain", "description": "Light rain", "icon": "10d"}],
                "main": {"temp": 22.0, "feels_like": 21.0, "temp_min": 19.0, "temp_max": 24.0, "humidity": 80.0},
                "wind": {"speed": 4.0},
                "name": "Test City",
                "sys": {"sunrise": 1638231234, "sunset": 1638271234}
            }
            """.data(using: .utf8)!
            
            let rainWeather = try decoder.decode(ResponseBody.self, from: jsonRainData)
            XCTAssertEqual(rainWeather.weather.first?.main, "Rain", "O clima deveria ser 'Rain'.")
        } catch {
            XCTFail("Erro ao decodificar os dados: \(error)")
        }
    }
}
