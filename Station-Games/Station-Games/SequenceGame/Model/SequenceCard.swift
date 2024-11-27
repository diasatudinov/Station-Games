//
//  SequenceCard.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import Foundation

struct SequenceCard: Identifiable, Equatable {
    let id = UUID()
    let symbol: String
    var isFaceUp = false
}
