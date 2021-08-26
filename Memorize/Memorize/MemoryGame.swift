//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/6/21.
//

import Foundation
// Model File

// Need to declare generic type since we have a "don't care" type in Card struct
// constrains our "don't care" to "care alittle bit"

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) = read-only
    private(set) var cards: Array<Card>
    
    private(set) var score: Int = 0
    
    // introduction to computed properties
    // Scenario 1: you flip over ONE card, nothing else happens
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        
        // use extension in array such that if there is only one in faceUpCardIndices, give the first element, else return nil.
        
        // need to look at all the cards and then seeing which of those is face up
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        
        // set every card to face-down UNLESS the index is equal what the computed property is equal to
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    // When there is OneAndOnlyFaceUpCard and another card is chosen, we need to check if they match
    // If they match: they must disappear
    // If they don't: they must be face down after a third card is chosen
    
    
    // "mutating" means this function will change the struct MemoryGame<CardContent>
    mutating func choose(_ card: Card) {
        
        // find the index of this card in the array and we only care if the card is not ALREADY face up and is not ALREADY matched
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            
            // want to see whether there is only one and only one face up card RIGHT NOW
            
            // Scenario 2: You have ONE card face up and you click ANOTHER card
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                // mark the cards as seen
                cards[potentialMatchIndex].alreadySeenCount += 1
                cards[chosenIndex].alreadySeenCount += 1
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // we have a match! (2 cards face-up)
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    // increment score by 2
                    score += 2
                    
                    // case where cards mismatch and they have BOTH already been seen AT LEAST ONCE
                } else if cards[chosenIndex].alreadySeenCount > 1 && cards[potentialMatchIndex].alreadySeenCount > 1
                {
                    score -= 2
                
                    // case where cards mismatch and ONE of the cards has already been seen AT LEAST ONCE
                } else if cards[chosenIndex].alreadySeenCount > 1 || cards[potentialMatchIndex].alreadySeenCount > 1 {
                   
                    score -= 1
                }
                
                // mark the second card you flipped over as isFaceUp
                cards[chosenIndex].isFaceUp = true
                
            } else {
                // Scenario 3: You have TWO cards face up already and you tap ANOTHER card
                
                // you are setting the index below, activating the setter in the computed property
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            
            
        }
        
    }
    
    
    // use init() to initialize the unset variables in this struct
    // Below, we are passing a f(x) as an arguement to createCardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        
        cards = []
        
        // add numbersOfPairsOfCards x 2 to cards array using a for loop
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            // allow all the cards to have a unique identifier
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        // shuffle the cards
        cards.shuffle()
        // set the score to 0
        score = 0
    }
    
    // Here, I am putting a struct inside another struct
    // Essentially we are doing this becauseof the naming aspect in terms of calling the MemoryGame.Card
    struct Card: Identifiable {
        
        // var to count how many times the specific card has been seen
        var alreadySeenCount = 0
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
    
}

