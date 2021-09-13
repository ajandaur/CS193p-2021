//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    // view model
    // You really don't want to use equals since to initialize..
    //
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.yellow
                ForEach(document.emojis)  { emoji in
                    Text(emoji.text)
                        // where do these emojis go and what size??
                        .font(.system(size: fontSize(for: emoji)))
                        .position(position(for: emoji, in: geometry))
                }
            }
            // What kinds of things do you want dropped on you??
            .onDrop(of: [.plainText], isTargeted: nil) { providers, location in
                // return whether the drop was successful
                return drop(providers: providers, at: location, in: geometry)
            }
        }
        
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool
    {
        // see if these providers have a string and if they do have a string -> call the closure with the string bound in there (asynchronously)
        return providers.loadObjects(ofType: String.self) { string in
            // make sure you are only passing in emojis
            if let emoji = string.first, emoji.isEmoji {
                document.addEmoji(
                    String(emoji),
                    at: convertToEmojiCoordinates(location, in: geometry),
                    size: defaultEmojiFontSize)
            }
        }
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
        
        // TODO: -  need to modify size via pinch gesture..
    }
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        // everythign in the "Emoji-world" is off center
        let location = CGPoint(
            x: location.x - center.x,
            y: location.y - center.y
        )
        // return tuple
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        // frame returns a CGRect
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x),
            y: center.y + CGFloat(location.y)
        )
    }
    
    var palette: some View {
        ScrollingEmojiView(emojis: testEmojis)
            // this font will propagate up through the ScrollingEmojiView to affect the size
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😆😅😔😣😳🥱💀😽😸🦿👤👱🏻👨🏼‍🌾🧑🏻‍🍳👩🏽‍💼👰🏻🧙🏻‍♂️🧚🏽"
}

struct ScrollingEmojiView: View {
    
    let emojis: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // using map here for the first time !
                // Take anything we an sequence through and it maps it to an array and does the following expression to them
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
    
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
