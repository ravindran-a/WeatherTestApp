//
//  WeatherInfoViewControllerTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest

final class WeatherInfoViewControllerTests: XCTestCase {

    let cities: [String] = ["New York", "Dallas", "Miami"]
    let location: [(String, String)] = [("40.71", "-74.01"), ("32.78", "-96.81"), ("25.77", "-80.19")]
    var coordinator: WeatherCoordinator!
    var viewModel: WeatherInfoViewModel!
    var controller: WeatherInfoViewController!
    var apiService: WeatherServiceProtocol!
    
    override func setUpWithError() throws {
        coordinator = WeatherCoordinator(UINavigationController())
        apiService = MockWeatherService()
        viewModel = WeatherInfoViewModel(navigation: coordinator, apiService: apiService, cities: cities, locationMap: location)
        controller = WeatherInfoViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        controller = nil
        coordinator = nil
        apiService = nil
    }
    
    func testController() {
        controller.viewDidLoad()
    }

}
