//
//  OnboardingScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/10/23.
//

import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        GeometryReader { g in
            VStack(spacing: -64) {
                Img.devils
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width)
                    .offset(y: UIDevice.hasNotch ? -50 : -20)
                HStack {
                    Img.wingLeft
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 250)
                        .offset(x: 48)
                    VStack(spacing: -16) {
                        (Text("Halo").bold() + Text(", your"))
                        Text("screentime")
                        Text("guardian")
                            .padding(.horizontal)
                            .overlay(
                                Img.circle
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                        Text("that protects")

                        HStack(spacing:0) {
                            Text("your focus.")
                                .padding(EdgeInsets(top: -4, leading: 3, bottom: -4, trailing: 3))
                                .background(Clr.highlight)
                                .cornerRadius(5)
                        }
                    }.frame(width: 256)
                        .offset(x: 10)
                    Img.wingRight
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 250)
                        .offset(x: -52)
                }.font(Font.prompt(.medium, size: 40))
                .multilineTextAlignment(.center)
                .lineSpacing(-8)
                .foregroundColor(Clr.primary)
                .offset(y: -36)
                Img.middleAngels
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                Img.girlStudying
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(y: -64)
                Spacer()
                Spacer()
                PrimaryButton(title: "Continue") {
                    
                }.padding(.bottom)
                .padding(.horizontal, 32)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
     
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
