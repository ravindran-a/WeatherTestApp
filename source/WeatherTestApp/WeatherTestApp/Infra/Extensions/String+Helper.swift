//
//  String+Helper.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
