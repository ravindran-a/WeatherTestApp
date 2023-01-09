//
//  WeatherInfoHeaderViewTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest
@testable import WeatherTestApp

final class WeatherInfoHeaderViewTests: XCTestCase {

    var view: WeatherInfoHeaderView!
    
    override func setUpWithError() throws {
        view = WeatherInfoHeaderView(reuseIdentifier: WeatherInfoHeaderView.identifier)
    }

    override func tearDownWithError() throws {
        view = nil
    }
    
    func testView() {
        view.configureData(cityName: "Test", temperature: "26 C", icon: nil)
    }
}
