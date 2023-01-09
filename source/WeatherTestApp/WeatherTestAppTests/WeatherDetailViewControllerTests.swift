//
//  WeatherDetailViewControllerTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest
@testable import WeatherTestApp

final class WeatherDetailViewControllerTests: XCTestCase {

    var coordinator: WeatherCoordinator!
    var viewModel: WeatherDetailViewModel!
    var controller: WeatherDetailViewController!
    var apiService: WeatherServiceProtocol!
    
    override func setUpWithError() throws {
        let info = WeatherInfo(latitude: 40.710335, longitude: -73.99307, generationtimeMS: 0.3249645233154297, utcOffsetSeconds: 0, timezone: "GMT",
                               timezoneAbbreviation: "GMT", elevation: 27,
                               currentWeather: CurrentWeather(temperature: 55.6, windspeed: 7.9, winddirection: 254, weathercode: 0,
                                                              time: "2023-01-02T19:00"),
                               hourlyUnits: nil, hourly: nil)
        coordinator = WeatherCoordinator(UINavigationController())
        apiService = MockWeatherService()
        viewModel = WeatherDetailViewModel(navigation: coordinator, apiService: apiService, selectedCityName: "New York", selectedLocationMap: ("40.71", "-74.01"), selectedWeatherInfo: info, selectedTemperatureUnitIndex: 0)
        controller = WeatherDetailViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        apiService = nil
        controller = nil
        viewModel = nil
    }

    func testController() {
        controller.viewDidLoad()
    }
    
}
