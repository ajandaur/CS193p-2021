//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    // use @StateObject so that you can search it for the source of truth
    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(name: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
                // inject into EmojiArtDocumentView and all other views that pass it along
                .environmentObject(paletteStore)
        }
    }
}
