//
//  WeatherInfoViewModelTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 02/01/23.
//

import XCTest
@testable import WeatherTestApp

final class WeatherInfoViewModelTests: XCTestCase {
    
    let cities: [String] = ["New York", "Dallas", "Miami"]
    let location: [(String, String)] = [("40.71", "-74.01"), ("32.78", "-96.81"), ("25.77", "-80.19")]
    var coordinator: WeatherCoordinator!
    var viewModel: WeatherInfoViewModel!
    var controller: WeatherInfoViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinator = WeatherCoordinator(UINavigationController())
        viewModel = WeatherInfoViewModel(navigation: coordinator, apiService: WeatherService(), cities: cities, locationMap: location)
        controller = WeatherInfoViewController(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetWeatherData() async throws {
        XCTAssertTrue(viewModel.isNetworkAvailable())
        try? await viewModel.getWeatherData()
        XCTAssertNotNil(viewModel.getWeatherInfo(0))
        try? await viewModel.getWeatherData(refresh: true)
        XCTAssertNotNil(viewModel.getWeatherInfo(0))
    }
    
    func testWeatherInfo() async throws {
        try? await viewModel.getWeatherData()
        XCTAssertNotNil(viewModel.getWeatherInfo(0))
    }
    
    func testGenericMethods() async throws {
        viewModel.updateTemperatureUnit(0)
        viewModel.updateTemperatureUnit(1)
        try? await viewModel.getWeatherData()
        XCTAssertNotNil(viewModel.getCurrentWeatherIcon(0))
        XCTAssertNil(viewModel.getCurrentWeatherIcon(100))
        XCTAssertNotNil(viewModel.getCityName(0))
        XCTAssertNotNil(viewModel.getWeatherInfo(0))
        XCTAssertNotNil(viewModel.getCityTemperature(0))
    }
}
