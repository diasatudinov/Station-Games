//
//  MenuView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showGame = false
    @State private var showCatch = false
    @State private var showLearnStars = false
    @State private var showAchievements = false
    @State private var showSettings = false
    @State private var showQuiz = false
    
    @StateObject var user = User.shared
    //@StateObject var achievementsVM = AchievementsViewModel()
    //    @StateObject var leaderboardVM = LeaderboardViewModel()
    //  @StateObject var settingsVM = SettingsModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    ZStack {
                        
                        VStack {
                            HStack(spacing: 5){
                                Spacer()
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
                                    Text("\(user.coins)")
                                        .font(.custom(Fonts.abhayaLibre.rawValue, size: 20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                }.frame(height: 55)
                                
                            }
                            Spacer()
                        }.padding()
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 25) {
                                
                                Button {
                                    showQuiz = true
                                } label: {
                                    TextBg(height: 95, text: "Train Game", textSize: 24)
                                }
                                
                                Button {
                                    showQuiz = true
                                } label: {
                                    TextBg(height: 95, text: "Sequence Game", textSize: 24)
                                }
                                
                                Button {
                                    showQuiz = true
                                } label: {
                                    TextBg(height: 95, text: "Get Card", textSize: 24)
                                }
                                
                                Button {
                                    showQuiz = true
                                } label: {
                                    TextBg(height: 95, text: "Collection", textSize: 24)
                                }
                                
                                Button {
                                    showQuiz = true
                                } label: {
                                    TextBg(height: 95, text: "Settings", textSize: 24)
                                }
                            }
                            Spacer()
                        }
                    }
                } else {
                    ZStack {
                        
                        VStack {
                            HStack(spacing: 5){
                                Spacer()
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
                                    Text("\(user.coins)")
                                        .font(.custom(Fonts.abhayaLibre.rawValue, size: 20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                }.frame(height: 55)
                                
                            }.padding([.top, .trailing], 20)
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            VStack(spacing: 0) {
                                Spacer()
                                HStack(spacing: 5) {
                                    Spacer()
                                    Button {
                                        showQuiz = true
                                    } label: {
                                        TextBg(height: 95, text: "Train Game", textSize: 24)
                                    }
                                    
                                    
                                    Button {
                                        showQuiz = true
                                    } label: {
                                        TextBg(height: 95, text: "Sequence Game", textSize: 24)
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 5) {
                                    Spacer()
                                    Button {
                                        showQuiz = true
                                    } label: {
                                        TextBg(height: 95, text: "Get Card", textSize: 24)
                                    }
                                    
                                    Button {
                                        showQuiz = true
                                    } label: {
                                        TextBg(height: 95, text: "Collection", textSize: 24)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Button {
                                        showQuiz = true
                                    } label: {
                                        TextBg(height: 95, text: "Settings", textSize: 24)
                                    }
                                    Spacer()
                                }
                                
                            }
                        }
                        
                        
                    }
                }
            }
            .background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            )
            //            .onAppear {
            //                if settingsVM.musicEnabled {
            //                    MusicPlayer.shared.playBackgroundMusic()
            //                }
            //            }
            //            .onChange(of: settingsVM.musicEnabled) { enabled in
            //                if enabled {
            //                    MusicPlayer.shared.playBackgroundMusic()
            //                } else {
            //                    MusicPlayer.shared.stopBackgroundMusic()
            //                }
            //            }
            .fullScreenCover(isPresented: $showGame) {
                ContentView()
            }
            .fullScreenCover(isPresented: $showQuiz) {
                ContentView()
            }
            .fullScreenCover(isPresented: $showAchievements) {
                ContentView()
            }
            .fullScreenCover(isPresented: $showSettings) {
                ContentView()
            }
            .fullScreenCover(isPresented: $showCatch) {
                ContentView()
            }
            .fullScreenCover(isPresented: $showLearnStars) {
                ContentView()
            }
        }
    }
}

#Preview {
    MenuView()
}
