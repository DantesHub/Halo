//
//  Report.swift
//  Report
//
//  Created by Dante Kim on 10/18/23.
//

import DeviceActivity
import SwiftUI

@main
struct Report: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
