//
//  MemoryGame.swift
//  Memorize
//
//  Created by MacBookPro on 12/03/2023.
//

// * THE MODEL

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    // computed property
    private var indexFaceUp: Int? {
        get { cards.indices.filter({cards[$0].faceUp}).only }
        set { cards.indices.forEach({ cards[$0].faceUp = ($0 == newValue)}) }
    }
    
    init(numberOfCardsPairs: Int, createCardContent: (Int) -> CardContent){
        cards = []
        for index in 0..<numberOfCardsPairs {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = index(of: card),
            !cards[chosenIndex].faceUp,
            !cards[chosenIndex].matched {
            if indexFaceUp != nil {
                if(cards[chosenIndex].content == card.content){
                    cards[chosenIndex].matched = true
                    cards[indexFaceUp!].matched = true
                }
              
                cards[chosenIndex].faceUp = true
            } else {
                indexFaceUp = chosenIndex
            }
        }
    }
    
    private func index(of card: Card) -> Int? {
        return cards.firstIndex(where: {$0.id == card.id})
    }
    
    struct Card: Identifiable {
        var faceUp = true
        var matched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var only: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
