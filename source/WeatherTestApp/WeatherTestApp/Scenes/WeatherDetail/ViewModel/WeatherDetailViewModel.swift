//
//  WeatherDetailViewModel.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class WeatherDetailViewModel {
    private weak var navigation: WeatherNavigation!
    private var apiService: WeatherServiceProtocol!
    private var selectedCityName: String!
    private var selectedLocationMap: (String, String)!
    private var selectedWeatherInfo: WeatherInfo!
    private let temperatureUnits: [String] = ["fahrenheit", "celsius"]
    private var selectedTemperatureUnitIndex: Int = 0
    
    init(navigation: WeatherNavigation, apiService: WeatherServiceProtocol, selectedCityName: String, selectedLocationMap: (String, String),
         selectedWeatherInfo: WeatherInfo, selectedTemperatureUnitIndex: Int) {
        self.navigation = navigation
        self.apiService = apiService
        self.selectedCityName = selectedCityName
        self.selectedLocationMap = selectedLocationMap
        self.selectedWeatherInfo = selectedWeatherInfo
        self.selectedTemperatureUnitIndex = selectedTemperatureUnitIndex
    }
    
    func getWeatherDetailData(refresh: Bool = false) async throws {
        let temperatureUnit = temperatureUnits[selectedTemperatureUnitIndex]
        if let (data, _) = try await apiService.getDetailedWeatherData(latitude: selectedLocationMap.0, longitude: selectedLocationMap.1, temperatureUnit: temperatureUnit) {
            let model = try JSONDecoder().decode(WeatherInfo.self, from: data)
            self.selectedWeatherInfo = model
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
