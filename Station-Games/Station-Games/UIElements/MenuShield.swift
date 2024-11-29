//
//  MenuShield.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

enum MenuType {
    case pause, win, lose
}

struct MenuShield: View {
    @State var menuType: MenuType
    @State var headerText: String
    
    @State var firstBtnText: String
    @State var secondBtnText: String
    @Binding var menuShow: Bool
    
    var firstBtnPress: () -> ()
    var secondBtnPress: () -> ()
    var addPoints: String?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black.opacity(0.5))
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    Image(.menuHeader)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Text(headerText)
                        .font(.custom(Fonts.abhayaLibre.rawValue, size: 20))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                }.offset(y: 20)
                
                ZStack {
                    
                    Image(.menuBody)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        
                        if menuType == .win {
                            HStack(spacing: 5){
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(.coin)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                    
                                }.frame(height: 55)
                                
                                ZStack {
                                    Image(.pointsBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 43)
                                    if let addPoints = addPoints {
                                        Text(addPoints)
                                            .font(.custom(Fonts.abhayaLibre.rawValue, size: 20))
                                            .foregroundStyle(.yellow)
                                            .textCase(.uppercase)
                                    }
                                }.frame(height: 55)
                                
                            }.padding(.bottom, 20)
                        }
                        
                        Button {
                            firstBtnPress()
                        } label: {
                            TextBg(height: menuType == .win ? 55 : 82, text: firstBtnText, textSize: menuType == .win ? 16 : 32)
                        }
                        
                        Button {
                            secondBtnPress()
                        } label: {
                            TextBg(height: menuType == .win ? 55 : 82, text: secondBtnText, textSize: menuType == .win ? 16 : 32)
                        }
                        
                    }
                    
                }.scaledToFit().frame(height: 312)
            }
        }
    }
}

#Preview {
    MenuShield(menuType: .pause, headerText: "Pause", firstBtnText: "Next Level", secondBtnText: "Menu", menuShow: .constant(true), firstBtnPress: {}, secondBtnPress: {})
}
