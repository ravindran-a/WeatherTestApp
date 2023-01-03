//
//  WeatherCoordinator.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

protocol WeatherNavigation: AnyObject {
    func launchWeatherInfoPage()
    func launchWeatherDetailPage(selectedCityName: String, selectedLocationMap: (String, String), selectedWeatherInfo: WeatherInfo, selectedTemperatureUnitIndex: Int)
}

class WeatherCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("Weather Coordinator Start")
        launchWeatherInfoPage()
    }
}

extension WeatherCoordinator: WeatherNavigation {
    func launchWeatherInfoPage() {
        let cities: [String] = ["New York", "Dallas", "Miami"]
        let location: [(String, String)] = [("40.71", "-74.01"), ("32.78", "-96.81"), ("25.77", "-80.19")]
        let viewModel: WeatherInfoViewModel = WeatherInfoViewModel(navigation: self, apiService: WeatherService(), cities: cities, locationMap: location)
        let controller: WeatherInfoViewController = WeatherInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func launchWeatherDetailPage(selectedCityName: String, selectedLocationMap: (String, String), selectedWeatherInfo: WeatherInfo, selectedTemperatureUnitIndex: Int) {
        let viewModel: WeatherDetailViewModel = WeatherDetailViewModel(navigation: self, apiService: WeatherService(), selectedCityName: selectedCityName, selectedLocationMap: selectedLocationMap, selectedWeatherInfo: selectedWeatherInfo, selectedTemperatureUnitIndex: selectedTemperatureUnitIndex)
        let controller: WeatherDetailViewController = WeatherDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
