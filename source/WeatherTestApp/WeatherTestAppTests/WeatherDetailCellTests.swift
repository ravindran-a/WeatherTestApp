//
//  WeatherDetailCellTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest

final class WeatherDetailCellTests: XCTestCase {

    var cell: WeatherDetailCell!
    
    override func setUpWithError() throws {
        cell = WeatherDetailCell(style: .default, reuseIdentifier: WeatherDetailCell.cellIdentifier)
    }

    override func tearDownWithError() throws {
        cell = nil
    }

    func testCell() {
        cell.configureData(time: "10:00", temperature: "26 C")
    }
}
