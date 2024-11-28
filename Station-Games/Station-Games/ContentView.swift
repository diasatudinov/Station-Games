//
//  ContentView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("BACK")
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
