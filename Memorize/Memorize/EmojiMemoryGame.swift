//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 8/6/21.
//

//ViewModel is a UI thing because it knows how it is going to be drawn on-screen

//It is a "doorway" from view to get to the model!
// The view talks to the viewModel
// the ViewModel NEVER talks to the view, many views share the viewModel
import SwiftUI

// classes are mutable and can be changed via pointers 
class EmojiMemoryGame: ObservableObject {
    
    // typealias
    typealias Card = MemoryGame<String>.Card
    
    // Need to define the type of MemoryGame, in this case we are using emojis. Therefore, we are going to use type "String"
    // "@Published" = anytime the model changes, objectWillChange.send() occurs
    @Published private var model: MemoryGame<String>
    
    // There can be multiple model vars, they are conceptual entities!
    @Published private var currentThemeModel: Theme<String>
    
    // Initialize the model with the theme
    
    init() {
        let currentTheme = Theme<String>(theme: themes.randomElement()!)
        let uniqueContent = currentTheme.returnContentForTheGame()

        model = MemoryGame<String>(numberOfPairsOfCards: currentTheme.numberOfPairs) { pairIndex in
            uniqueContent[pairIndex]
        }
        currentThemeModel = currentTheme
    }
    
     func createNewMemoryGame() {
        let currentTheme = Theme<String>(theme: themes.randomElement()!)
        let uniqueContent = currentTheme.returnContentForTheGame()

        model = MemoryGame<String>(numberOfPairsOfCards: currentTheme.numberOfPairs) { pairIndex in
            uniqueContent[pairIndex]
        }
        currentThemeModel = currentTheme
    }
    
    // MARK: - Interpretation of themes
    
    // set of Themes
    private var themes = [
        Theme<String>(setOfContent: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
                      numberOfPairs: 12,
                      primaryThemeColor: "orange",
                      secondaryThemeColor: "black",
                      themeName: "Halloween",
                      showFewerPairs: true),
        
        Theme<String>(setOfContent: ["🥭","🍒","🍈","🫐","🍇","🍉","🍓","🍊","🍋","🍌","🍐","🍏"],
                      numberOfPairs: 12,
                      primaryThemeColor: "red",
                      secondaryThemeColor: "primary",
                      themeName: "Food & Drinks",
                      showFewerPairs: true),
        
        Theme<String>(setOfContent: ["🐶","🦁","🐯","🐨","🐻‍❄️","🐼","🐻","🦊","🐰","🐹","🐭","🐱"],
                      numberOfPairs: 12,
                      primaryThemeColor: "green",
                      secondaryThemeColor: "blue",
                      themeName: "Animals",
                      showFewerPairs: true),
    
        Theme<String>(setOfContent: ["🏀","⚽️","🏈","⚾️","🥎","🏐","🏓","🎳","🏸","🏒","🎾","🏏"],
                      primaryThemeColor: "blue",
                      secondaryThemeColor: "yellow",
                      themeName: "Sports"),
        
        Theme<String>(setOfContent: ["🚗","🛻","🚐","🚒","🚑","🚓","🏎","🚎","🚌","🚙","🚕","🛺"],
                      primaryThemeColor: "gray",
                      secondaryThemeColor: "white",
                      themeName: "Transportation"),
        
        Theme<String>(setOfContent: ["📱","📀","📷","💾","🖲","🕹","🖨","🖥","💻","⌨️","📲","🖱"],
                      primaryThemeColor: "purple",
                      secondaryThemeColor: "blue",
                      themeName: "Technology")
    
    ]
    
    func getPrimaryColor() -> Color {
        switch currentThemeModel.primaryThemeColor {
        case "red":
            return .red
        case "orange":
            return .orange
        case "green":
            return .green
        case "blue":
            return .blue
        case "gray":
            return .gray
        case "purple":
            return .purple
        default:
            return .red
        }
    }
    
    func getSecondaryColor() -> Color {
        switch currentThemeModel.secondaryThemeColor {
        case "black":
            return .black
        case "primary":
            return .primary
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        default:
            return .primary
        }
    }
    
    // MARK: - Access to the Model
    var cards: [Card] {
        model.cards
    }
    
    var themeName: String {
        currentThemeModel.themeName
    }
    
    var score: Int {
         model.score
    }
    
    // create a radial gradient with the accent color
    var themeGradient: LinearGradient {
        return LinearGradient(gradient:
                                Gradient(colors: [getPrimaryColor(),
                                                  getSecondaryColor()]),
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
