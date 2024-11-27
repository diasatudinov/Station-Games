//
//  SequenceGameView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI

struct SequenceGameView: View {
    @State private var cards: [SequenceCard] = []
    @State private var sequence: [Int] = []
    @State private var currentGuessIndex = 0
    @State private var isPlayerTurn = false
    @State private var message: String = "Memorize the sequence!"
    @State private var showRestart = false
    
    private let allSymbols = ["😀", "😂", "😍", "🥳", "😎"]
    private let sequenceLength = 5
    
    var body: some View {
        VStack {
            Text(message)
                .font(.title2)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                ForEach(cards) { card in
                    SequenceCardView(card: card)
                        .onTapGesture {
                            if isPlayerTurn {
                                handleCardTap(card)
                            }
                        }
                        .opacity(card.isFaceUp ? 1.0 : 0.7)
                }
            }
            .padding()
            
            if showRestart {
                Button("Restart") {
                    setupGame()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear(perform: setupGame)
    }
    
    private func setupGame() {
        // Сброс состояния
        cards = []
        sequence = []
        currentGuessIndex = 0
        isPlayerTurn = false
        message = "Memorize the sequence!"
        showRestart = false
        
        // Генерация карт и последовательности
        let randomSymbols = Array(allSymbols.shuffled().prefix(10))
        cards = randomSymbols.map { SequenceCard(symbol: $0) }
        sequence = Array(0..<cards.count).shuffled().prefix(sequenceLength).map { $0 }
        
        // Открытие последовательности карт
        showSequence()
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
                message = "You won! Great memory!"
                showRestart = true
                isPlayerTurn = false
            }
        } else {
            // Неправильная карта
            message = "Incorrect! Try again!"
            showRestart = true
            isPlayerTurn = false
        }
    }
}

#Preview {
    SequenceGameView()
}
