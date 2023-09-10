//
//  PrimaryButton.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct PrimaryButton: View {
    var img: Image?
    var title: String = "Continue2"
    var action: () -> Void
    @State private var opacity: Double = 1
    
    var body: some View {
    
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Clr.primary)
                    .frame(height: 50)
                    .scaleEffect(opacity == 1 ? 1 : 0.95)
                    .opacity(opacity)
                HStack {
                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                        .font(Font.prompt(.medium, size: 20))
                    Spacer()
                    if let img = img {
                        img
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }.padding(.horizontal, 32)
            }
            .onTapGesture {
                self.opacity = 0.7
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        self.opacity = 1
                        self.action()
                    }
                }
            }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton( action: {})
            .padding()
    }
}
