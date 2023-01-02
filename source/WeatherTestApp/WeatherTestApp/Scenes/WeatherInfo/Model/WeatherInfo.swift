//
//  WeatherInfo.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 19/12/22.
//

import Foundation

struct WeatherInfo: Codable {
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let currentWeather: CurrentWeather?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

struct CurrentWeather: Codable {
    let temperature, windspeed: Double?
    let winddirection, weathercode: Int?
    let time: String?
}

struct Hourly: Codable {
    let time: [String]?
    let temperature2M, rain: [Double]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain
    }
}

struct HourlyUnits: Codable {
    let time, temperature2M, rain: String?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain
    }
}
