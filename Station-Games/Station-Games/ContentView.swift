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

struct LayeredCarouselView: View {
    let images: [String] // Array of image names or assets
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    let cardWidth = geometry.size.width * 0.5
                    let cardHeight = geometry.size.height
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
                                .offset(x: isFrontImage ? 185 : offset + 185, y: isFrontImage ? 20 : 20)
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
struct ContentView: View {
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    ContentView()
    //.environmentObject(User1())
}
