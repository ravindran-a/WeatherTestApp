//
//  WeatherService.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    func getCurrentWeatherData(latitude: String, longitude: String, temperatureUnit: String, completion: ((Data?, Error?) -> Void)?) {
        let url = APIEndPoints.WeatherData.weatherInfo(latitude: latitude, longitude: longitude, temperatureUnit: temperatureUnit).url
        ApiManager.shared.request(serviceURL: url) { data, error in
            completion?(data, error)
        }
    }
    
    func getDetailedWeatherData(latitude: String, longitude: String, temperatureUnit: String, completion: ((Data?, Error?) -> Void)?) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        let url = APIEndPoints.WeatherData.weatherDetail(latitude: latitude, longitude: longitude, temperatureUnit: temperatureUnit,
                                                         startDate: dateString, endDate: dateString).url
        ApiManager.shared.request(serviceURL: url) { data, error in
            completion?(data, error)
        }
    }
}
