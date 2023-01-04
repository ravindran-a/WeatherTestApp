//
//  BaseViewControllerTests.swift
//  WeatherTestAppTests
//
//  Created by Ravindran on 05/01/23.
//

import XCTest

final class BaseViewControllerTests: XCTestCase {

    var controller: BaseViewController!
    
    override func setUpWithError() throws {
        controller = BaseViewController()
    }

    override func tearDownWithError() throws {
        controller = nil
    }
    
    func testController() {
        controller.showLoader()
        controller.hideLoader()
        controller.showAlert(title: "Test", message: "test alert")
    }

}
