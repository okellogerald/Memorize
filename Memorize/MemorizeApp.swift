//
//  MemorizeApp.swift
//  Memorize
//
//  Created by MacBookPro on 11/03/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
