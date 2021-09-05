//
//  SetGameApp.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    private let game = SetGameVM()
    var body: some Scene {
      
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
