//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 14/04/2025.
//

import Foundation

struct MemorizeGame<CardContent> {
    
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
