//
//  AppCoordinator.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("App Coordinator Start")
        launchWeatherApp()
    }
    
    func launchWeatherApp() {
        let weatherCoordinator: WeatherCoordinator = WeatherCoordinator(navigationController)
        weatherCoordinator.parentCoordinator = self
        children.append(weatherCoordinator)
        
        weatherCoordinator.start()
    }

}
