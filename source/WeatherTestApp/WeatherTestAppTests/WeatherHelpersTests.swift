//
//  WeatherHelpersTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 03/01/23.
//

import XCTest

final class WeatherHelpersTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherCodes() throws {
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(0))
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(1))
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(51))
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(45))
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(71))
        XCTAssertNotNil(WeatherHelper.getImageForWeatherCode(95))
        XCTAssertNil(WeatherHelper.getImageForWeatherCode(100))
    }
    
}
