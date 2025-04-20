//
//  EmojuMemoryGame.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 14/04/2025.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let halloweenEmojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    private static let vehiclesEmojis = ["🚕", "🚙", "🚌", "🏎️", "🚓", "🚑", "🛻", "🚚", "🚜", "⛵", "🛥️", "🚁"]
    private static let animalsEmojis = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐮", "🐷", "🐸"]
    private static let foodEmojis = ["🍎", "🍌", "🍇", "🍉", "🍓", "🍒", "🥑", "🍞", "🧀", "🍕", "🍔", "🍟"]
    
    @Published private var model: MemoryGame<String>;
    @Published private var theme: Theme;
    
    private static var themes: [Theme] {
        let halloweenTheme = Theme(name: "Halloween Theme", color: "orange", emojis: EmojiMemoryGame.halloweenEmojis, numberOfPairsOfCards: 12)
        let vehiclesTheme = Theme(name: "Vehicles Theme", color: "blue", emojis: EmojiMemoryGame.vehiclesEmojis, numberOfPairsOfCards: 6)
        let animalsTheme = Theme(name: "Animals Theme", color: "green", emojis: EmojiMemoryGame.animalsEmojis, numberOfPairsOfCards: 8)
        let foodTheme = Theme(name: "Food Theme", color: "red", emojis: EmojiMemoryGame.foodEmojis, numberOfPairsOfCards: 10)
        
        return [halloweenTheme, vehiclesTheme, animalsTheme, foodTheme]
    }
    
    init() {
        let randomTheme = Self.themes.randomElement()!
        
        self.theme = randomTheme
        self.model = Self.createMemoryGame(theme: randomTheme)
        shuffle()
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        var emojis = theme.emojis
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            if let emoji = emojis.randomElement() {
                emojis.remove(at: emojis.firstIndex(of: emoji)!)
                
                return emoji
            } else {
                return "⁉️"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeColor: String {
        return theme.color
    }
    
    var themeName: String {
        return theme.name
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        theme = Self.themes.randomElement()!
        model = Self.createMemoryGame(theme: theme)
        shuffle()
    }
}
