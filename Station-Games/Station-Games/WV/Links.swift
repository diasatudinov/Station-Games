//
//  Links.swift
//  Station-Games
//
//  Created by Dias Atudinov on 02.12.2024.
//

import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://stationgames.xyz/math"
    // "?page=test"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
