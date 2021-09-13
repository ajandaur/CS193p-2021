//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import Foundation

extension EmojiArtModel {
    
    // background can only be three different things.. Enum !
    enum Background {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self {
            // if I am a URL, grab associated url and return it
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
        
    }
}
