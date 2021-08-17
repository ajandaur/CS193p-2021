//
//  ContentView.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 7/22/21.
//

import SwiftUI

struct ContentView: View {
    // instance of the viewModel
    // "@ObservedObject
    @ObservedObject var game: EmojiMemoryGame
    

    @State var randomNumberOfEmojis = 13

    // Extra credit 2: try to come up with some sort of equation that relates the number of cards in the game to the width I pass when I create LazyVGrid
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        if (0...4).contains(cardCount) {
            return 150
        } else if (5...9).contains(cardCount) {
            return 110
        } else {
            return 80
        }
    }
    
    var body: some View {
      
        VStack{
            
            // Game Title
            
            Text("Memorize!")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.blue)
       
              
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: randomNumberOfEmojis)))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                // Intent function
                                game.choose(card)
                            }
                    }
                }
            }
            
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehiclesButton
                
                peoplesButton
            
                animalsButton
                
            }
            
        }
        .padding(.horizontal)
        
    }
    
    // Vehicles theme
    var vehiclesButton: some View {
        Button {
            EmojiMemoryGame.emojis = ["🚊","🚀","🚁","🛶","🚗","🚕","🚙","🚌","🚎","🛥","🛳","⛴","🚢"].shuffled()
        } label: {
            VStack {
                Image(systemName: "car.fill")
                    .font(.largeTitle)
                Text("Vehicles")
                    .font(.headline)
            }
        }
    }

    
    // people theme
    var peoplesButton: some View {
        Button {
            EmojiMemoryGame.emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🐮","🐷","🙊","🐧","🐦","🐤"].shuffled()
        } label: {
            VStack {
                Image(systemName: "person.3.fill")
                    .font(.largeTitle)
                Text("People")
                    .font(.headline)
            }
        }
    }
    
    // animals theme
    var animalsButton: some View {
        Button {
            EmojiMemoryGame.emojis = ["👶🏻","👦🏻","👨🏾‍🦰","👩🏼‍🦳","👵🏾","👲🏻","👳🏼‍♀️","🧕🏽","👮🏼‍♀️","👷🏻‍♀️","💂🏼","🕵🏻‍♂️","👩🏼‍🌾","👨🏻‍🍳","👼🏻"].shuffled()
        } label: {
            VStack {
                Image(systemName: "hare.fill")
                    .font(.largeTitle)
                Text("People")
                    .font(.headline)
            }
        }
    }
}



struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(game: game)
            .preferredColorScheme(.dark)
        ContentView(game: game)
            .preferredColorScheme(.light)
    }
}
