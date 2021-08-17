//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 7/22/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // creating an EmojiMemoryGame() due to the free init that classes have that does nothing
    // "let game" is a pointer to the class. The pointer can't change, but what it points to can be changed
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
