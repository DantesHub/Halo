//
//  GraphScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/6/23.
//

import SwiftUI

struct YearsScreen: View {
    var body: some View {
        GeometryReader { g in
            ZStack {
                VStack(spacing: 16) {
                    VStack(spacing: -16){
                        Text("Current state of")
                        Text("your life")
                    }.font(Font.prompt(.bold, size: 36))
                        .multilineTextAlignment(.center)
                        .lineSpacing(-8)
                        .padding(.top, Constants.paddingXLL)
                   ( Text("You’ll spend") +
                     Text(" 159 days ").foregroundColor(Color.red).bold() + Text("on your phone this year."))
                        .font(Font.prompt(.medium, size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .foregroundColor(Clr.primary)
                    Spacer()
                    VStack(spacing: -12) {
                        Text("You're on track to spend")
                            .font(Font.prompt(.regular, size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .foregroundColor(Clr.primary)
                        ZStack {
                            Rectangle()
                                .fill(Clr.highlight)
                                .frame(height: 32)
                                .padding(.horizontal, 20)
                            Text("31 Years")
                                .font(Font.prompt(.extraBold, size: 64))
                                .foregroundColor(Clr.primary)
                        }
                        Text("of your life looking down at your phone. 😱")
                            .font(Font.prompt(.regular, size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .foregroundColor(Clr.primary)
                     
                    }
             
                    Spacer()
                    Spacer()
                    Spacer()
                    PrimaryButton(title: "Continue") {
                        
                    }.padding(.bottom, Constants.paddingXL)
                }.padding(.horizontal, 32)

                Img.wizardBox
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width * 0.65)
                    .position(x: 40, y: g.size.height * 0.7)
                Img.grampsBox
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width * 0.65)
                    .position(x: 20, y: g.size.height * 0.7)
                    .scaleEffect(x: -1, y: 1, anchor: .center)
            }
        }
    
    }
}

struct YearsScreen_Previews: PreviewProvider {
    static var previews: some View {
        YearsScreen()
    }
}
