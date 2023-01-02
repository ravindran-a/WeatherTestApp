//
//  WeatherHelper.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 19/12/22.
//

import Foundation
import UIKit

struct WeatherHelper {
    static func getImageForWeatherCode(_ code: Int) -> UIImage? {
        switch code {
        case 0:
            return UIImage(named: "icon_clear_sky")
        case 1, 2, 3:
            return UIImage(named: "icon_cloudy")
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            return UIImage(named: "icon_rain")
        case 45, 48:
            return UIImage(named: "icon_fog")
        case 71, 73, 75, 77, 85, 86:
            return UIImage(named: "icon_snow")
        case 95, 96, 99:
            return UIImage(named: "icon_thunderstorm")
        default:
            return nil
        }
    }
}
