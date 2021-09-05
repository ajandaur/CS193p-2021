//
//  Diamond.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/2/21.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
            // center it
        let center = CGPoint(x: rect.midX, y: rect.midY)
            // starting point on right side
        let starting = CGPoint(x:rect.maxX, y: center.y)
        p.move(to: starting)
        
        // create all the points of a diamond
        let secondPoint = CGPoint(x: center.x, y: rect.maxY)
        let thirdPoint = CGPoint(x: rect.minX, y: center.y)
        let fourthPoint = CGPoint(x: center.x, y: rect.minY)
        
        // Create the movement
        p.addLines([secondPoint, thirdPoint, fourthPoint])
        return p
        
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
