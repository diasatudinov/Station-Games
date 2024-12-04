//
//  MenuView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 28.11.2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showTrainGame = false
    @State private var showSequenceGame = false
    @State private var showGetCard = false
    @State private var showCollections = false
    @State private var showSettings = false
    
    
    @StateObject var user = User.shared
    //@StateObject var achievementsVM = AchievementsViewModel()
    //    @StateObject var leaderboardVM = LeaderboardViewModel()
      @StateObject var settingsVM = SettingsModel()
    @StateObject var collectionVM = CollectionViewModel()
    
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
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ?60:30)
                                    
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100 : 55)
                                
                                ZStack {
                                    Image(.pointsBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 80 : 43)
                                    Text("\(user.coins)")
                                        .font(.custom(Fonts.abhayaLibre.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40 :20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100 : 55)
                                
                            }
                            Spacer()
                        }.padding()
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 25) {
                                
                                Button {
                                    showTrainGame = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Train Game", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showSequenceGame = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Sequence Game", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showGetCard = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Get Card", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showCollections = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Collection", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showSettings = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
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
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 60 : 30)
                                    
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100 :55)
                                
                                ZStack {
                                    Image(.pointsBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 80:43)
                                    Text("\(user.coins)")
                                        .font(.custom(Fonts.abhayaLibre.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                                
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
                                        showTrainGame = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Train Game", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    
                                    
                                    Button {
                                        showSequenceGame = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Sequence Game", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 5) {
                                    Spacer()
                                    Button {
                                        showGetCard = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Get Card", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    
                                    Button {
                                        showCollections = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Collection", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Button {
                                        showSettings = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150 : 95, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                                if DeviceInfo.shared.deviceType == .pad {
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
            .background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            )
            .onAppear {
                if settingsVM.musicEnabled {
                    MusicPlayer.shared.playBackgroundMusic()
                }
            }
            .onChange(of: settingsVM.musicEnabled) { enabled in
                if enabled {
                    MusicPlayer.shared.playBackgroundMusic()
                } else {
                    MusicPlayer.shared.stopBackgroundMusic()
                }
            }
            .fullScreenCover(isPresented: $showTrainGame) {
                TrainGameView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showSequenceGame) {
                SequenceGameView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showGetCard) {
                GetCardView(collectionVM: collectionVM)
            }
            .fullScreenCover(isPresented: $showCollections) {
                CollectionView(collectionVM: collectionVM)
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(settings: settingsVM)
            }
            
        }
    }
}

#Preview {
    MenuView()
}
