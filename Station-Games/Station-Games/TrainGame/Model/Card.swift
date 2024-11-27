//
//  Card.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let type: String
    var isFaceUp = false
    var isMatched = false
}
