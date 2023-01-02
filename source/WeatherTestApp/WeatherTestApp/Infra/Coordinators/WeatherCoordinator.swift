//
//  WeatherCoordinator.swift
//  SysvineWeatherApp
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
        let controller: WeatherInfoViewController = WeatherInfoViewController()
        let viewModel: WeatherInfoViewModel = WeatherInfoViewModel()
        let cities: [String] = ["New York", "Dallas", "Miami"]
        let location: [(String, String)] = [("40.71", "-74.01"), ("32.78", "-96.81"), ("25.77", "-80.19")]
        viewModel.cities = cities
        viewModel.locationMap = location
        viewModel.navigation = self
        viewModel.apiService = WeatherService()
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    func launchWeatherDetailPage(selectedCityName: String, selectedLocationMap: (String, String), selectedWeatherInfo: WeatherInfo, selectedTemperatureUnitIndex: Int) {
        let controller: WeatherDetailViewController = WeatherDetailViewController()
        let viewModel: WeatherDetailViewModel = WeatherDetailViewModel()
        viewModel.apiService = WeatherService()
        viewModel.selectedCityName = selectedCityName
        viewModel.selectedLocationMap = selectedLocationMap
        viewModel.selectedWeatherInfo = selectedWeatherInfo
        viewModel.selectedTemperatureUnitIndex = selectedTemperatureUnitIndex
        viewModel.navigation = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}
