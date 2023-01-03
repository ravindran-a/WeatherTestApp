//
//  MockWeatherService.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

class MockWeatherService: WeatherServiceProtocol {
    func getCurrentWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)? {
        return nil
    }
    
    func getDetailedWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)? {
        return nil
    }
}
