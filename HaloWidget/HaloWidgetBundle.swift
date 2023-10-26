//
//  HaloWidgetBundle.swift
//  HaloWidget
//
//  Created by Dante Kim on 10/25/23.
//

import WidgetKit
import SwiftUI

@main
struct HaloWidgetBundle: WidgetBundle {
    var body: some Widget {
        HaloWidget()
        HaloWidgetLiveActivity()
    }
}
