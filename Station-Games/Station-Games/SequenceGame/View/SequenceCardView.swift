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
                Image(card.symbol)
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:228)
            } else {
                Image(.card2Back)
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:228)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    SequenceCardView(card: SequenceCard(symbol: "card2Face1"))
}
