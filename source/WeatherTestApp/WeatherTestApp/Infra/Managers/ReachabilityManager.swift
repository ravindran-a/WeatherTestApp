//
//  ReachabilityManager.swift
//  WeatherTestApp
//
//  Created by Ravindran on 09/01/23.
//

import Foundation
import Reachability

class ReachabilityManager {

    static let shared = ReachabilityManager()
    private var reachability: Reachability!
    private var isReachable: Bool!
    
    init() {
        reachability = try? Reachability()
        isReachable = reachability.connection != .unavailable
        reachability.whenReachable = { [weak self] reachability in
            self?.isReachable = true
            NotificationCenter.default.post(Notification(name: Notification.Name(AppNotifications.networkAvailable.rawValue)))
        }
        reachability.whenUnreachable = { [weak self] _ in
            self?.isReachable = false
            NotificationCenter.default.post(Notification(name: Notification.Name(AppNotifications.networkLost.rawValue)))
        }
    }
    
    func isNetworkAvailable() -> Bool {
        if ReachabilityManager.shared.isReachable {
            return true
        }
        return false
    }

}
