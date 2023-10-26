//
//  HaloWidgetLiveActivity.swift
//  HaloWidget
//
//  Created by Dante Kim on 10/25/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HaloWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HaloWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HaloWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension HaloWidgetAttributes {
    fileprivate static var preview: HaloWidgetAttributes {
        HaloWidgetAttributes(name: "World")
    }
}

extension HaloWidgetAttributes.ContentState {
    fileprivate static var smiley: HaloWidgetAttributes.ContentState {
        HaloWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HaloWidgetAttributes.ContentState {
         HaloWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HaloWidgetAttributes.preview) {
   HaloWidgetLiveActivity()
} contentStates: {
    HaloWidgetAttributes.ContentState.smiley
    HaloWidgetAttributes.ContentState.starEyes
}
