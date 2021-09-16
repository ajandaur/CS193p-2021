//
//  StripedShadingView.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/14/21.
//

import SwiftUI

struct StripedShadingView<T>: View where T: Shape {
    let numberOfStripes: Int = 4
    let lineWidth: CGFloat = 2
    let borderLineWidth: CGFloat = 1
    let shape: T
    let color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numberOfStripes) { number in
                Color.white
                color.frame(width: lineWidth)
                if number == numberOfStripes - 1 {
                    Color.white
                }
            }
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
    }
}

struct StripedShadingView_Previews: PreviewProvider {
    static var previews: some View {
        StripedShadingView(shape: Diamond(), color: .red)
    }
}
