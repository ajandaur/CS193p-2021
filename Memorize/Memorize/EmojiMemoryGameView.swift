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
                .foregroundColor(game.getPrimaryColor())
                .padding(.horizontal)
                
    
           
            
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
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                    .scaleEffect(0.6)
                
                Text(card.content)
                    // The card comes on screen with a rotation of 360, such that it is already rotated
                    // This problem can be fixed via 
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    // Font is a viewModifier that is NOT Animatable
                    .font(Font.system(size: DrawingConstants.fontSize))
                    // the scaleEffect() does animate
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    // Constants
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.5
        static let fontSize: CGFloat = 32
        
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
    
    func cardify(isFaceUp: Bool, gradient: LinearGradient) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
       
    }
}
