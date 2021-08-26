//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Anmol  Jandaur on 7/22/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // instance of the viewModel
    // "@ObservedObject"
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        VStack{
            HStack {
                // Theme Title
                
                Text(game.themeName)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(game.getPrimaryColor())
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(game.getPrimaryColor(), lineWidth: 5)
                    )
                
            }
            .padding()
            
            
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    } else {
                        CardView(card: card, gradient: themeGradient)
                            .padding(4)
                            .onTapGesture {
                                // Intent function
                                game.choose(card)
                            }
                    }
                }
            
                .padding(.horizontal)
                .foregroundColor(game.getPrimaryColor())
    
           
            
            HStack {
                // Score title
                Text("Score: \(game.score)")
                    .gradientForeground(colors: [.red, .blue])
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    game.createNewMemoryGame()
                }, label: {
                    VStack {
                        Image(systemName: "arrow.clockwise")
                        Text("New Game")
                            .gradientForeground(colors: [.red, .blue])
                    }
                })
            }
            .padding(.horizontal)
            
        }

    }

    
    // create a radial gradient with the accent color
    var themeGradient: LinearGradient {
        return LinearGradient(gradient:
                                Gradient(colors: [game.getPrimaryColor(),
                                                  game.getSecondaryColor()]),
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
    }
}


struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    let gradient: LinearGradient
    
    var body: some View {
        // GeometryReader is going to use ALL its space that is offered to it
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstants.lineWidth)
                    
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(DrawingConstants.piePadding)
                        .opacity(DrawingConstants.pieOpacity)
                        .scaleEffect(x: 0.5, y: 0.5)
                        
                    
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill(gradient)
                }
            }
            
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    
    
    // Constants
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.5
        
    }
}



// Gradient foreground for score and new game button
extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
       
    }
}
