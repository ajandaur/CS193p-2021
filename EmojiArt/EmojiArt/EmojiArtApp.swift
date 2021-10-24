//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    let paletteStore = PaletteStore(name: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
