//
//  TrainGameView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI

struct TrainGameView: View {
    @State private var cards: [Card] = []
    @State private var selectedCards: [Card] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    
    private let cardTypes = ["😀", "😂", "😍", "🥳", "😎", "🤩"]
    private let gridSize = 5
    
    var body: some View {
        VStack {
            Text(message)
                .font(.title2)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize)) {
                ForEach(cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            flipCard(card)
                        }
                        .opacity(card.isMatched ? 0.5 : 1.0)
                }
                
            }
            .padding()
            
            if gameEnded {
                Button("Restart Game") {
                    setupGame()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            setupGame()
            print(cards)
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
        gameCards.append(Card(type: "🚦"))
        
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
        
        if card.type == "🚦" {
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
            if cards.allSatisfy({ $0.isMatched || $0.type == "🚦" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            if !cards[index].isMatched {
                cards[index].isMatched = false
            }
        }
        selectedCards.removeAll()
    }
}

#Preview {
    TrainGameView()
}
