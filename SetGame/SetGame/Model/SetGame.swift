//
//  SetGameLogic.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import Foundation

struct SetGame {
    
    
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


