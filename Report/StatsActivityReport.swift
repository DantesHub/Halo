//
//  TotalActivityReport.swift
//  HaloActivityExtension
//
//  Created by Dante Kim on 10/18/23.
//

import DeviceActivity
import SwiftUI


struct StatsActivityReport: DeviceActivityReportScene {
    
    let context: DeviceActivityReport.Context = .stats
    
    let content: (ActivityReport) -> StatsActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        // the report's view.
        var res = ""
        var list: [AppDeviceActivity] = []
        var numberOfPickUpsValue = 0
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        for await d in data {
            res += d.user.appleID!.debugDescription
            res += d.lastUpdatedDate.description
            for await a in d.activitySegments{
                res += a.totalActivityDuration.formatted()
                for await c in a.categories {
                    for await ap in c.applications {
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        let duration = ap.totalActivityDuration
                        let numberOfPickups = ap.numberOfPickups
                        numberOfPickUpsValue += ap.numberOfPickups
                        let app = AppDeviceActivity(id: bundle, displayName: appName, duration: duration, numberOfPickups: numberOfPickups)
                        list.append(app)
                    }
                }
            }
        }
        
        return ActivityReport(totalDuration: totalActivityDuration, apps: list, numberOfPickUps: numberOfPickUpsValue)
    }
}
