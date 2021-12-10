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
    @StateObject var paletteStore = PaletteStore(name: "Default")
    
    // A scene is just a high level container that contains the app 
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)
                // inject into EmojiArtDocumentView and all other views that pass it along
                .environmentObject(paletteStore)
        }
    }
}
