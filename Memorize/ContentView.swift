//
//  ContentView.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 09/04/2025.
//

import SwiftUI

struct ContentView: View {
    let vehiclesEmojis = ["🚕", "🚙", "🚌", "🏎️", "🚓", "🚑", "🛻", "🚚", "🚜", "⛵", "🛥️", "🚁"]
    let animalsEmojis = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐮", "🐷", "🐸"]
    let foodEmojis = ["🍎", "🍌", "🍇", "🍉", "🍓", "🍒", "🥑", "🍞", "🧀", "🍕", "🍔", "🍟"]
    
    @State var cardCount = 12
    @State var isNewGame = true
    @State var emojisSet: [String] = []
    
    var body: some View {
        gameTitle
        VStack {
            ScrollView {
                cards
            }
            HStack {
                vehiclesThemeButton
                animalsThemeButton
                foodThemeButton
            }.font(.largeTitle)
        }
        .padding()
    }
    
    var gameTitle = Text("Memorize!").font(.largeTitle)
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60)), GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojisSet.count, id: \.self) { index in
                CardView(content: emojisSet[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojisSet.count)
    }
    
    func getThemeButton(themeName: String, symbol: String, emojiSet: [String]) -> some View {
        Button(action: {
            let numberOfPairs = Int.random(in: 4...12)
            let randomEmojiSet = emojiSet.shuffled().prefix(numberOfPairs)
            let emojiPairs = randomEmojiSet + randomEmojiSet
            
            emojisSet = emojiPairs.shuffled()
        },
        label: {
            VStack {
                Image(systemName: symbol)
                Text(themeName).font(.caption)
            }
        }).padding()
    }
    
    var vehiclesThemeButton: some View {
        getThemeButton(themeName: "Vehicles", symbol: "car", emojiSet: vehiclesEmojis)
    }
    var animalsThemeButton: some View {
        getThemeButton(themeName: "Animals", symbol: "cat", emojiSet: animalsEmojis)
    }
    var foodThemeButton: some View {
        getThemeButton(themeName: "Food", symbol: "carrot", emojiSet: foodEmojis)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
