//
//  CollectionViewModel.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import Foundation

class CollectionViewModel: ObservableObject {
    @Published var achievements: [Achievement] = [
        Achievement(title: "Precision Machinist", icon: "getCard1"),
        Achievement(title: "Chief Dispatcher", icon: "getCard2"),
        Achievement(title: "Traffic light ace", icon: "getCard3"),
        Achievement(title: "Train of the future", icon: "getCard4"),
        Achievement(title: "Turbo locomotive", icon: "getCard5"),
        Achievement(title: "Stationmaster", icon: "getCard6"),
        Achievement(title: "Tunnel Master", icon: "getCard7"),
        Achievement(title: "Way Magnate", icon: "getCard8")
        
        
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
            Achievement(title: "Precision Machinist", icon: "getCard1"),
            Achievement(title: "Chief Dispatcher", icon: "getCard2"),
            Achievement(title: "Traffic light ace", icon: "getCard3"),
            Achievement(title: "Train of the future", icon: "getCard4"),
            Achievement(title: "Turbo locomotive", icon: "getCard5"),
            Achievement(title: "Stationmaster", icon: "getCard6"),
            Achievement(title: "Tunnel Master", icon: "getCard7"),
            Achievement(title: "Way Magnate", icon: "getCard8")
            
            
        ]
    }
}
