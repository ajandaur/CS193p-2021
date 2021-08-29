//
//  Cardify.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/28/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    let gradient: LinearGradient
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
           
            } else {
                shape.fill(gradient)
            }
            // This card is always on screen but we apply an opacity so that the game still works properly
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    // Constants
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3

        
    }
    
}
