//
//  AchievementModel.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import Foundation

struct Achievement: Identifiable, Codable, Equatable {
    let id = UUID()
    let title: String
    let icon: String
    let disabledIcon: String
    var isOpened: Bool = false
}
