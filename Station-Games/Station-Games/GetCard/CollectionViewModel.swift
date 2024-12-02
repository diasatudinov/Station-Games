//
//  CollectionViewModel.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import Foundation

class CollectionViewModel: ObservableObject {
    @Published var achievements: [Achievement] = [
        Achievement(title: "Precision Machinist", icon: "getCard1", disabledIcon: "getCardOff1"),
        Achievement(title: "Chief Dispatcher", icon: "getCard2", disabledIcon: "getCardOff2"),
        Achievement(title: "Traffic light ace", icon: "getCard3", disabledIcon: "getCardOff3"),
        Achievement(title: "Train of the future", icon: "getCard4", disabledIcon: "getCardOff4"),
        Achievement(title: "Turbo locomotive", icon: "getCard5", disabledIcon: "getCardOff5"),
        Achievement(title: "Stationmaster", icon: "getCard6", disabledIcon: "getCardOff6"),
        Achievement(title: "Tunnel Master", icon: "getCard7", disabledIcon: "getCardOff7"),
        Achievement(title: "Way Magnate", icon: "getCard8", disabledIcon: "getCardOff8")
        
        
    ] {
        didSet {
            saveAchievements()
        }
    }
    
    private let achievementsKey = "achievementsKey"
    
    init() {
        self.achievements = loadAchievements()
    }
    
    func achiveToggle(index: Int) {
        self.achievements[index].isOpened = true
    }
    
    private func saveAchievements() {
        if let encoded = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encoded, forKey: achievementsKey)
        }
    }
    
    private func loadAchievements() -> [Achievement] {
        if let data = UserDefaults.standard.data(forKey: achievementsKey),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: data) {
            return decoded
        }
        return [
            Achievement(title: "Precision Machinist", icon: "getCard1", disabledIcon: "getCardOff1"),
            Achievement(title: "Chief Dispatcher", icon: "getCard2", disabledIcon: "getCardOff2"),
            Achievement(title: "Traffic light ace", icon: "getCard3", disabledIcon: "getCardOff3"),
            Achievement(title: "Train of the future", icon: "getCard4", disabledIcon: "getCardOff4"),
            Achievement(title: "Turbo locomotive", icon: "getCard5", disabledIcon: "getCardOff5"),
            Achievement(title: "Stationmaster", icon: "getCard6", disabledIcon: "getCardOff6"),
            Achievement(title: "Tunnel Master", icon: "getCard7", disabledIcon: "getCardOff7"),
            Achievement(title: "Way Magnate", icon: "getCard8", disabledIcon: "getCardOff8")
            
            
        ]
    }
}
