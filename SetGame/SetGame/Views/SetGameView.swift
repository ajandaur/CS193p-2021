//
//  SetGameView.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameVM
    
    @Namespace private var dealingNameSpace
    
    var body: some View {
        Text("Hello")
    }
}


struct CardView: View {

    
    var body: some View
    {
        Text("")
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameVM()
        SetGameView(game: game)
    }
}
