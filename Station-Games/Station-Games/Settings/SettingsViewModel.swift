//
//  SettingsViewModel.swift
//  Station-Games
//
//  Created by Dias Atudinov on 02.12.2024.
//

import SwiftUI

class SettingsModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
}
