//
//  CardSymbolView.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/14/21.
//

import SwiftUI


typealias Card = SetGame.Card

struct CardSymbolView: View {
    let card: Card
    
    var body: some View {
        switch card.shapeType {
        case .diamond:
            if card.shading == .striped {
                StripedShadingView(shape: Diamond(), color: cardColor(card))
                    .foregroundColor(cardColor(card))
            } else {
                Diamond().fill(Color.white)
                Diamond().fill(cardColor(card)).opacity(cardShading(card))
                Diamond()
                    .stroke(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(cardColor(card))
                
            }
            
        case .squiggle:
            if card.shading == .striped {
                StripedShadingView(shape: Squiggle(), color: cardColor(card))
                    .foregroundColor(cardColor(card))
            } else {
                Squiggle().fill(Co)
            }
            
        case .oval:
            
        }
    }
    
    private func cardColor(_ card: Card) -> Color {
        switch card.color {
        case .green:
            return .green
        case .blue:
            return .blue
        case .red:
            return .red
        }
    }
    
    private func cardShading(_ card: Card) -> Double {
        switch card.shading {
        case .outline:
            return 0
        case .solid:
            return 1
        case .striped:
            return 0.5
        }
    }
    
    private struct DrawingConstants {
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 1
    }
    
        
}

struct CardSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card.init(color: .green, shading: .striped, shapeNumber: .two, shapeType: .diamond, id: 12)
        CardSymbolView(card: card)
    }
}
