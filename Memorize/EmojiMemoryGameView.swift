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

    AspectVGrid(
      items: game.cards, aspectRatio: 2 / 3,
      content: { card in cardView(for: card) }
    )
  }

  /// you would use the decorator @ViewBuilder if you have some if-statements
  /// in the function body to tell the compiler that what's returned by that
  /// function is a View.
  /// It is used here just to remind of its use case but has no effect if it is
  /// removed here.
  @ViewBuilder
  private func cardView(for card: EmojiMemoryGame.Card) -> some View {
    CardView(card)
      .onTapGesture { game.choose(card) }
  }
}

struct CardView: View {
  private let card: EmojiMemoryGame.Card

  init(_ card: EmojiMemoryGame.Card) {
    self.card = card
  }

  var body: some View {
    GeometryReader { geometry in
      return ZStack {
        let shape = RoundedRectangle(cornerRadius: 0)
        if card.faceUp {
          shape.foregroundColor(.white)
          shape.strokeBorder(lineWidth: 3).foregroundColor(.yellow)
          Circle().padding(5).opacity(0.5).foregroundColor(.yellow)
          Text(card.content)
            .font(font(in: geometry.size))
        } else if card.matched {
          shape.opacity(0)
        } else {
          shape.foregroundColor(.yellow)
        }
      }
    }
  }

  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
  }

  private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 2
    static let fontScale: CGFloat = 0.65
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()

    EmojiMemoryGameView(game: game)
  }
}
