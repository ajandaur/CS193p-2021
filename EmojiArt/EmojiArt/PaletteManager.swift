//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 11/3/21.
//

import SwiftUI

struct PaletteManager: View {
    // inject store into this view
    @EnvironmentObject var store: PaletteStore
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        // ALL NavigationLinks must have an accompying NavigationView
        NavigationView {
            // Sort of like a VStack.. List!
            List {
                ForEach(store.palettes) { palette in
                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
                        VStack(alignment: .leading) {
                            Text(palette.name)
                            Text(palette.emojis)
                        }
                        // when gesture is nil, it will not interfere with NavigationLink
                        // when in editMode, tap will occur to bring up UI
                        .gesture(editMode == .active ? tap: nil)
                    }
                }
                .onDelete { indexSet in
                    
                    store.palettes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.palettes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            .dismissable { presentationMode.wrappedValue.dismiss() }
            .toolbar {
                ToolbarItem {  EditButton() }
       
               
            }
            .environment(\.colorScheme, .dark)
            
            // bind the Edit Mode to a local variable in our view
            .environment(\.editMode, $editMode)
            
        }
        
    }
    
    var tap: some Gesture {
        TapGesture().onEnded { }
    }
}

struct PaletteManager_Previews: PreviewProvider {
    static var previews: some View {
        PaletteManager()
            .environmentObject(PaletteStore(name: "Preview"))
            .preferredColorScheme(.dark)
    }
}
