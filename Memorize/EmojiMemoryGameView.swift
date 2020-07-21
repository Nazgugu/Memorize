//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Zhe Liu on 6/27/20.
//  Copyright © 2020 Zhe Liu. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var currentGame: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Theme: \(currentGame.currentThemeName)")
                    .font(.footnote)
                    .fontWeight(.bold)
                Spacer()
                Text("Score: \(currentGame.currentScore)")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.currentGame.resetGame()
                    }
                }, label: {
                    Text("New Game")
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                })
            }.padding()
            
            Grid(currentGame.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.75)) {
                                    self.currentGame.choose(card: card)
                                }
                            }
                            .padding(5)
                    }
                    .padding()
                    .foregroundColor(.orange)
                
            }
        }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
             ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360 - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
          }
    }
    
    //MARK: - Layout Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.65
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(currentGame: game)
    }
}
