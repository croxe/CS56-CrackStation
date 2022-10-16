
import XCTest
@testable import MyLibrary
@testable import struct MyLibrary.Weather

final class WeatherServiceTests: XCTestCase {

    func testWeatherModelWithJson() throws {
        // Given
        let rawData = """
        {
            "main": {
            "temp": 19.0
            },
        }
        """.data(using: .utf8)!
        let number = 19.0

        // When
        let testingWeather: Weather = try JSONDecoder().decode(Weather.self, from: rawData)

        // Then
        XCTAssertNotNil(testingWeather)
        XCTAssert(testingWeather.main.temp == number )
    }

    func testWeatherModelWithParameters() throws {
        // Given        
        let number = 19.0
        
        // When
        let newWeather = Weather(main: Weather.Main(temp: 19.0))        

        // Then
        XCTAssertNotNil(newWeather)
        XCTAssert(newWeather.main.temp == number )
    }

    func testWeatherModelWithInit() throws {
        // Given
        let number = 19.0    
        
        // When
        let iniWeather = Weather(19.0)

        // Then
        XCTAssertNotNil(iniWeather)
        XCTAssert(iniWeather.main.temp == number )
    }
    
}