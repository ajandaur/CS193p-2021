//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import Foundation

struct EmojiArtModel {
    
    // the background
    var background = Background.blank
    
    // emojis array -> don't want them private(set) because we want the UI to move them around and resize
    var emojis = [Emoji]()
    
    // Making Emoji Hashable because we are going to be putting them into a Set when organizing..
    struct Emoji: Identifiable, Hashable {
        // use let so we can't change the emoji on the fly
        let text: String
        
        // Using Ints not CGFloats !
        var x: Int // offset from the center
        var y: Int // offset from the enter
        var size: Int
        let id: Int
        
        // how to prevent creating an Emoji with a bad id? -> little trick
        
        // fileprivate = anyone in the file can use this -> no one can create an emoji except us!
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    // to prevent user from using free init from EmojiArtModel model
    init()  { }
    
    private var uniqueEmojiId = 0

    // tuple is a light-weight struct
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int)
    {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
    }
    

    
}
