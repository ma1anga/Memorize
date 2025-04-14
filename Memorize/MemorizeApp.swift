//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Pavlo Bilousov on 09/04/2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
