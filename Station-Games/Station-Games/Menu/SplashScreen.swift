//
//  SplashScreen.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    
                    Spacer()
                    
                }
                Spacer()
                
                
            }
            
            VStack {
                Spacer()
                TextBg(height: 100, text: "Loading...", textSize: 32)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.bottom, 20)
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
    SplashScreen()
}
