//
//  SettingsView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 02.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.arrowLeft)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 40:20)
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                        
                    }
                    Spacer()
                    
                    HStack(spacing: 5){
                        Spacer()
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.coin)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                        
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
                        
                    }
                    
                
            }.padding([.top,.horizontal], 20)

                Spacer()
            }
            
            VStack(spacing: 0) {
                ZStack {
                    Image(.menuHeader)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 75:50)
                    Text("Settings")
                        .font(.custom(Fonts.abhayaLibre.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 35:20))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                }.offset(y: 20)
                
                ZStack {
                    
                    Image(.menuBody)
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 0) {
                        Text("music")
                            .font(.custom(Fonts.abhayaLibre.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                            .foregroundStyle(.yellow)
                            .textCase(.uppercase)
                        HStack {
                            Image(.musicIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:65)
                            Button {
                                settings.musicEnabled.toggle()
                            } label: {
                                if settings.musicEnabled {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 65:40)
                                } else {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 65:40)
                                }
                            }
                            
                        }
                        
                        Text("Effects")
                            .font(.custom(Fonts.abhayaLibre.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                            .foregroundStyle(.yellow)
                            .textCase(.uppercase)
                        HStack {
                            Image(.effectsIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:65)
                            
                            Button {
                                settings.soundEnabled.toggle()
                            } label: {
                                if settings.soundEnabled {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 65:40)
                                } else {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 65:40)
                                }
                            }
                        }.padding(.bottom, 50)
                       
                    }
                    
                }.scaledToFit().frame(height: DeviceInfo.shared.deviceType == .pad ? 500:312)
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
    SettingsView(settings: SettingsModel())
}
