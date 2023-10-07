//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct FocusModal: View {
    @ObservedObject var mainVM: MainViewModel
    @Binding var tappedPlus: Bool
    @Binding var tappedDifficulty: Bool

    var body: some View {
        
        VStack{
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
            }.padding(.top)
            VStack(spacing: 16) {
                FocusSelect(title: "30 minutes", callback: {})
                FocusSelect(title: "Apps Blocked", callback: {})
                FocusSelect(title: "Difficulty: \(mainVM.selectedDifficulty.rawValue)", callback: {
                    withAnimation {
                        tappedDifficulty.toggle()
                    }
                })
            }
         
            PrimaryButton(title: "Start Session", action: {
                mainVM.startFocusSession()
            }).padding(.bottom, 48)
        }.frame(height: 380)
            .padding(.horizontal, 32)
            .foregroundColor(Clr.primary)
            .background(Clr.primaryBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Clr.primary, lineWidth: 7)
            )
            .cornerRadius(24)

    }
}

struct FocusModal_Previews: PreviewProvider {
    static var previews: some View {
        FocusModal(mainVM: MainViewModel(), tappedPlus: .constant(false), tappedDifficulty:  .constant(false))
    }
}

struct FocusSelect: View {
    var title: String
    var callback: () -> ()
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Clr.primaryBackground)
                .frame(height: 40)
                .overlay(
                    Capsule()
                        .stroke(Color.black, lineWidth: 3)
                )
            HStack {
                Text(title)
                    .font(Font.prompt(.medium, size: 20))
                    .padding(.leading, 8)
                    .foregroundColor(Clr.primary)
                Spacer()
                BlueArrow()

            }.padding(.horizontal, 12)
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            callback()
        }
    }
}
