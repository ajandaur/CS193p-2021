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
    
    
    // set of Ints which are the identifiers for our cards
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id } ) {
            delay = Double(index) * (CardConstants.dealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Group {
                shuffle
                deckBody
            }
            .padding()
            
            
            VStack{
                themeTitle
                
                VStack {
                    gameBody
                    
                }
                .padding()
                
                HStack {
                    score
                        .offset(x: -12)
                    Spacer()
                    newGame
                }
                .padding()
            }
        }
        
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    // Theme title
    var themeTitle: some View {
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
    }
    
    // Score text
    var score: some View {
        // Score title
        Text("Score: \(game.score)")
            .gradientForeground(colors: [.red, .blue])
            .padding(.horizontal, 20)
            .padding(.vertical)
            .font(.title)
    }
    //newGame Button
    var newGame: some View {
        Button(action: {
            withAnimation {
                dealt = []
                game.createNewMemoryGame()
            }
        }, label: {
            VStack {
                Image(systemName: "arrow.clockwise")
                Text("New Game")
                    .gradientForeground(colors: [.red, .blue])
            }
        })
    }
    // gameBody
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            
            if  isUndealt(card) || card.isMatched && !card.isFaceUp {
                // Color can behave like a View in some scenarios
                Color.clear
            } else {
                CardView(card: card, gradient: game.themeGradient)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            // Intent function
                            game.choose(card)
                        }
                    }
            }
        }
        
        .foregroundColor(game.getPrimaryColor())
    }
    
    var shuffle: some View {
//        Button("Shuffle") {
//            withAnimation {
//                game.shuffle()
//            }
//
//        }
        
        Button(action: {
            withAnimation {
                game.shuffle()
            }
        }, label: {
            VStack {
                Image(systemName: "shuffle")
                Text("Shuffle")
            }
        })
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card, gradient: game.themeGradient)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // "deal" cards
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
            
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    
    let gradient: LinearGradient
    
    var body: some View {
        // GeometryReader is going to use ALL its space that is offered to it
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 1-animatedBonusRemaining*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                        
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 1-card.bonusRemaining*360-90))
                    }
                }
                .padding(DrawingConstants.piePadding)
                .opacity(DrawingConstants.pieOpacity)
                .scaleEffect(0.5)
                
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
        return EmojiMemoryGameView(game: game)
        
    }
}
