//
//  WeatherDetailViewModelTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 02/01/23.
//

import XCTest
import WeatherTestApp

final class WeatherDetailViewModelTest: XCTestCase {

    var coordinator: WeatherCoordinator!
    var viewModel: WeatherDetailViewModel!
    var controller: WeatherDetailViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let info = WeatherInfo(latitude: 40.710335, longitude: -73.99307, generationtimeMS: 0.3249645233154297, utcOffsetSeconds: 0, timezone: "GMT",
                               timezoneAbbreviation: "GMT", elevation: 27,
                               currentWeather: CurrentWeather(temperature: 55.6, windspeed: 7.9, winddirection: 254, weathercode: 0,
                                                              time: "2023-01-02T19:00"),
                               hourlyUnits: nil, hourly: nil)
        coordinator = WeatherCoordinator(UINavigationController())
        viewModel = WeatherDetailViewModel(navigation: coordinator, apiService: WeatherService(), selectedCityName: "New York", selectedLocationMap: ("40.71", "-74.01"), selectedWeatherInfo: info, selectedTemperatureUnitIndex: 0)
        controller = WeatherDetailViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetWeatherDetailData() async throws {
        try? await viewModel.getWeatherDetailData()
        try? await viewModel.getWeatherDetailData(refresh: true)
    }
    
    func testGenericMethods() async throws {
        try? await viewModel.getWeatherDetailData()
        XCTAssertNotNil(viewModel.getTime(0))
        XCTAssertNotNil(viewModel.getTemperature(0))
        XCTAssertNotNil(viewModel.getCityName())
        XCTAssertNotNil(viewModel.getNumberOfRows())
        XCTAssertNotNil(viewModel.getWeatherData())
        XCTAssertNotNil(viewModel.getCityTemperature())
        XCTAssertNotNil(viewModel.getCurrentWeatherIcon())
    }

}
