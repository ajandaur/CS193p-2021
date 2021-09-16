//
//  Squiggle.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/2/21.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: CGPoint(x: rect.minX, y: rect.midY/2))
        
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY-rect.midY*(3/4)))
        p.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY-rect.midY/2), control: CGPoint(x: rect.maxX-rect.midX/2, y: rect.maxY))
        
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY*(3/4)))
        p.addQuadCurve(to: CGPoint(x: rect.minX , y: rect.midY/2), control: CGPoint(x: rect.midX/2 , y: rect.minY))
        
        return p
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
    }
}
