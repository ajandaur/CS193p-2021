//
//  SetGameLogic.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import Foundation

struct SetGame {
    
    // cards in deck
    private(set) var deck: [Card]
    
    // all the cards
    private(set) var cards: [Card]
    
    // cards discarded
    private(set) var discardPile: [Card]
    
    // cards in play
    private(set) var selectedCards: [Card]
    
    // check if cards are left in deck
    private(set) var haveCardsInDeck = true
    
    // check if there is a match between three cards (Set is found)
    private(set) var setFound: Bool = false
    
    // check if three cards are selected
    private(set) var threeCardsChosen: Bool = false
    
    // number of cards that start off in the game
    private let initialCardCount = 12
    
    // score of the game
    private(set) var score = 0

    
    mutating func choose(_ card: Card) {
        
        // if user clicks on a card that is a set, simply return
        if cards.contains(where: { $0.id == card.id}) && setFound && threeCardsChosen {
            return
        }
        
        // if three cards are selected and they are a set, remove them from cards array and discard
        if threeCardsChosen && setFound {
            for i in 0..<3 {
                cards.removeAll(where:  { $0.id == selectedCards[i].id })
            }
            
            for cardInPlay in selectedCards {
                discardPile.append(cardInPlay)
            }
            
            // remove the rest of the cards in play??
            selectedCards.removeAll()
            
            // if the card is a set, add three points
            score += 3
            
            setFound = false
            threeCardsChosen = false
            
            // three cards were chosen but no set was found
        } else if threeCardsChosen && !setFound {
            for i in 0..<3 {
                if let chosenIndex = cards.firstIndex(where: { $0.id == selectedCards[i].id}) {
                    cards[chosenIndex].isSelected = false
                }
            }
            selectedCards.removeAll()
            
            // decrement score because the cards are not a set
            score -= 3
            
            // reset
            threeCardsChosen = false
        }
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if !cards[chosenIndex].isSelected {
                // if card is not selected, select and do something
                
                selectedCards.append(cards[chosenIndex])
                
                if selectedCards.count == 3 {
                    if isSet(cards: selectedCards) {
                        setFound = true
                    }
                    threeCardsChosen = true
                }
                cards[chosenIndex].isSelected = true
            } else {
                // if another card is selected after 3 cards are already selected
                if !(selectedCards.count == 3 ) && !setFound {
                    selectedCards.removeAll(where: { $0.id == cards[chosenIndex].id })
                }
            }
        }
        
    }
    
    
    private struct SetGameConstants {
        private let SetSize = 3
        private let scoreIncrement = 5
        private let scoreDecrement = -5
    }
    
    
    struct Card: Identifiable {
        let color: CardColor
        let shading: CardShading
        let shapeNumber: CardNumber
        let shapeType: CardShape
        
        var isSelected = false
        
        var id: Int
        
        enum CardColor: CaseIterable, Comparable {
            case red, blue, green
            
            static let properties = [red, blue, green]
        }
        
        enum CardShading: CaseIterable, Comparable {
            case solid, striped, outline
            
            static let properties = [solid, striped, outline]
        }
        
        enum CardNumber: CaseIterable, Comparable {
            case one, two, three
            
            static let properties = [one, two, three]
        }
        
        enum CardShape: CaseIterable, Comparable {
            case diamond, squiggle, oval
            
            static let properties = [diamond, squiggle, oval]
        }
        
    } // CARD STRUCT

}


