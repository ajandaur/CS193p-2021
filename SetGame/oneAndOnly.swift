//
//  oneAndOnly.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import Foundation

// extension
extension Array {
    // return whats in the array if its the one and only thing in the array
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            // if there are multiple or 0 face-up cards
            return nil
        }
    }
}
