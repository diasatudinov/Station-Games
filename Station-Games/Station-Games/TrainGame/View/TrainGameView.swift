//
//  TrainGameView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI
import AVFoundation

struct TrainGameView: View {
    @StateObject var user = User.shared
    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var settingsVM: SettingsModel
    
    @State private var cards: [Card] = []
    @State private var selectedCards: [Card] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = ["cardFace1", "cardFace2", "cardFace3", "cardFace4", "cardFace5", "cardFace6"]
    private let gridSize = 5
    
    @State private var counter: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            if counter < 2 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        TextBg(height: 130, text: "Level \(user.level)", textSize: 40)
                        

                        Spacer()
                    }
                    TextBg(height: 98, text: "Start", textSize: 24)
                    Spacer()
                }
            }
            
            if counter > 1 {
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 90:55, text: "Level \(user.level)", textSize: DeviceInfo.shared.deviceType == .pad ? 35:20)
                            Spacer()
                        }
                        
                        HStack {
                            Button {
                                pauseShow = true
                            } label: {
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(.pause)
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
                            
                        }
                    }.padding([.top,.horizontal], 20)
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 0) {
                        ForEach(cards) { card in
                            CardView(card: card)
                                .onTapGesture {
                                    flipCard(card)
                                    if settingsVM.soundEnabled {
                                        playSound(named: "flipcard")
                                    }
                                }
                                .opacity(card.isMatched ? 0.5 : 1.0)
                        }
                        
                    }
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 900:460)
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                }
                .onAppear {
                    setupGame()
                }
            }
            
            if pauseShow {
                MenuShield(menuType: .pause, headerText: "Pause", firstBtnText: "Resume", secondBtnText: "Menu", menuShow: $pauseShow, firstBtnPress: { pauseShow = false }, secondBtnPress: { presentationMode.wrappedValue.dismiss() })
            }
            
            if gameEnded {
                
                MenuShield(menuType: .win, headerText: "You Win!", firstBtnText: "Next Level", secondBtnText: "Menu", menuShow: $gameEnded, firstBtnPress: { setupGame() }, secondBtnPress: { presentationMode.wrappedValue.dismiss() }, addPoints: "+5")
            
            }
            
        }
        .onAppear {
            startTimer()
        }
        .background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
        }
    }
    
    private func setupGame() {
        // Reset state
        selectedCards.removeAll()
        message = "Find all matching cards!"
        gameEnded = false
        
        // Generate cards
        var gameCards = [Card]()
        
        // Add 4 cards of each type (24 cards total for 6 types)
        for type in cardTypes {
            gameCards.append(Card(type: type))
            gameCards.append(Card(type: type))
            gameCards.append(Card(type: type))
            gameCards.append(Card(type: type))
        }
        
        // Add 1 semaphore card to make it 25 cards
        gameCards.append(Card(type: "cardSemaphore"))
        
        // Shuffle cards
        gameCards.shuffle()
        
        // Ensure exactly 25 cards
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 4 else { return }
        
        // Flip card
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        if card.type == "cardSemaphore" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resetAllCards()
            }
        } else if selectedCards.count == 4 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            message = "You found a match! Keep going!"
        } else {
            message = "Not a match. Try again!"
        }
        
        // Flip cards back over after a delay if they don't match
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
                user.updateUserCoins(for: 5)
                user.updateUserLevel()
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            
            cards[index].isMatched = false
            
        }
        selectedCards.removeAll()
    }
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    TrainGameView(settingsVM: SettingsModel())
}
