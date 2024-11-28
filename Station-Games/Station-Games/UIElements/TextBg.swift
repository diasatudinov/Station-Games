//
//  TextBg.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

struct TextBg: View {
    var height: CGFloat
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Image(.textBg)
                .resizable()
                .scaledToFit()
                .frame(height: height)
            Text(text)
                .font(.custom(Fonts.abhayaLibre.rawValue, size: textSize))
                .foregroundStyle(.yellow)
                .textCase(.uppercase)
        }
    }
}

#Preview {
    TextBg(height: 100, text: "Loading...", textSize: 32)
}
