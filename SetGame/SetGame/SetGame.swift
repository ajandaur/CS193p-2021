//
//  SetGameLogic.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import Foundation

struct SetGame<CardContent> where CardContent: Equatable {
    // cards in deck
    private(set) var deck: [Card]
    // cards in play
    private(set) var cardsInPlay: [Card]
    // cards discarded
    private(set) var discardPile: [Card]
    
    private var chosenCards: [Card] {
        cardsInPlay.filter( { $0.isSelected })
    
    }
    
    private struct SetGameConstants {
        private let SetSize = 3
        private let scoreIncrement = 5
        private let scoreDecrement = -5
    }
    
    
    struct Card: Identifiable {
        var id: UUID
        let color: Color
        let shading: Shading
        let shapeNumber: Number
        let shapeType: Shape
        
        var isMatched = false
        var isSelected = false
        
        static var allCard: [Card] {
            var cards: [Card] = []
            for color in Color.allCases {
                for shading in Shading.allCases {
                    for shapeNumber in Number.allCases {
                        for shapeType in Shape.allCases {
                            cards.append(Card(id: UUID(), color: color, shading: shading, shapeNumber: shapeNumber, shapeType: shapeType))
                        }
                    }
                }
            }
            return cards
        }
        
        enum Color: CaseIterable {
            case red, blue, green
            
            var attribute: Color {
                switch self {
                case .red: return .red
                case .blue: return .blue
                case .green: return .green
                }
            }
        }
        
        enum Shading: CaseIterable {
            case solid, striped, outline
        }
        
        enum Number: CaseIterable {
            case one, two, three
        }
        
        enum Shape: CaseIterable {
            case diamond, squiggle, oval
        }
        
    }

}


