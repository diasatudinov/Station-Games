//
//  AchievementModel.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import Foundation

struct Achievement: Identifiable, Codable {
    let id = UUID()
    let title: String
    let icon: String
    var isOpened: Bool = false
}
