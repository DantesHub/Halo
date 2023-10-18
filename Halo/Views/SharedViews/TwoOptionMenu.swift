import SwiftUI

struct TwoOptionMenu: View {
    @Binding var selectedOption: Int
    var options: [MenuOption]

    var body: some View {
        HStack(spacing: -32) {
            ForEach(options.indices, id: \.self) { index in
                PillButton(title: options[index].title, isSelected: selectedOption == index, action: {
                    withAnimation {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        selectedOption = index
                        options[index].action()
                    }
               
                })
            }
        }
        .background(Clr.primaryBackground)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Clr.primary, lineWidth: 2.5)
        )
    }
}


struct PillButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? Clr.primary : .black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .font(Font.prompt(.medium, size: 20))
        }
        .background(isSelected ? Clr.primarySecond : Color.clear)
        .cornerRadius(24)
        .overlay(
                  RoundedRectangle(cornerRadius: 24)
                    .stroke(Clr.primary, lineWidth: isSelected ? 2.5 : 0)
              )
    }
}

struct MenuOption {
    var title: String
    var action: () -> Void
}

struct PillMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        TwoOptionMenu(selectedOption: .constant(0), options: [
            MenuOption(title: "Option 1", action: {
                print("Option 1 action")
            }),
            MenuOption(title: "Option 2", action: {
                
                print("Option 2 action")
            })
        ])
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
