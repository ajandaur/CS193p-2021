//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    // doesn't quite want to be a let..
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
