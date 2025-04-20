//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 14/04/2025.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach {
            let isFaceUp = (newValue == $0)
            
            /* If card goes to face down, but previously was faced up,
                it means that it was seen */
            if !isFaceUp && cards[$0].isFaceUp {
                cards[$0].wasSeen = true
            }
            
            cards[$0].isFaceUp = isFaceUp
        }}
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        score = 0
        
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    
    
    mutating func choose(_ card: Card) {
        print(card)
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score+=2
                    } else {
                        if cards[chosenIndex].wasSeen {
                           score-=1
                        }
                        if cards[potentialMatchIndex].wasSeen {
                            score-=1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return nil
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        
        let content: CardContent
        
        let id: String
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") \(wasSeen ? "seen" : "unseen")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
