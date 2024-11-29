//
//  GetCardView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 29.11.2024.
//

import SwiftUI

struct GetCardView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode

    
    @State private var balance: Int = 100
    @State private var spinning: Bool = false
    @State private var selectedCardIndex: Int? = nil
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    // Define the cards
    let cards: [String] = [
        "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill"
    ]
    
    var body: some View {
        ZStack {
            
            VStack {
                // Balance display
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.pause)
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
                
                Spacer()
                
                // Card ScrollView with ScrollViewReader
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<cards.count * 5, id: \.self) { index in
                                    
                                        // Closed card
                                    Image(.getCardBack)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 141)
                                            .foregroundColor(.gray)
                                            .opacity(index == 12 ? 0 : 1)
                                    
                                    .id(index)
                                }
                            }
                            .onAppear {
                                scrollProxy = proxy
                            }
                        }.disabled(true)
                            .ignoresSafeArea()
                    }
                    
                    if let index = selectedCardIndex {
                        VStack {
                            // Opened card
                            Image(systemName: cards[index])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.yellow)
                            Text("Card \(index + 1)")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                    }
                }
                
                Spacer()
                
                // Spin button
                Button(action: {
                    if balance >= 10 && !spinning {
                        startSpin()
                    }
                }) {
                    ZStack {
                        Image(.textBg)
                            .resizable()
                            .scaledToFit()
                        HStack {
                            Text("Spin")
                                .font(.custom(Fonts.abhayaLibre.rawValue, size: 32))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                            Image(.coin)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            Text("10")
                                .font(.custom(Fonts.abhayaLibre.rawValue, size: 32))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                        }
                    }.frame(height: 98)
                }
                .disabled(balance < 10 && selectedCardIndex == nil ? true : false)
                .opacity(balance < 10 && !spinning ? 0.5 : 1.0)
            }
            //.padding()
        }
        .background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    private func startSpin() {
        spinning = true
        balance -= 10
        
        var direction = true // True for right, false for left
                spinLoop(direction: direction)
        // Simulate the spinning animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            stopSpin()
        }
    }
    
    private func spinLoop(direction: Bool) {
            guard spinning else { return }
            
            // Calculate the target index for scrolling
            let targetIndex = direction ? cards.count * 5 - 1 : 0
            
            // Animate the scroll
            withAnimation(.linear(duration: 0.5)) {
                scrollProxy?.scrollTo(targetIndex, anchor: .center)
            }
            
            // Toggle the direction and repeat
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                spinLoop(direction: !direction)
            }
        }
    
    private func stopSpin() {
        // Stop spinning
        spinning = false
        
        // Pick a random card
        let randomIndex = Int.random(in: 0..<cards.count)
        selectedCardIndex = randomIndex
        
        // Scroll to the selected card
        withAnimation(.easeOut(duration: 0.5)) {
            scrollProxy?.scrollTo(12, anchor: .center)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            selectedCardIndex = nil
        }
    }
}

#Preview {
    GetCardView()
}
