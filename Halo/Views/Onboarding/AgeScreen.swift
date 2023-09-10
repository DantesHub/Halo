//
//  AgeScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/6/23.
//

import SwiftUI

struct AgeScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("How old are you?")
                .font(Font.prompt(.bold, size: 20))
                .multilineTextAlignment(.center)
                .lineSpacing(-8)
                .padding(.top, Constants.paddingXLL)
            OptionButton(title: "Under 18", action: {
                
            })
            OptionButton(title: "18 - 24", action: {
                
            })
            OptionButton(title: "25 -34", action: {
                
            })
            OptionButton(title: "35 - 44", action: {
                
            })
            OptionButton(title: "45 - 54", action: {
                
            })
            OptionButton(title: "55 - 64+", action: {
                
            })

            Spacer()
            PrimaryButton(title: "Continue") {
                
            }.padding(.bottom, Constants.paddingXLL)
        }.padding(.horizontal, 32)
    }
}

struct AgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AgeScreen()
    }
}
