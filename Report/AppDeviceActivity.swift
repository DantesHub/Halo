//
//  AppDeviceActivity.swift
//  Report
//
//  Created by Dante Kim on 10/18/23.
//

import Foundation
import SwiftUI

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
    let numberOfPickUps: Int
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        print("Time: \(time)")
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d",hours,minutes)
    }
    
}
