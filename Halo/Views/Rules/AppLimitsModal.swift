//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct AppLimitsModal: View {
    @ObservedObject var mainVM: MainViewModel
    @State private var toggleBreaks: Bool = false
    @State private var showTextField: Bool = false
    @State private var limitTitle: String = "My App Limit"

    var body: some View {
        
        VStack{
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation {
                        }
                    }
                Spacer()
                if !showTextField {
                    HStack {
                        Text("\(limitTitle)")
                            .font(Font.prompt(.medium, size: 24))
                            .frame(height: 32, alignment: .center)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light)
                                    .impactOccurred()
                                  showTextField = true
                            }
                    }
              
                } else {
                    TextField("Limit Name", text: $limitTitle)
                        .font(Font.prompt(.medium, size: 24)) // H1 title style
                        .background(Color.clear)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                }

                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0)
            }.padding(.vertical)
            VStack(spacing: 24) {
                VStack {
                    HStack {
                        Text("When")
                            .font(Font.prompt(.regular, size: 16))
                        Spacer()
                    }
                    
                        HStack {
                            VStack {
                                Image(systemName: "hourglass")
                            }.frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                            .background(Clr.dndPurple)
                            .cornerRadius(4)
                            Text("Daily use exceeds..")
                            Spacer()
                            Text("30 mins")
                                .foregroundStyle(Clr.primaryThird)
                            BlueArrow()
                        }.frame(height: 48)
                        .foregroundColor(Clr.primary)
                        .padding(.horizontal)
                        .background(Clr.primaryBackground)
                        .cornerRadius(24)
                        .font(Font.prompt(.regular, size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Clr.primary, lineWidth: 2.5)
                        )
                }
                VStack {
                    HStack {
                        Text("Block")
                            .font(Font.prompt(.regular, size: 16))
                        Spacer()
                    }
                    VStack(alignment: .center, spacing: 16) {
                        HStack {
                            Text("Apps Blocked")
                            Spacer()
                            Text("Select Apps")
                                .foregroundStyle(Clr.primaryThird)
                            BlueArrow()
                        }
                        .padding(.horizontal)
                        Rectangle()
                            .frame(height: 2.5)
                            .foregroundColor(Clr.primary)
                        HStack(alignment: .center, spacing: 0) {
                            VStack {
                                HStack {
                                    Text("Breaks")
                                    Spacer()
                                }
                                HStack {
                                    Text("Use coins to unblock apps")
                                        .font(Font.prompt(.italic, fixedSize: 12))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.width / 1.7)
                            Toggle("", isOn: $toggleBreaks)
                                .tint(Clr.primarySecond)
                            // TODO: - add specific days of the week.
                        } .padding(.horizontal)
                    }.frame(height: 136)
                        .foregroundColor(Clr.primary)
                        .background(Clr.primaryBackground)
                        .cornerRadius(24)
                        .font(Font.prompt(.regular, size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Clr.primary, lineWidth: 2.5)
                        )
                }
            }
         
            PrimaryButton(title: "Save Limit", action: {
                withAnimation {
                    
                }
            }).padding(.bottom, 32)
        }.frame(height: 450)
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

struct AppLimitsModal_Previews: PreviewProvider {
    static var previews: some View {
        AppLimitsModal(mainVM: MainViewModel())
    }
}

struct AppLimitsModalSelect: View {
    @ObservedObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Clr.primary)
                .frame(height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black, lineWidth: 3)
                )
                .cornerRadius(16)
            VStack {
                HStack {
                    Text("difficulty.rawValue")
                        .font(Font.prompt(.medium, size: 20))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
                HStack {
                    Text("difficulty.description")
                        .font(Font.prompt(.regular, size: 16))
                        .padding(.leading, 8)
                        .foregroundColor(Clr.primary)
                    Spacer()
                }.padding(.horizontal, 12)
            }
        }.onTapGesture {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}


