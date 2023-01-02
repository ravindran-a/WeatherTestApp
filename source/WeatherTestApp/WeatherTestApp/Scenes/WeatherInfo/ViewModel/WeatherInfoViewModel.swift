//
//  WeatherInfoViewModel.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherInfoViewModel {
    weak var navigation: WeatherNavigation!
    var apiService: WeatherServiceProtocol!
    var cities: [String]!
    var locationMap: [(String, String)]!
    let temperatureUnits: [String] = ["fahrenheit", "celsius"]
    var callbackCounter: Int = 0
    var weatherInfo: [WeatherInfo] = []
    var selectedTemperatureUnitIndex: Int = 0
    
    func getWeatherData(refresh: Bool = false, completion: ((Error?) -> Void)? = nil) {
        if refresh {
            weatherInfo.removeAll()
            callbackCounter = 0
        }
        getCityWeatherData(callbackCounter) {[weak self] error in
            self?.callbackCounter += 1
            if self?.callbackCounter == self?.cities.count {
                self?.callbackCounter = 0
                completion?(error)
            } else {
                self?.getWeatherData(completion: completion)
            }
        }
    }
    
    func getCityWeatherData(_ index: Int, completion: ((Error?) -> Void)? = nil) {
        let location = locationMap[index]
        let temperatureUnit = temperatureUnits[selectedTemperatureUnitIndex]
        apiService.getCurrentWeatherData(latitude: location.0, longitude: location.1, temperatureUnit: temperatureUnit) { [weak self] data, error in
            guard let data = data, error == nil else {
                debugPrint(error!)
                completion?(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(WeatherInfo.self, from: data)
                self?.weatherInfo.append(model)
                completion?(nil)
            } catch let error {
                debugPrint(error)
                completion?(error)
            }
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
        let weatherData = weatherInfo[index]
        return WeatherHelper.getImageForWeatherCode(weatherData.currentWeather?.weathercode ?? 0)
    }
}
