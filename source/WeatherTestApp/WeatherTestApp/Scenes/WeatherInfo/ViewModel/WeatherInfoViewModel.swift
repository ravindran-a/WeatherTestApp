//
//  WeatherInfoViewModel.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherInfoViewModel {
    private var navigation: WeatherCoordinator!
    private var apiService: WeatherServiceProtocol!
    private var cities: [String]!
    private var locationMap: [(String, String)]!
    private let temperatureUnits: [String] = ["fahrenheit", "celsius"]
    private var callbackCounter: Int = 0
    private var weatherInfo: [WeatherInfo] = []
    private var selectedTemperatureUnitIndex: Int = 0
    
    init(navigation: WeatherCoordinator, apiService: WeatherServiceProtocol, cities: [String], locationMap: [(String, String)]) {
        self.navigation = navigation
        self.apiService = apiService
        self.cities = cities
        self.locationMap = locationMap
    }
    
    func getWeatherData(refresh: Bool = false) async throws {
        if refresh {
            weatherInfo.removeAll()
            callbackCounter = 0
        }
        try await getCityWeatherData(callbackCounter)
        self.callbackCounter += 1
        if self.callbackCounter == self.cities.count {
            self.callbackCounter = 0
        } else {
            try await self.getWeatherData()
        }
    }
    
    private func getCityWeatherData(_ index: Int) async throws {
        let location = locationMap[index]
        let temperatureUnit = temperatureUnits[selectedTemperatureUnitIndex]
        if let (data, _) = try await apiService.getCurrentWeatherData(latitude: location.0, longitude: location.1, temperatureUnit: temperatureUnit) {
            let model = try JSONDecoder().decode(WeatherInfo.self, from: data)
            self.weatherInfo.append(model)
        }
    }
    
    func getNumberOfRows() -> Int {
        return self.weatherInfo.count
    }
    
    func getCityName(_ index: Int) -> String {
        return self.cities[index]
    }
    
    func getWeatherInfo(_ index: Int) -> WeatherInfo {
        return self.weatherInfo[index]
    }
    
    func getCityTemperature(_ index: Int) -> String {
        let weatherData = weatherInfo[index]
        return "\(weatherData.currentWeather?.temperature ?? 00) \(selectedTemperatureUnitIndex == 0 ? "°F" : "°C")"
    }
    
    func gotoWeatherDetail(_ selectedWeatherInfoIndex: Int) {
        navigation.launchWeatherDetailPage(selectedCityName: getCityName(selectedWeatherInfoIndex), selectedLocationMap: self.locationMap[selectedWeatherInfoIndex], selectedWeatherInfo: getWeatherInfo(selectedWeatherInfoIndex), selectedTemperatureUnitIndex: selectedTemperatureUnitIndex)
    }
    
    func getCurrentWeatherIcon(_ index: Int) -> UIImage? {
        if index > weatherInfo.count {
            return nil
        }
        let weatherData = weatherInfo[index]
        return WeatherHelper.getImageForWeatherCode(weatherData.currentWeather?.weathercode ?? 0)
    }
    
    func updateTemperatureUnit(_ unit: Int) {
        self.selectedTemperatureUnitIndex = unit
    }
}
