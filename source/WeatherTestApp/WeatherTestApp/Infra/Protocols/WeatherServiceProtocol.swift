//
//  WeatherServiceProtocol.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

protocol WeatherServiceProtocol {
    func getCurrentWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)?
    func getDetailedWeatherData(latitude: String, longitude: String, temperatureUnit: String) async throws -> (Data, URLResponse)?
}
