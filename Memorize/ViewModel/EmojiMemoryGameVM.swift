//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by Samuel Alake on 1/17/22.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject{
    typealias Card = MemoryGameModel<String>.Card
    
    private static let arrayOfThemes = [
        Theme(name: "Vehicles", setOfEmoji: ["🚗", "🚀", "🛩", "🛫", "🚈", "🛺", "🚡", "🚖"], numberOfPairsOfCards: 6, color: Color.red),
        Theme(name: "Food", setOfEmoji: ["🍔", "🌭", "🌮", "🌯", "🥙"], numberOfPairsOfCards: 4, color: Color.blue),
        Theme(name: "Sports", setOfEmoji: ["⚽️", "🏀", "🏈", "🥎", "🏐"], numberOfPairsOfCards: 5, color: Color.green)
    ]
    
    private static func generateRandomInt() -> Int{
        return Int.random(in: 0..<arrayOfThemes.count)
    }
    
    @Published private var model: MemoryGameModel<String> = createMemoryGame(theme: arrayOfThemes[generateRandomInt()])
    //private keeps everything in model private
    
    private static func createMemoryGame(theme: Theme) -> MemoryGameModel<String>{
        //MemoryGameModel accepts a function that returns an emoji string depending on the given index
        MemoryGameModel<String>(theme: theme){ pairIndex in
            theme.setOfEmoji[pairIndex]
        }
    }
    
    var cards: [Card]{
        return model.cards
    } //using this variable as a getter to expose only the cards in the model. similar type to 'cards' in 'MemoryGameModel'
    
    var theme: Theme{
        return model.theme
    }
    
    var score: Int{
        return model.score
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func newGame(){
        model = EmojiMemoryGameVM.createMemoryGame(theme: EmojiMemoryGameVM.arrayOfThemes[EmojiMemoryGameVM.generateRandomInt()])
    }
}
