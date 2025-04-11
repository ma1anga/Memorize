//
//  ContentView.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 09/04/2025.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    @State var cardCount = 12
    
    var body: some View {
        gameTitle
        VStack {
            ScrollView {
                cards
            }
            Spacer()
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
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjusters(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjusters(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    func getThemeButton(themeName: String, symbol: String) -> some View {
        Button(action: {}, label: {
            VStack {
                Image(systemName: symbol)
                Text(themeName).font(.caption)
            }
        }).padding()
    }
    
    var vehiclesThemeButton: some View {
        getThemeButton(themeName: "Vehicles", symbol: "car")
    }
    var animalsThemeButton: some View {
        getThemeButton(themeName: "Animals", symbol: "cat")
    }
    var foodThemeButton: some View {
        getThemeButton(themeName: "Food", symbol: "carrot")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
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
