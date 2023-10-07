//
//  OnboardingScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/10/23.
//

import SwiftUI

struct OnboardingScreen: View {
    @State private var devilImageOffset: CGFloat = -200
    @State private var wingLeftOffset: CGFloat = -200
    @State private var wingRightOffset: CGFloat = 200
    @State private var middleAngelsOffset: CGFloat = 400
    @StateObject var mainVM: MainViewModel
    @State private var animateMiddle = false

    
    var body: some View {
        GeometryReader { g in
            VStack(spacing: -64) {
                Img.devils
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width)
                    .offset(y: devilImageOffset)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 0.65)) {
                            devilImageOffset = UIDevice.hasNotch ? -50 : -20
                        }
                    }
                HStack {
                    Img.wingLeft
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 250)
                        .offset(x: wingLeftOffset)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                wingLeftOffset = 28
                            }
                        }
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
                        .offset(x: wingRightOffset)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.65)) {
                                wingRightOffset = -32
                            }
                        }
                }.font(Font.prompt(.medium, size: 40))
                .multilineTextAlignment(.center)
                .lineSpacing(-8)
                .foregroundColor(Clr.primary)
                .offset(y: -36)
                Img.middleAngels
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(y: middleAngelsOffset)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 0.6 )) {
                            middleAngelsOffset = -24
                        }
                        self.animateMiddle.toggle()

                    }
                    .offset(y: animateMiddle ? -10 : 10)
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true), value: animateMiddle)
                 
                Img.girlStudying
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(y: -64)
                Spacer()
                Spacer()
                PrimaryButton(title: "Continue") {
                    mainVM.homeScreenIsReady = true
                }.padding(.bottom)
                .padding(.horizontal, 32)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
     
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(mainVM: MainViewModel())
    }
}
