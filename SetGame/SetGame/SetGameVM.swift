//
//  SetGame.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import SwiftUI

class SetGameVM: ObservableObject {
    @Publishedprivate var model: SetGame<CardContent>
    
    private static func createSetGame() -> SetGame<Shape> {
        //
    }
    
    init() {
        model = SetGameVM.createSetGame()
    }
    
    func newGame() {
        model = SetGameVM.createSetGame()
    }
    
    // MARK: Access tothe Model
    var cards: Array<SetGame<Shape>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    
    //MARK: Intents
    func choose(card: SetGame<Shape>.Card) {
        model.choose(card: card)
    }
    
    
}

