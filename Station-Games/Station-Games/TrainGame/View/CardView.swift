//
//  CardView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5)
                Text(card.type)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                Text(card.type)
                    .font(.largeTitle)
                    .opacity(0.0)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    CardView(card: Card(type: "🔥"))
}
