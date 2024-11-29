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

struct ContentView: View {
    // Sample data for the carousel
    let items: [String] = ["🌟", "🌙", "☀️", "🌈", "🔥", "❄️"]
    
    @State private var scrollOffset: CGFloat = 0 // Tracks scroll position
    @State private var dragging: Bool = false   // Tracks whether the user is dragging
    
    let itemWidth: CGFloat = 200  // Width of each card
    let spacing: CGFloat = 20     // Spacing between cards
    let totalSpacing: CGFloat = 220 // Sum of item width and spacing
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Carousel
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    HStack(spacing: spacing) {
                        ForEach(items.indices, id: \.self) { index in
                            let itemPosition = CGFloat(index) * totalSpacing
                            let distanceFromCenter = itemPosition - scrollOffset - screenWidth / 2 + itemWidth / 2
                            let scale = max(1 - abs(distanceFromCenter / screenWidth), 0.7)
                            let rotation = distanceFromCenter / screenWidth * 25
                            
                            VStack {
                                Text(items[index])
                                    .font(.system(size: 60))
                                    .frame(width: itemWidth, height: itemWidth)
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 5, x: 0, y: 5)
                                    .scaleEffect(scale)
                                    .rotation3DEffect(
                                        .degrees(-rotation),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .opacity(Double(scale))
                                    .animation(.easeOut, value: scrollOffset)
                            }
                            .frame(width: itemWidth)
                        }
                    }
                    .padding(.horizontal, (screenWidth - itemWidth) / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragging = true
                                scrollOffset -= value.translation.width
                            }
                            .onEnded { value in
                                dragging = false
                                scrollOffset = nearestItemOffset()
                            }
                    )
                }
                .frame(height: 300)
                
                Spacer()
                
                // Instructions
                Text("Drag to scroll")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.bottom, 50)
            }
        }
    }
    
    // Snap to nearest item offset
    private func nearestItemOffset() -> CGFloat {
        let itemIndex = (scrollOffset / totalSpacing).rounded()
        return itemIndex * totalSpacing
    }
}

#Preview {
    ContentView()
    //.environmentObject(User1())
}
