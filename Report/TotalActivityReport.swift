//
//  TotalActivityReport.swift
//  HaloActivityExtension
//
//  Created by Dante Kim on 10/18/23.
//

import DeviceActivity
import SwiftUI


extension DeviceActivityReport.Context {
    static let totalActivity = Self("Total Activity")
    static let stats = Self("Stats")
    static let pieChart = Self("pieChart")
}

struct TotalActivityReport: DeviceActivityReportScene {
    
    let context: DeviceActivityReport.Context = .pieChart
    
    let content: (ActivityReport) -> TotalActivityView
    
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
        // this is getting triggered 2nd but not updating the userdefault
        let sharedDefaults = UserDefaults(suiteName: "group.86SK3K6AM6.io.nora.Halo.updateActivity")
        let activityReport = ActivityReport(totalDuration: totalActivityDuration, apps: list, numberOfPickUps: numberOfPickUpsValue)
        sharedDefaults?.set("goat shit9", forKey: "totalActivity")
        sharedDefaults?.synchronize()
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.86SK3K6AM6.changeShield")

        if containerURL == nil {
        // The container does not exist.
            print("container doesn't exist")
        } else {
            print("containerURL \(containerURL)")
        }


        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName("io.nora.deviceActivityUpdate" as CFString), nil, nil, true)

        return activityReport
    }
}

extension Notification.Name {
    static let sharedDefaultsUpdated = Notification.Name("sharedDefaultsUpdated")
}
