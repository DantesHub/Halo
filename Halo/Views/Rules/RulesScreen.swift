//
//  RulesScreen.swift
//  Halo
//
//  Created by Dante Kim on 10/7/23.
//

import SwiftUI

struct RulesScreen: View {
    @State var showSchedules = 0
    var body: some View {
        VStack {
            TwoOptionMenu(selectedOption: $showSchedules, options: [MenuOption(title: "Schedules", action: {
               showSchedules = 0
           }), MenuOption(title: "Limits", action: {
               showSchedules = 1
           })])
            Spacer()
        }.padding(.horizontal, Constants.paddingLarge)
        
    }
}

#Preview {
    RulesScreen()
}
