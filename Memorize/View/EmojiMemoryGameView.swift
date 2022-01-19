//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Samuel Alake on 1/17/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGameVM
    
    var body: some View {
        VStack {
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text("Category:").foregroundColor(Color(UIColor.secondaryLabel))
                        .font(.title3).bold()
                    Text(viewModel.theme.name)
                        .font(.title).bold()
                }
                
                Spacer()
                HStack{
                    Text("Score:")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text(String(viewModel.score))
                        .bold()
                }
            }
            .padding()

            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3){ card in
                if card.isMatched && !card.isFaceUp{
                    Rectangle().opacity(0)
                }else{
                    CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                }
                
                }
            }
                .foregroundColor(viewModel.theme.color)
            .padding(.horizontal)
            
            Button{
                viewModel.newGame()
            }label:{
                Label("New Game", systemImage: "plus.circle")
            }
            
        }
    
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameVM()
        //game.choose(game.cards.first!)
        return EmojiMemoryGameView(viewModel: game)
                .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
        
    }
}

struct CardView: View {
    let card: EmojiMemoryGameVM.Card
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
            
//                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
//                    .padding(8).opacity(0.5)
                Text(card.content)
                    .font(calculateFontSize(with: geometry.size))
            
                
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale = 0.6
    }
    
    private func calculateFontSize(with size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
}


/*
//DEPRECATED CODE FOR NOTES: IGNORE
 
//deprecated view
struct ButtonView: View{
    //dependencies
    @State var emojiCount = 8
    var emojis = ["🚗", "🚀", "🛩", "🛫", "🚈", "🛺", "🚡", "🚖"]
    //
    
    var add: some View{
        Button{
            if(emojiCount < emojis.count){
                emojiCount += 1
            }
        }label:{
            Image(systemName: "plus.circle")
        }
    }
    
    var remove: some View{
        Button{
            if(emojiCount > 1){
                emojiCount -= 1
            }
        }label:{
            Image(systemName: "minus.circle")
        }
    }
    
    var body: some View{
        HStack{
            remove
            Spacer()
            add

        }
        .padding()
        .font(.largeTitle)
    }
}


 ZStack {
     
     let shape = RoundedRectangle(cornerRadius: 20)
     
     if card.isFaceUp{
         shape.fill().foregroundColor(Color(UIColor.secondarySystemFill))
         shape.strokeBorder(lineWidth: 3)
         Text(card.content)
             .font(.largeTitle)
     }else if card.isMatched{
         shape.opacity(0)
     }else{
         shape.fill()
     }
     
 }
 
 ScrollView {
     LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
         ForEach(viewModel.cards) { card in
             CardView(card: card)
                 .aspectRatio(2/3, contentMode: .fit)
                 .onTapGesture {
                     //isFaceUp = !isFaceUp
                     viewModel.choose(card)
                 }
         }
     }
     .foregroundColor(.red)
 }
 Spacer()

 */



