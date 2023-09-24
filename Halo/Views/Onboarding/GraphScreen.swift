//
//  GraphScreen.swift
//  Halo
//
//  Created by Dante Kim on 9/6/23.
//

import SwiftUI

struct GraphScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: -16){
                Text("Take back control")
                HStack(spacing:0) {
                    Text("of your ")
                    Text("life!")
                        .padding(EdgeInsets(top: -4, leading: 3, bottom: -4, trailing: 3))
                            .background(Clr.highlight)
                            .cornerRadius(5)
                }
           
            }.font(Font.prompt(.bold, size: 36))
                .multilineTextAlignment(.center)
                .foregroundColor(Clr.primary)
                .lineSpacing(-8)
                .padding(.top, Constants.paddingXLL)
            Text("Halo will create a customized plan to help you drastically decrease the time you spend on your phone")
                .multilineTextAlignment(.center)
            Img.graph
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            HStack {
                Circle()
                    .fill(Clr.primarySecond)
                    .frame(width: 24)
                Img.haloIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
                Text("with Halo")
                    .font(Font.prompt(.regular, size: 16))
                Spacer()
                Circle()
                    .fill(Clr.primaryThird)
                    .frame(width: 24)
                Text("without Halo")
                    .font(Font.prompt(.regular, size: 16))
            }.frame(width: 270)
            Spacer()
            PrimaryButton(title: "Continue") {
                
            }.padding(.bottom, Constants.paddingXLL)
        }.padding(.horizontal, 32)
    }
}

struct GraphScreen_Previews: PreviewProvider {
    static var previews: some View {
        GraphScreen()
    }
}
