//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/6/21.
//

// ViewModel is part of the UI, so that is why we are importing SwiftUI
import SwiftUI

// classes are mutable and can be changed via pointers 
class EmojiMemoryGame: ObservableObject {
    // This emoji array is essentially global using the keyword "static"
    static var emojis = ["🚊","🚀","🚁","🛶","🚗","🚕","🚙","🚌","🚎","🛥","🛳","⛴","🚢"]
    
    
    
    // this is known as a "type function", this function is a function on the ACTUAL TYPE of the EmojiMemoryGame class
    static func createMemoryGame() -> MemoryGame<String> {
        // For closures: move curly brace to the front and use keyword "in" after function decleration
        MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 4..<EmojiMemoryGame.emojis.count))  { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // Need to define the type of MemoryGame, in this case we are using emojis. Therefore, we are going to use type "String"
    // "@Published" = anytime the model changes, objectWillChange.send() occurs
    @Published private var model: MemoryGame<String> = createMemoryGame()
        
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {  // following line will send to the rest of th app that 
        model.choose(card)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
}
