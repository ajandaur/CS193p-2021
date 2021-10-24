//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import Foundation

extension EmojiArtModel {
    
    // background can only be three different things.. Enum !
    // Swift knows how to equate enums, url, and data
    enum Background: Equatable, Codable {
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // if you try to decode a URL and it fails, we want to turn it into a nil if it fails
            // we do this since if the URL fails, we are returning no image data or something blank
            if let url = try? container.decode(URL.self, forKey: .url) {
                self = .url(url)
            } else if let imageData = try? container.decode(Data.self, forKey: .imageData) {
                self = .imageData(imageData)
            } else {
                self = .blank
            }
        }
        
        // mark CodingKeys with Coding Key Protocol
        enum CodingKeys: String, CodingKey {
            case url = "theURL"
            case imageData
        }
        
        func encode(to encoder: Encoder) throws {
            // create a container and tell container type of keys
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .url(let url): try container.encode(url, forKey: .url)
            case .imageData(let data): try container.encode(data, forKey: .imageData)
            case .blank: break
            }
        }
        
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
