//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct FocusModal: View {
    @Binding var tappedPlus: Bool

    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            tappedPlus.toggle()
                        }
                    }
                Spacer()
                Text("Focus Session")
                    .font(Font.prompt(.medium, size: 24))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }
            ZStack {
                Capsule()
                    .fill(Clr.primaryBackground)
                    .frame(height: 36)
                    .overlay(
                        Capsule()
                            .stroke(Color.black, lineWidth: 3)
                    )
                HStack {
                    Text("Duration")
                        .font(Font.prompt(.medium, size: 20))
                        .padding(.leading, 8)
                    Spacer()
                    BlueArrow()
                }.padding(.horizontal, 12)
            }
            Spacer()
            Text("gotham")
        }.frame(width: .infinity, height: 300)
            .padding(.horizontal, 36)
            .foregroundColor(Clr.primary)
            .background(.yellow)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Clr.primary, lineWidth: 4.5)
            )

    }
}

struct FocusModal_Previews: PreviewProvider {
    static var previews: some View {
        FocusModal(tappedPlus: .constant(false))
    }
}
