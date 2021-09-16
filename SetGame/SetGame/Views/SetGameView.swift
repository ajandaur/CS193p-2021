//
//  SetGameView.swift
//  SetGame
//
//  Created by Anmol  Jandaur on 9/1/21.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGameVM
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
