//
//  AverageScreentime.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct AverageScreentime: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("What is your average daily screentime")
                .font(Font.prompt(.bold, size: 20))
                .multilineTextAlignment(.center)
                .lineSpacing(-8)
                .padding(.top, Constants.paddingXLL)
            OptionButton(title: "0-3 hours", action: {
                
            })
            OptionButton(title: "3-5 hours", action: {
                
            })
            OptionButton(title: "6-8 hours", action: {
                
            })
            OptionButton(title: "3-5 hours", action: {
                
            })
            Spacer()
            Spacer()
            PrimaryButton(title: "Continue") {
                
            }.padding(.bottom, Constants.paddingXLL)
        }.padding()
        
    }
}

struct AverageScreentime_Previews: PreviewProvider {
    static var previews: some View {
        AverageScreentime()
    }
}
