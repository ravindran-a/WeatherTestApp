//
//  WeatherDetailViewModel.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherDetailViewModel {
    weak var navigation: WeatherNavigation!
    var apiService: WeatherServiceProtocol!
    let temperatureUnits: [String] = ["fahrenheit", "celsius"]
    var selectedCityName: String!
    var selectedLocationMap: (String, String)!
    var selectedWeatherInfo: WeatherInfo!
    var selectedTemperatureUnitIndex: Int = 0
    
    func getWeatherDetailData(refresh: Bool = false, completion: ((Error?) -> Void)? = nil) {
        let temperatureUnit = temperatureUnits[selectedTemperatureUnitIndex]
        apiService.getDetailedWeatherData(latitude: selectedLocationMap.0, longitude: selectedLocationMap.1, temperatureUnit: temperatureUnit) { [weak self] data, error in
            guard let data = data, error == nil else {
                debugPrint(error!)
                completion?(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(WeatherInfo.self, from: data)
                self?.selectedWeatherInfo = model
                completion?(nil)
            } catch let error {
                debugPrint(error)
                completion?(error)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return self.selectedWeatherInfo.hourly?.time?.count ?? 0
    }
    
    func getTime(_ index: Int) -> String {
        let time = self.selectedWeatherInfo.hourly?.time?[index] ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = dateFormatter.date(from: time) ?? Date()
        dateFormatter.dateFormat = "hh:mm aa"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getTemperature(_ index: Int) -> String {
        return "\(self.selectedWeatherInfo.hourly?.temperature2M?[index] ?? 00) \(selectedTemperatureUnitIndex == 0 ? "°F" : "°C")"
    }
    
    func getWeatherData() -> WeatherInfo {
        return self.selectedWeatherInfo
    }
    
    func getCityName() -> String {
        return self.selectedCityName
    }
    
    func getCityTemperature() -> String {
        return "\(selectedWeatherInfo.currentWeather?.temperature ?? 00) \(selectedTemperatureUnitIndex == 0 ? "°F" : "°C")"
    }
    
    func getCurrentWeatherIcon() -> UIImage? {
        return WeatherHelper.getImageForWeatherCode(selectedWeatherInfo.currentWeather?.weathercode ?? 0)
    }
}
