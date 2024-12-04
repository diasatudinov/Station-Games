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
    @State var images: [String] = []
    @State var texts: [String] = []
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
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

                
                ZStack {
                    VStack {
                        if DeviceInfo.shared.deviceType == .pad {
                            Spacer()
                        }
                        LayeredCarouselView(images: images, currentIndex: $currentIndex)
                        Spacer()
                    }
                
                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.back)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .offset(x: -3, y: -1)
                            
                        }.frame(height: 55)
                            .opacity(currentIndex > 0 ? 1.0 : 0.5)
                    }
                    .padding(.leading, 20)
                    .disabled(currentIndex == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if currentIndex < images.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.back)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .rotationEffect(.degrees(180))
                                .offset(x: 3, y: -1)
                            
                        }.frame(height: 55)
                            .opacity(currentIndex < images.count - 1 ? 1.0 : 0.5)
                    }
                    .padding(.trailing, 20)
                    .disabled(currentIndex == images.count - 1)
                }
                // Text(texts)
                }
                                
                ZStack {
                    Image(.textBgLong)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 98)
                    Text(getDescription(for: currentIndex))
                        .font(.custom(Fonts.abhayaLibre.rawValue, size: 24))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                }
                    .padding()
               
            }
            
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        .onAppear {
            updateImages()
        }
        .onChange(of: collectionVM.achievements) { _ in
            updateImages()
        }
    }
    
    private func updateImages() {
        for achivement in collectionVM.achievements {
            if achivement.isOpened {
                images.append(achivement.icon)
            } else {
                images.append(achivement.disabledIcon)
            }
        }
    }
    
    func getDescription(for index: Int) -> String {
        let descriptions = [
            "Precision Machinist",
            "Chief Dispatcher",
            "Traffic light ace",
            "Train of the future",
            "Turbo locomotive",
            "Stationmaster",
            "Tunnel Master",
            "Way Magnate",
        ]
        if collectionVM.achievements[index].isOpened {
            return descriptions[index % descriptions.count]
        } else {
            return "???"
        }
    }
}

#Preview {
    CollectionView(collectionVM: CollectionViewModel())
}

struct LayeredCarouselView: View {
    let images: [String] // Array of image names or assets
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    let cardWidth = geometry.size.width * 0.5
                    let cardHeight = DeviceInfo.shared.deviceType == .pad ? geometry.size.height * 1.5 : geometry.size.height
                    let spacing: CGFloat = 60
                    
                    ZStack {
                        ForEach(images.indices.reversed(), id: \.self) { index in
                            let isFrontImage = index == currentIndex
                            let offset = CGFloat(index - currentIndex) * spacing
                            
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .frame(height: cardHeight)
                                .scaleEffect(isFrontImage ? 1.0 : 0.8)
                                .rotation3DEffect(
                                    .degrees(Double(index - currentIndex) * -10),
                                    axis: (x: 0, y: 0, z: 0),
                                    perspective: 0.8
                                )
                                .offset(x: isFrontImage ? DeviceInfo.shared.deviceType == .pad ? 350:185 :  DeviceInfo.shared.deviceType == .pad ? offset + 350 : offset + 185, y: isFrontImage ? 20 : 20)
                                .zIndex(isFrontImage ? 1 : 0) // Ensures the front image is always on top
                                .animation(.spring(), value: currentIndex)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let dragThreshold: CGFloat = 50
                                if value.translation.width > dragThreshold, currentIndex > 0 {
                                    currentIndex -= 1
                                } else if value.translation.width < -dragThreshold, currentIndex < images.count - 1 {
                                    currentIndex += 1
                                }
                            }
                    )
                }
                .frame(height: 203)
            }
        }
    }
    
    // Example descriptions for each image
    func getDescription(for index: Int) -> String {
        let descriptions = [
            "Train of the Future",
            "Traffic Light Ace",
            "Urban Skyline",
            "Night Journey",
            "Railway Reflections"
        ]
        return descriptions[index % descriptions.count]
    }
}
