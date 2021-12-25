//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 10/30/21.
//

import SwiftUI

struct PaletteEditor: View {
    // use @Binding to edit something in the Model
    @Binding var palette: Palette
    
    var body: some View {
        Form {
           nameSection
            addEmojiSection
            removeEmojiSection
        }
        .navigationTitle("Edit \(palette.name)")
        // enforce these minimums
        .frame(width: 300, height: 350)
        
    }
    
    var nameSection: some View {
        // can have formal section
        Section(header: Text("Name")) {
            TextField("Name", text: $palette.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojiSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
               
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        // add emojis to palette
        palette.emojis = (emojis + palette.emojis)
            .filter { $0.isEmoji }
            .removingDuplicateCharacters
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = palette.emojis.removingDuplicateCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                palette.emojis.removeAll(where: { String($0) == emoji })
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor(palette: .constant(PaletteStore(name: "Preview").palette(at: 4)))
            .previewLayout(.fixed(width: 300, height: 350))
    }
}
