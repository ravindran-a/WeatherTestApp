//
//  WeatherInfoCellTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest

final class WeatherInfoCellTests: XCTestCase {

    var cell: WeatherInfoCell!
    
    override func setUpWithError() throws {
        cell = WeatherInfoCell(style: .default, reuseIdentifier: WeatherInfoCell.cellIdentifier)
    }

    override func tearDownWithError() throws {
        cell = nil
    }
    
    func testCell() {
        cell.configureData(cityName: "Test", temperature: "26 C", icon: nil)
    }

}
