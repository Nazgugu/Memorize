//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zhe Liu on 7/1/20.
//  Copyright © 2020 Zhe Liu. All rights reserved.
//

import SwiftUI

enum EmojiTheme: String, CaseIterable {
    case Halloween = "👻🎃🕷😈🧹🙀👀🧛‍♂️🧚‍♀️"
    case Christmas = "❄️⛄️👨‍👩‍👧🎅🎄🎁🔔"
    case China = "🇨🇳🐲🀄️🏓🥢🥡❤️🥟🥮"
    case Food = "🍔🍟🍕🥪🥙🌮🥘🍜🍛🍣🍱🍰🍦"
    case Fruit = "🍎🍐🍊🍋🍌🍉🍒🍓🍑🥭🥝"
    case Transportation = "🚗🚕🚙🚌🚎🏎🚐🛴🚲🛵🏍🚄✈️🛳"
    
    func getThemeName() -> String {
        switch self {
        case .Halloween:
            return "Halloween"
        case .Christmas:
            return "Christmas"
        case .China:
            return "China"
        case .Food:
            return "Food"
        case .Fruit:
            return "Fruit"
        case .Transportation:
            return "Transportation"
        }
    }
}

class EmojiMemoryGame: ObservableObject {
    // private(set) means only EmojiMmeoryGame class object can access(update) the game, but all other object can still see the value of the game
    @Published private var game: MemoryGame<String>
    
    fileprivate var currentTheme: EmojiTheme
    
    init() {
        currentTheme = EmojiTheme.allCases.randomElement()!
        game = EmojiMemoryGame.createMemoryGame(of: currentTheme)
    }
    
    private func reset() {
        currentTheme = EmojiTheme.allCases.randomElement()!
        game = EmojiMemoryGame.createMemoryGame(of: currentTheme)
    }
    
    private static func createMemoryGame(of theme: EmojiTheme) -> MemoryGame<String> {
        let chosenEmojiCollection = theme.rawValue
        let randomCardNum = Int.random(in: 1...chosenEmojiCollection.count)
        return MemoryGame<String>(numberOfPairsOfCards: randomCardNum) { pairIndex in
            return chosenEmojiCollection[pairIndex]
        }
    }
        
    // MARK: - Access To The Model
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var currentThemeName: String {
        return currentTheme.getThemeName()
    }
    
    var currentScore: Int {
        return game.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    func resetGame() {
        reset()
    }
}
