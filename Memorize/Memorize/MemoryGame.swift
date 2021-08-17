//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/6/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) = read-only
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // When there is OneAndOnlyFaceUpCard and another card is chosen, we need to check if they match
    // If they match: they must disappear, if they don't: they must be face down after a third card is chosen
    
    // "mutating" means this function will change the struct MemoryGame<CardContent>
    mutating func choose(_ card: Card) {
        // We are going to look through our cards to find the first index where that card's id equals our card's id
        // Don't choose cards that are already matched or already face up
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // we have a match! (2 cards face-up)
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            
        }
        
        print("\(cards)")
        
    }
    
    
    // use init() to initialize the unset variables in this struct
    // Below, we are passing a f(x) as an arguement to createCardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numbersOfPairsOfCards x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            // allow all the cards to have a unique identifier
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    // Here, I am putting a struct inside another struct
    // Essentially it is the naming aspect in terms of calling the MemoryGame.Card
    struct Card: Identifiable {
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
