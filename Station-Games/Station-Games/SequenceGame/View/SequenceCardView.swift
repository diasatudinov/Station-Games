//
//  SequenceCardView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI

struct SequenceCardView: View {
    let card: SequenceCard
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5)
                Text(card.symbol)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    SequenceCardView(card: SequenceCard(symbol: "🔥"))
}
