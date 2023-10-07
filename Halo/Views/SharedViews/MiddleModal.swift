//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI
import Lottie

struct MiddleModal: View {
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                }.frame(height: 64)
                Text("🎉")
                    .font(Font.system(size: 72)) // Adjust the size
                    .frame(height: 80)
                    .padding(.bottom)
                VStack(spacing: 0) {
                    Text("Total Focus time:")
                        .font(Font.prompt(.regular, size: 20))
                    Text("115 Minutes")
                        .font(Font.prompt(.bold, size: 36))
                        .foregroundColor(Clr.primarySecond)
                    HStack {
                        Text("Earned: 80 coins")
                            .font(Font.prompt(.italic, size: 20))
                            .italic()
                        Img.haloCoin
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28)
                    }.padding(.top)
                }
                
                HStack {}.frame(height: 60) .padding(.bottom)
                
        
            }.frame(width: UIScreen.main.bounds.width / 1.5, height: 400)
                .padding(.horizontal, 16)
                .foregroundColor(Clr.primary)
                .background(Clr.primaryBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Clr.primary, lineWidth: 7)
                )
                .cornerRadius(24)
            LottieView(loopMode: .playOnce, animation: "confetti")
                .frame(width: 400, height: 400)
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            print("tapping here")
                            showModal.toggle()
                        }
                    }.zIndex(1000)
                Spacer()
                Text("You did it!")
                    .font(Font.prompt(.medium, size: 20))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }.frame(width: UIScreen.main.bounds.width / 1.5)
            .offset(y: -160)
            PrimaryButton(title: "Restart Session", action: {
                print("tapping here")
            })
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .offset(y: 160)

        }
    }
}

struct MiddleModal_Previews: PreviewProvider {
    static var previews: some View {
        MiddleModal(showModal: .constant(false))
    }
}
