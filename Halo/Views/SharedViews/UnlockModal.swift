//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct UnlockModal: View {
    @ObservedObject var mainVM: MainViewModel
    @Binding var showUnlock: Bool
    @State private var selectedTime: TimeSelect = .five
    @StateObject var familyModel = FamilyViewModel.shared

    var body: some View {
        
        VStack{
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                            showUnlock.toggle()
                        }
                    }
                Spacer()
                Text("Take a Break")
                    .font(Font.prompt(.medium, size: 24))
                    .frame(height: 32, alignment: .center)
                Spacer()
                HStack(spacing: 2) {
                    Img.haloCoin
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text("1000")
                        .font(Font.prompt(.medium, size: 16))
                }
            }.padding(.vertical)
            .foregroundColor(Clr.primary)
            VStack(spacing: 12) {
                UnlockSelect(time: TimeSelect.one, selectedTime: $selectedTime)
                UnlockSelect(time: TimeSelect.five, selectedTime: $selectedTime)
                UnlockSelect(time: TimeSelect.ten, selectedTime: $selectedTime)
                UnlockSelect(time: TimeSelect.fifteen, selectedTime: $selectedTime)
            }
         
            PrimaryButton(title: "Unlock for \(selectedTime.rawValue) min", action: {
//                mainVM.selectedDifficulty = selectedDifficulty
                withAnimation {
                    showUnlock.toggle()
                    familyModel.unblockApps(minutes: selectedTime.rawValue)
                }
            }).padding(.bottom, 32)
        }.frame(height: 400)
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

struct UnlockModal_Previews: PreviewProvider {
    static var previews: some View {
        UnlockModal(mainVM: MainViewModel(), showUnlock: .constant(false))
    }
}

struct UnlockSelect: View {
    var time: TimeSelect
    @Binding var selectedTime: TimeSelect
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(time == selectedTime ? Clr.primarySecond : Clr.primaryBackground)
                .frame(height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 3)
                )
                .cornerRadius(16)
                HStack {
                    Text("\(time.rawValue) min")
                        .font(Font.prompt(.medium, size: 20))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                    Img.haloCoin
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                    Text("\(time.cost)")
                        .font(Font.prompt(.medium, size: 20))
                }.padding(.horizontal, 12)
       
            
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            selectedTime = time
        }
    }
}

enum TimeSelect: Int {
    case one = 1
    case five = 5
    case ten = 10
    case fifteen = 15
    
    var cost: Int {
        switch self {
        case .one: return 5
        case .five: return 10
        case .ten: return 20
        case .fifteen: return 30
        }
    }
}
