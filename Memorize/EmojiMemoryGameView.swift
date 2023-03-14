//
//  ContentView.swift
//  Memorize
//
//  Created by MacBookPro on 11/03/2023.
//

import SwiftUI

// A data structure ContentView should behave like a View.
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content:   {
                    ForEach(game.cards) { card in
                        CardView(card).aspectRatio(2/3, contentMode: ContentMode.fit).onTapGesture {
                            game.choose(card)
                        }
                    }
                }).padding()
            }
    }
}

struct CardView : View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        return  ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if(card.faceUp){
                shape.foregroundColor(.yellow)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.black)
                Text(card.content)
                    .font(.largeTitle)
            
            }
            else if card.matched {
                shape.opacity(0)
            }
            else {
                shape.foregroundColor(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: game)
    }
}
