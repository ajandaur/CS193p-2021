//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Anmol  Jandaur on 9/9/21.
//

import SwiftUI

class EmojiArtDocument: ObservableObject
{
    @Published private(set) var emojiArt: EmojiArtModel {
        
        didSet {
            autosave()
            if emojiArt.background != oldValue.background {
                fetchBackgroundImageDataIfNecessary()
            }
        }
    }
    private struct Autosave {
        static let filename = "Autosaved.emojiart"
        static var url: URL? {
            // for iOS we always use .userDomainMask
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return documentDirectory?.appendingPathComponent(filename)
        }
        static let coalescingInterval = 5.0
    }
    
    private var autosaveTimer: Timer?
    
    private func scheduleAutosave() {
        // cancel the previous timer
        autosaveTimer?.invalidate()
        autosaveTimer = Timer.scheduledTimer(withTimeInterval: Autosave.coalescingInterval , repeats: false) { _ in
            self.autosave()
        }
    }
    
    private func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    // Save EmojiArtDocument in file system via URL
    private func save(to url: URL) {
        let thisfunction = "\(String(describing: self)).\(#function)"
        do {
            let data: Data = try emojiArt.json()
            print("\(thisfunction) json = \(String(data: data, encoding: .utf8) ?? "nil")")
            try data.write(to: url)
            print("\(thisfunction) success!")
        } catch let encodingError where encodingError is EncodingError {
            print("\(thisfunction) couldn't encode EmojiArt as JSON because \(encodingError.localizedDescription)")
        } catch {
            print("\(thisfunction) error = \(error)")
        }
     
    }
    
    init() {
        if let url = Autosave.url, let autosavedEmojiArt = try? EmojiArtModel(url: url) {
            emojiArt = autosavedEmojiArt
            fetchBackgroundImageDataIfNecessary()
        } else {
            emojiArt = EmojiArtModel()
            // emojiArt.addEmoji("🧚🏻‍♂️", at: (-200, -100), size: 80)
            //  emojiArt.addEmoji("👨🏻‍🍼", at: (50, 100), size: 40)
        }
        }
       
    
    // computed vars
    var emojis: [EmojiArtModel.Emoji] { emojiArt.emojis }
    var background: EmojiArtModel.Background { emojiArt.background }
    
    @Published var backgroundImage: UIImage?
    @Published var backgroundImageFetchStatus = BackgroundImageFetchStatus.idle
    
    // when you add a case with an associated value, you must mark it Equatable
    enum BackgroundImageFetchStatus: Equatable {
        case idle
        case fetching
        case failed(URL)
    }
    
    private func fetchBackgroundImageDataIfNecessary() {
        // blank out the background iamge
        backgroundImage = nil
        switch emojiArt.background {
        case .url(let url):
            // fetch the url
            backgroundImageFetchStatus = .fetching
            
            // put this queue on another thread that is not the main one
            DispatchQueue.global(qos: .userInitiated).async {
                // try getting the data of the url and if not possible, return nil
                let imageData = try? Data(contentsOf: url)
                // when imageData returns, do the rest on back on the main queue asynchronously
                // you can redefine the variable as weak such that it doesn't force itself to
                // keep that self in to heap by turning it into an optional 
                DispatchQueue.main.async { [ weak self] in
                    if self?.emojiArt.background == EmojiArtModel.Background.url(url) {
                        self?.backgroundImageFetchStatus = .idle
                        if imageData != nil {
                            self?.backgroundImage = UIImage(data: imageData!)
                        }
                        if self?.backgroundImage == nil {
                            self?.backgroundImageFetchStatus = .failed(url)
                        }
                    }
                   
                }
               
            }
         
            
        case .imageData(let data):
            backgroundImage = UIImage(data: data)
        case .blank:
            break
        }
    }
    
    // MARK - Intent(s)
    
    func setBackground(_ background: EmojiArtModel.Background) {
        emojiArt.background = background
        print("background set to \(background)")
    }
    
    func addEmoji(_ emoji: String, at location: (x: Int, y: Int), size: CGFloat) {
        emojiArt.addEmoji(emoji, at: location, size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.index(matching : emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrAwayFromZero))
        }
    }
}

