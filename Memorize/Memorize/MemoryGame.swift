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
    
    mutating func shuffle() {
        cards.shuffle()
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
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
}

