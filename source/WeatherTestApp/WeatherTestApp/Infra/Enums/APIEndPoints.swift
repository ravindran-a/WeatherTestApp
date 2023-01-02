//
//  APIEndPoints.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

struct APIEndPoints {
    
    static let API_BASE_URL: String = "https://api.open-meteo.com/v1/"

    enum WeatherData {
        case weatherInfo(latitude: String, longitude: String, temperatureUnit: String)
        case weatherDetail(latitude: String, longitude: String, temperatureUnit: String, startDate: String, endDate: String)
        
        var url: String {
            switch self {
            case .weatherInfo(let latitude, let longitude, let temperatureUnit):
                return "forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&temperature_unit=\(temperatureUnit)"
            case .weatherDetail(let latitude, let longitude, let temperatureUnit, let startDate, let endDate):
                return "forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&hourly=temperature_2m,rain&temperature_unit=\(temperatureUnit)&start_date=\(startDate)&end_date=\(endDate)"
            }
        }
    }
    
}
