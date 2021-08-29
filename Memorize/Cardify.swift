//
//  Cardify.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/28/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool, gradient: LinearGradient) {
        rotation = isFaceUp ? 0: 180
        self.gradient = gradient
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var gradient: LinearGradient
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            // if rotation is < 90, we are showing the front
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
           
            } else {
                shape.fill(gradient)
            }
            // This card is always on screen but we apply an opacity so that the game still works properly
            content
                // opaque when we are face up
                .opacity(rotation < 90 ? 1 : 0)
        }
                
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0, 1, 0)
        )
    }
    
    // Constants
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3

        
    }
    
}
