//
//  OnboardingCarouselScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/23/23.
//

import SwiftUI

struct OnboardingCarouselScreen: View {
    var body: some View {
        VStack {
            VStack(spacing: -16) {
                HStack(spacing: -4) {
                    Text("Earn ")
                    Text(" coins").padding(.horizontal, 2)
                        .overlay(
                            Img.circle
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        )
                    Text(" as")
                }
            
                HStack(spacing:0) {
                    Text("you ")
                    Text("focus.")
                        .padding(EdgeInsets(top: -4, leading: 3, bottom: -4, trailing: 3))
                        .background(Clr.highlight)
                        .cornerRadius(5)
                }
            }.font(Font.prompt(.semiBold, size: 40))
            .multilineTextAlignment(.center)
            .lineSpacing(-8)
            .foregroundColor(Clr.primary)
        }
    }
}

struct OnboardingCarouselScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCarouselScreen()
    }
}
