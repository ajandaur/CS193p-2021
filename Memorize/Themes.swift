//
//  Themes.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/18/21.
//

import Foundation

/// A Theme consists of: name, set of emoji to use, number of pairs of cards, appropriate color to use

// This is considered part of the Model, it must be UI-independent!

struct Theme<CardContent> {
    let themeName: String
    let setOfContent: [CardContent]
    let primaryThemeColor: String
    let secondaryThemeColor: String
    var numberOfPairs: Int
    let showFewerPairs: Bool
    
    func returnContentForTheGame() -> [CardContent] {
        let shuffledCards = setOfContent.shuffled()
        var uniqueRandomContentForGame: Array<CardContent> = []
        for pairIndex in 0..<numberOfPairs {
            uniqueRandomContentForGame.append(shuffledCards[pairIndex])
        }
        return uniqueRandomContentForGame
    }
    
    // init for Theme
    init(theme: Theme<CardContent>) {
        self.themeName = theme.themeName
        self.setOfContent = theme.setOfContent
        self.numberOfPairs = theme.showFewerPairs ? Int.random(in: 1..<theme.setOfContent.count) : theme.setOfContent.count
        self.primaryThemeColor = theme.primaryThemeColor
        self.secondaryThemeColor = theme.secondaryThemeColor
        self.showFewerPairs = theme.showFewerPairs
    }
    
    // init with all the arguments
    init(setOfContent: [CardContent], numberOfPairs: Int, primaryThemeColor: String, secondaryThemeColor: String, themeName: String, showFewerPairs: Bool) {
        if showFewerPairs {
            self.numberOfPairs = Int.random(in: 1..<setOfContent.count)
        }
        else {
            self.numberOfPairs = numberOfPairs
        }
        self.setOfContent = setOfContent
        self.primaryThemeColor = primaryThemeColor
        self.secondaryThemeColor = secondaryThemeColor
        self.showFewerPairs = showFewerPairs
        self.themeName = themeName
        
    }
    
    
    // init with default showFewerPairs and numberOfPairs
    init(setOfContent: [CardContent],  primaryThemeColor: String, secondaryThemeColor: String, themeName: String) {
        self.themeName = themeName
        self.setOfContent = setOfContent
        self.numberOfPairs = setOfContent.count
        self.primaryThemeColor = primaryThemeColor
        self.secondaryThemeColor = secondaryThemeColor
        self.showFewerPairs = false
    }
    
    
}

