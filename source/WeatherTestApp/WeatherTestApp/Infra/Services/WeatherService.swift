//
//  WeatherService.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    func getCurrentWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)? {
        let url = APIEndPoints.WeatherData.weatherInfo(latitude: latitude, longitude: longitude, temperatureUnit: temperatureUnit).url
        return try await ApiManager.shared.request(serviceURL: url)
    }
    
    func getDetailedWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        let url = APIEndPoints.WeatherData.weatherDetail(latitude: latitude, longitude: longitude, temperatureUnit: temperatureUnit,
                                                         startDate: dateString, endDate: dateString).url
        return try await ApiManager.shared.request(serviceURL: url)
    }
}
