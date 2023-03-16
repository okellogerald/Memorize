//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by MacBookPro on 12/03/2023.
//

// * THE VIEW MODEL

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    // Type-property
    private static let images : Array<String> = ["🍊", "🍎", "🥝", "🥭", "🥨", "🍔", "🍞", "🥚","🌽", "🧅",
        "🥥", "🍍", "🍒", "🍖", "🌮", "🥮", "🍚", "🍜", "🧆", "🍕", "🍭","🍥",
    ]
    
    // Type-function
    private static func createGame() -> MemoryGame<String> {
        MemoryGame(numberOfCardsPairs: 10) { index in
            images[index]
       }
    }
    
    // access control or Gate-keeping
    // A view model will decide what in the model the UI will
    // have access to.
    // Swift has a way to detect changes on structs and not on classes.
    @Published private var model = createGame()
    
    var cards: Array<Card> {
        model.cards;
    }
    
    // MARK - Intents
    func choose(_ card: Card){
        model.choose(card)
    }
}
