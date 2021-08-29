//
//  Pie.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/24/21.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    // AnimatablePair is a generic type so we need to specify the "don't care"
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatableData(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height)
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        // create an empty path and create arc
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        
        p.addLine(to: center)
        
        
        
        return p
    }
    
    
}
