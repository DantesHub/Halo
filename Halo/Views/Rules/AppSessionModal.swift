//
//  FocusModal.swift
//  Halo
//
//  Created by Dante Kim on 9/2/23.
//  Created by Dante Kim on 9/2/23.
//

import SwiftUI

struct AppSessionModal: View {
    @ObservedObject var mainVM: MainViewModel
    @State private var toggleBreaks: Bool = false
    @State private var toggleAllDay: Bool = false
    @State private var showTextField: Bool = false
    @State private var sessionTitle: String = "My App Session"
    @State private var startTime = Calendar.current.date(from: DateComponents(hour: 9)) ?? Date()
    @State private var endTime = Calendar.current.date(from: DateComponents(hour: 17)) ?? Date()


    var body: some View {
        
        VStack{
            Spacer()
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
                        Text("\(sessionTitle)")
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
                    TextField("Limit Name", text: $sessionTitle)
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
                        .background(Clr.primaryBackground)
                        .cornerRadius(24)
                        .font(Font.prompt(.regular, size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Clr.primary, lineWidth: 2.5)
                        )
                }
                VStack(spacing: 16) {
                    HStack {
                        Text("When")
                            .font(Font.prompt(.regular, size: 16))
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Toggle("All Day", isOn: $toggleAllDay)
                                .tint(Clr.primarySecond)
                        }.padding(.horizontal)
                        Rectangle()
                            .frame(height: 2.5)
                            .foregroundColor(Clr.primary)
                        HStack {
                            DatePicker("Starts", selection: $startTime, displayedComponents: [.hourAndMinute])
                        }.padding(.horizontal)
                        Rectangle()
                            .frame(height: 2.5)
                            .foregroundColor(Clr.primary)
                        HStack {
                            DatePicker("Ends", selection: $endTime, displayedComponents: [.hourAndMinute])
                        }.padding(.horizontal)
                        
                    }
                    .frame(height: toggleAllDay ? 48 : 164)
                    .foregroundColor(Clr.primary)
                    .background(Clr.primaryBackground)
                    .cornerRadius(24)
                    .font(Font.prompt(.regular, size: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Clr.primary, lineWidth: 2.5)
                        )
                    HStack(alignment: .center) {
                        ForEach(Array(mainVM.days.indices), id: \.self) { index in
                            DayBubble(day: $mainVM.days[index])
                        }
                    }.frame(height: 56, alignment: .center)
                    .padding(.horizontal)
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
        }.frame(height: 640)
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
struct DayBubble: View {
    @Binding var day: Day

    var body: some View {
        Text(day.name)
            .frame(width: 12, height: 12)
            .font(Font.prompt(.medium, size: 12))
            .padding(12)
            .background(day.isSelected ? Clr.primarySecond : Color.gray.opacity(0.5))
            .foregroundColor(day.isSelected ? .white : .black)
            .clipShape(Circle())
            .onTapGesture {
                day.isSelected.toggle()
            }
    }
}
struct AppSessionModal_Previews: PreviewProvider {
    static var previews: some View {
        AppSessionModal(mainVM: MainViewModel())
    }
}

struct AppSessionModalSelect: View {
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


