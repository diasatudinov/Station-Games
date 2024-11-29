//
//  CollectionView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import SwiftUI

struct CollectionView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var collectionVM: CollectionViewModel
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack() {
                    ForEach(collectionVM.achievements) { achievement in
                        HStack {
                            if achievement.isOpened {
                                Image(achievement.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            } else {
                                Image(achievement.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .opacity(0.5)
                            }
                            
                            if achievement.isOpened {
                                Text(achievement.title)
                                    .font(.custom(Fonts.abhayaLibre.rawValue, size: 32))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            } else {
                                Text("???")
                                    .font(.custom(Fonts.abhayaLibre.rawValue, size: 32))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
}

#Preview {
    CollectionView(collectionVM: CollectionViewModel())
}
