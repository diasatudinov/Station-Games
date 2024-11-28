//
//  UserManager.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

class User: ObservableObject {
    static let shared = User()
    
    @AppStorage("coins") var storedCoins: Int = 10
    @Published var coins: Int = 10
    
    @AppStorage("game1Level") var storedLevel: Int = 1
    @Published var level: Int = 1
    
    func updateUserCoins(for coins: Int) {
        self.coins += coins
        storedCoins = self.coins
    }
    
    func updateUserLevel() {
        self.level += 1
        storedLevel = self.coins
    }
}
