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
                                .frame(height: 20)
                            
                        }.frame(height: 55)
                        
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
                    
                
            }.padding([.top,.horizontal], 20)

                
                ZStack {
                    VStack {
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
