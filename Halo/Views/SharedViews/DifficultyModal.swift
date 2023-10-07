//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct DifficultyModal: View {
    @ObservedObject var mainVM: MainViewModel
    @Binding var showDifficulty: Bool
    @State private var selectedDifficulty: Difficulty = .normal

    var body: some View {
        
        VStack{
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            showDifficulty.toggle()
                        }
                    }
                Spacer()
                Text("Select Difficulty")
                    .font(Font.prompt(.medium, size: 24))
                    .frame(height: 32, alignment: .center)
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }.padding(.vertical)
            VStack(spacing: 16) {
                DifficultySelect(difficulty: .normal, mainVM: mainVM, selectedDifficulty: $selectedDifficulty)
                DifficultySelect(difficulty: .deepfocus,  mainVM: mainVM, selectedDifficulty: $selectedDifficulty)
            }
         
            PrimaryButton(title: "Save Difficulty", action: {
                mainVM.selectedDifficulty = selectedDifficulty
                withAnimation {
                    showDifficulty.toggle()
                }
            }).padding(.bottom, 32)
        }.frame(height: 360)
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

struct DifficultyModal_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyModal(mainVM: MainViewModel(), showDifficulty: .constant(false))
    }
}

struct DifficultySelect: View {
    var difficulty: Difficulty
    @ObservedObject var mainVM: MainViewModel
    @Binding var selectedDifficulty: Difficulty
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(difficulty == selectedDifficulty ? Clr.primarySecond : Clr.primaryBackground)
                .frame(height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 3)
                )
                .cornerRadius(16)
            VStack {
                HStack {
                    Text(difficulty.rawValue)
                        .font(Font.prompt(.medium, size: 20))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
                HStack {
                    Text(difficulty.description)
                        .font(Font.prompt(.regular, size: 16))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
            }
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            selectedDifficulty = difficulty
        }
    }
}

enum Difficulty: String {
    case normal = "Normal"
    case deepfocus = "Deep Focus"
    
    var description: String {
        switch self {
        case .normal:
            return "Apps are blocked, but can be unblocked"
        case .deepfocus:
            return "You can't take breaks / unblock apps"
        }
    }
}
