//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Samuel Alake on 1/17/22.
//

import Foundation

struct MemoryGameModel<CardContent:Equatable>{
    private(set) var cards: [Card]
    private(set) var theme: Theme
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            let faceUpCardIndices = cards.indices.filter({cards[$0].isFaceUp})
            return faceUpCardIndices.oneAndOnly
        }
        set{
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)})
            //alternatively
//            for index in cards.indices{
//                cards[index].isFaceUp = (index == newValue)
//            }
        }
    }
    
    mutating func choose(_ card: Card){
        //if let chosenIndex = index(of: card)
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }else{
                    //if card is involved in mismatch
                    if cards[chosenIndex].isSeen{
                        score -= 1
                    }
                }
            cards[chosenIndex].isFaceUp = true
            cards[chosenIndex].isSeen = true
            } else {
                for index in cards.indices {
                    //cards.indices is same as 0..<cards.count
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }

        }
        //print("\(cards)")
    }
    
    private var indexToStartFrom: Int? {
        mutating get{
            if(theme.numberOfPairsOfCards < theme.setOfEmoji.count){
                return Int.random(in: 0...(theme.setOfEmoji.count - theme.numberOfPairsOfCards))
            }else{
                theme.numberOfPairsOfCards = theme.setOfEmoji.count
                return 0
            }
        }set{
            
        }
    }
    
    init(theme: Theme, createCardContent: (Int) -> CardContent){
        self.score = 0
        self.theme = theme
        cards = [] //Array<Card>()
        //append content to cards twice to satisy numberOfPairsOfCards
        
        if let randomStartIndex = indexToStartFrom{
            for pairIndex in randomStartIndex..<(randomStartIndex + theme.numberOfPairsOfCards){
                let content = createCardContent(pairIndex)
                cards.append(Card(content: content))
                cards.append(Card(content: content))
            }
        }
        
        cards.shuffle()
    }
    
    struct Card : Identifiable{
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
    }
}

extension Array{
    var oneAndOnly: Element?{
        if count == 1{
            return first
        }else{
            return nil
        }
    }
}

/*
 // deprecated func
 func index(of otherCard: Card) -> Int? {
     for (index, value) in cards.enumerated(){
         if value.id == otherCard.id{
             return index
         }
     }
     return nil
 }
*/
