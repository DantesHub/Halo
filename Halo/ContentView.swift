//
//  ContentView.swift
//  Halo
//
//  Created by Dante Kim on 8/26/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world2!")
                .foregroundColor(Clr.primary)
                .font(Font.prompt(.bold, size: 32))
        }
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
