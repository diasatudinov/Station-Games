//
//  SequenceGameView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI
import AVFoundation

struct SequenceGameView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var settingsVM: SettingsModel
    
    @State private var cards: [SequenceCard] = []
    @State private var sequence: [Int] = []
    @State private var currentGuessIndex = 0
    @State private var isPlayerTurn = false
    @State private var message: String = "Memorize the sequence!"
    @State private var gameLose: Bool = false
    @State private var pauseShow: Bool = false
    @State private var gameEnded: Bool = false
    
    private let allSymbols = ["card2Face1", "card2Face2", "card2Face3", "card2Face4", "card2Face5"]
    private let sequenceLength = 5
    
    @State private var counter: Int = 0
    var body: some View {
        ZStack {
            if counter < 2 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        TextBg(height: 130, text: "Level \(user.levelGame)", textSize: 40)
                        

                        Spacer()
                    }
                    TextBg(height: 98, text: "Start", textSize: 24)
                    Spacer()
                }
            }
            if counter > 1 {
                
                VStack {
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
                        
                    
                }.padding([.top,.horizontal], 20)
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                        ForEach(cards) { card in
                            SequenceCardView(card: card)
                                .onTapGesture {
                                    if isPlayerTurn {
                                        handleCardTap(card)
                                        if settingsVM.soundEnabled {
                                            playSound(named: "flipcard")
                                            
                                        }
                                    }
                                }
                            
                        }
                    }
                    .padding()
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
                
                MenuShield(menuType: .win, headerText: "You Win!", firstBtnText: "Next Level", secondBtnText: "Menu", menuShow: $gameEnded, firstBtnPress: { setupGame() }, secondBtnPress: { presentationMode.wrappedValue.dismiss() }, addPoints: "+1")
            
            }
            
            if gameLose {
                MenuShield(menuType: .lose, headerText: "You Lose!", firstBtnText: "Retry", secondBtnText: "Menu", menuShow: $gameLose, firstBtnPress: { setupGame() }, secondBtnPress: { presentationMode.wrappedValue.dismiss() })
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
    
    private func setupGame() {
        // Сброс состояния
        cards = []
        sequence = []
        currentGuessIndex = 0
        isPlayerTurn = false
        message = "Memorize the sequence!"
        gameLose = false
        gameEnded = false
        
        // Генерация карт и последовательности
        let randomSymbols = Array(allSymbols.shuffled().prefix(10))
        cards = randomSymbols.map { SequenceCard(symbol: $0) }
        sequence = Array(0..<cards.count).shuffled().prefix(sequenceLength).map { $0 }
        
        // Открытие последовательности карт
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showSequence()
        }
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
    
    private func showSequence() {
        for (index, cardIndex) in sequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.8) {
                self.cards[cardIndex].isFaceUp = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(sequence.count) * 0.8 + 0.5) {
                self.cards[cardIndex].isFaceUp = false
                if index == self.sequence.count - 1 {
                    self.startPlayerTurn()
                }
            }
        }
    }
    
    private func startPlayerTurn() {
        isPlayerTurn = true
        message = "Now it's your turn!"
    }
    
    private func handleCardTap(_ card: SequenceCard) {
        guard let tappedIndex = cards.firstIndex(of: card) else { return }
        
        if tappedIndex == sequence[currentGuessIndex] {
            // Правильная карта
            cards[tappedIndex].isFaceUp = true
            currentGuessIndex += 1
            
            if currentGuessIndex == sequence.count {
                // Игрок завершил последовательность
                gameEnded = true
                user.updateUserCoins(for: 1)
                user.updateUserLevelGame2()
                message = "You won! Great memory!"
                isPlayerTurn = false
            }
        } else {
            // Неправильная карта
            message = "Incorrect! Try again!"
            isPlayerTurn = false
            gameLose = true
        }
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
    SequenceGameView(settingsVM: SettingsModel())
}
