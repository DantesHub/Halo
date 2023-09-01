//  ShadowViewModifier.swift
//  Doxo
//
//  Created by Dante Kim on 6/12/21.
//

import SwiftUI

struct ShadowViewModifier: ViewModifier {
    var darkMode: Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    func body(content: Content) -> some View {
        content
            .drawingGroup()
            .shadow(color: Color.black, radius: 0, x: 8, y: 8)
    }
}


extension View {
    /// Adds a shadow onto this view with the specified `ShadowStyle`
    func primaryShadow(darkMode: Bool = false) -> some View {
        modifier(ShadowViewModifier(darkMode: darkMode))
    }
}
