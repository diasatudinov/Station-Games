//
//  ContentView.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI



//struct ContentView: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//            Text("Hello, world!")
//
//            Button {
//                presentationMode.wrappedValue.dismiss()
//            } label: {
//                Text("BACK")
//            }
//        }
//        .padding()
//    }
//}



//class User1: ObservableObject {
//    @Published var coins: Int = 100
//    @Published var unlockedAchievements: [Achievement] = []
//}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

//struct ContentView: View {
//    // The state variables
//    @State private var balance: Int = 100
//    @State private var spinning: Bool = false
//    @State private var offset: CGFloat = 0
//    @State private var selectedCardIndex: Int? = nil
//
//    // Define the cards (same picture or smiley here)
//    let cards: [String] = [
//        "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill"
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//
//            VStack {
//                // Balance display
//                HStack {
//                    Image(systemName: "circle.fill")
//                        .foregroundColor(.yellow)
//                    Text("\(balance)")
//                        .foregroundColor(.yellow)
//                        .font(.headline)
//                }
//                .padding()
//
//                Spacer()
//
//                // Card Carousel
//                ZStack {
//                    HStack(spacing: 20) {
//                        ForEach(0..<cards.count, id: \.self) { index in
//                            VStack {
//
//                                // Closed card
//                                Image(systemName: "questionmark.circle.fill")
//                                    .resizable()
//                                    .frame(width: 80, height: 80)
//                                    .foregroundColor(.gray)
//                                Text("???")
//                                    .foregroundColor(.white)
//                                    .font(.caption)
//
//                            }
//                            .frame(width: 231, height: 140)
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.red.opacity(0.5))
//                            )
//                        }
//                    }
//                    .offset(x: offset)
//                    .animation(spinning ? .linear(duration: 0.5).repeatForever(autoreverses: false) : .none)
//
//                    if let index = selectedCardIndex {
//                        // Opened card (random one)
//                        VStack {
//                            Image(systemName: cards[index])
//                                .resizable()
//                                .frame(width: 100, height: 100)
//                                .foregroundColor(.yellow)
//                            Text("Card \(index + 1)")
//                                .foregroundColor(.yellow)
//                                .font(.caption)
//                        }
//                    }
//                }
//                //.frame(width: 300, height: 200)
//                .clipped()
//
//                Spacer()
//
//                // Spin button
//                Button(action: {
//                    if balance >= 10 && !spinning {
//                        startSpin()
//                    }
//                }) {
//                    HStack {
//                        Text(spinning ? "STOP" : "SPIN")
//                        Image(systemName: "circle.fill")
//                            .foregroundColor(.yellow)
//                        Text("10")
//                    }
//                    .padding()
//                    .frame(width: 200)
//                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.red))
//                    .foregroundColor(.white)
//                    .font(.headline)
//                }
//                .disabled(balance < 10 && !spinning)
//                .opacity(balance < 10 && !spinning ? 0.5 : 1.0)
//            }
//            .padding()
//        }
//    }
//
//    private func startSpin() {
//        spinning = true
//        balance -= 10
//
//        // Start spinning
//        offset -= CGFloat(cards.count * 56) // Simulate endless scrolling
//
//        // After 2 seconds, stop the spin and reveal one random card
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            stopSpin()
//        }
//    }
//
//    private func stopSpin() {
//        // Stop the infinite spin after 2 seconds
//        withAnimation(.easeOut(duration: 0.5)) {
//            spinning = false
//
//            // Pick a random card to reveal
//            let randomIndex = Int.random(in: 0..<cards.count)
//            selectedCardIndex = randomIndex
//
//            // Adjust the offset to align the selected card in the center
//            let centerOffset = 0.0
//            offset = centerOffset
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            selectedCardIndex = nil
//        }
//    }
//}

struct ContentView: View {
    @State private var balance: Int = 100
    @State private var spinning: Bool = false
    @State private var selectedCardIndex: Int? = nil
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var currentCenterIndex: Int = 0 // Tracks the index of the center card
    
    // Define the cards
    let cards: [String] = [
        "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill", "smiley.fill"
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Balance display
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.yellow)
                    Text("\(balance)")
                        .foregroundColor(.yellow)
                        .font(.headline)
                }
                .padding()
                
                Spacer()
                
                // Card ScrollView with ScrollViewReader
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(0..<cards.count, id: \.self) { index in
                                    VStack {
                                        Image(systemName: "questionmark.circle.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(index == currentCenterIndex ? .yellow : .gray) // Highlight center card
                                        Text("???")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }
                                    .frame(width: 120, height: 150)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(index == currentCenterIndex ? Color.yellow.opacity(0.5) : Color.red.opacity(0.5)) // Highlight background
                                    )
                                    .id(index) // Assign a unique ID for scrolling
                                }
                            }
                            .onAppear {
                                scrollProxy = proxy
                            }
                            .onChange(of: spinning) { _ in
                                updateCenterIndex()
                            }
                        }
                        .frame(width: 300, height: 200)
                        .clipped()
                        .padding()
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
                    HStack {
                        Text(spinning ? "STOP" : "SPIN")
                        Image(systemName: "circle.fill")
                            .foregroundColor(.yellow)
                        Text("10")
                    }
                    .padding()
                    .frame(width: 200)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.red))
                    .foregroundColor(.white)
                    .font(.headline)
                }
                .disabled(balance < 10 && !spinning)
                .opacity(balance < 10 && !spinning ? 0.5 : 1.0)
            }
            .padding()
        }
    }
    
    private func startSpin() {
        spinning = true
        balance -= 10
        
        // Alternate scrolling left and right
        var direction = true // True for right, false for left
        spinLoop(direction: direction)
        
        // Stop spin after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            stopSpin()
        }
    }
    
    private func spinLoop(direction: Bool) {
        guard spinning else { return }
        
        // Calculate the target index for scrolling
        let targetIndex = direction ? cards.count - 1 : 0
        
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
        spinning = false
        
        // Pick a random card
        let randomIndex = Int.random(in: 0..<cards.count)
        selectedCardIndex = randomIndex
        
        // Scroll to the selected card
        withAnimation(.easeOut(duration: 0.5)) {
            scrollProxy?.scrollTo(randomIndex, anchor: .center)
        }
        currentCenterIndex = randomIndex
    }
    
    private func updateCenterIndex() {
        // Find the card that is visually in the center (placeholder logic)
        // Replace this with logic that observes scroll position if necessary
        currentCenterIndex = selectedCardIndex ?? 0
    }
}


//struct GetCardView: View {
//    @EnvironmentObject var user: User1
//    @State private var spinning = false
//    @State private var selectedCard: Achievement? = nil
//    @State private var currentIndex = 0
//    @State private var spinCount = 0
//    @State private var timer: Timer?
//    @State private var showAchievements = false // Controls visibility of achievements
//
//    var body: some View {
//        VStack {
//            Text("Balance: \(user.coins) Coins")
//                .font(.headline)
//                .padding()
//
//            Spacer()
//
//            // Carousel
//            if showAchievements {
//                GeometryReader { geometry in
//                    HStack(spacing: 20) {
//                        ForEach(allAchievements) { achievement in
//                            VStack {
//                                Image(systemName: achievement.icon)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                                    .opacity(selectedCard == achievement ? 1 : 0.5)
//                                Text(achievement.name)
//                                    .font(.caption)
//                                    .opacity(selectedCard == achievement ? 1 : 0.5)
//                            }
//                            .frame(width: geometry.size.width / 3)
//                        }
//                    }
//                    .offset(x: -CGFloat(currentIndex) * geometry.size.width / 3)
//                    .animation(.easeInOut, value: currentIndex)
//                }
//                .frame(height: 150)
//            } else {
//                Text("Spin to reveal achievements!")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//
//            Spacer()
//
//            // Button to Spin
//            Button(action: spin) {
//                HStack {
//                    Image(systemName: "coin")
//                    Text("Spin (10 Coins)")
//                }
//                .font(.headline)
//                .padding()
//                .background(user.coins >= 10 ? Color.blue : Color.gray)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .disabled(spinning || user.coins < 10)
//
//            Spacer()
//        }
//        .padding()
//    }
//
//    func spin() {
//        guard user.coins >= 10 else { return }
//        user.coins -= 10
//
//        spinning = true
//        spinCount = 0
//        showAchievements = true // Show achievements when the spin starts
//
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//            spinCount += 1
//
//            // Increment carousel index
//            currentIndex = (currentIndex + 1) % allAchievements.count
//
//            if spinCount > 30 { // Stop after enough spins
//                timer?.invalidate()
//                spinning = false
//
//                // Select the current card
//                selectedCard = allAchievements[currentIndex]
//
//                // Add to unlocked achievements if not already there
//                if let card = selectedCard, !user.unlockedAchievements.contains(where: { $0.id == card.id }) {
//                    user.unlockedAchievements.append(card)
//                }
//            }
//        }
//    }
//}
//
//struct CollectionView: View {
//    @EnvironmentObject var user: User1
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
//                ForEach(allAchievements) { achievement in
//                    VStack {
//                        Image(systemName: achievement.icon)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .foregroundColor(user.unlockedAchievements.contains(where: { $0.id == achievement.id }) ? .yellow : .gray)
//
//                        Text(achievement.name)
//                            .font(.caption)
//                            .foregroundColor(user.unlockedAchievements.contains(where: { $0.id == achievement.id }) ? .primary : .gray)
//                    }
//                    .padding()
//                    .background(Color.white.opacity(0.8))
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//struct CenteredCarouselView: View {
//    @State private var spinning = false
//    @State private var currentIndex = 0
//    @State private var timer: Timer?
//
//    let items = Array(1...8).map { "Item \($0)" } // Example items
//
//    var body: some View {
//        VStack {
//            Text("Infinite Carousel")
//                .font(.headline)
//                .padding()
//
//            Spacer()
//
//            // Carousel
//            GeometryReader { geometry in
//                let itemWidth = geometry.size.width / 3
//
//                HStack(spacing: 20) {
//                    ForEach(items.indices, id: \.self) { index in
//                        VStack {
//                            Circle()
//                                .fill(index == currentIndex ? Color.red : Color.blue)
//                                .frame(width: 100, height: 100)
//                                .overlay(
//                                    Text(items[index])
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .opacity(index == currentIndex ? 1.0 : 0.6) // Highlight the center item
//                        .frame(width: itemWidth)
//                    }
//                }
//                .offset(x: -CGFloat(currentIndex) * itemWidth + geometry.size.width / 3 - itemWidth / 2)
//                .animation(.easeInOut, value: currentIndex)
//            }
//            .frame(height: 150)
//
//            Spacer()
//
//            // Start/Stop Button
//            Button(action: toggleSpin) {
//                Text(spinning ? "Stop" : "Start")
//                    .font(.headline)
//                    .padding()
//                    .background(spinning ? Color.red : Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//
//    func toggleSpin() {
//        if spinning {
//            // Stop spinning
//            spinning = false
//            timer?.invalidate()
//        } else {
//            // Start spinning
//            spinning = true
//            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                currentIndex = (currentIndex + 1) % items.count
//            }
//        }
//    }
//}

#Preview {
    ContentView()
    //.environmentObject(User1())
}
