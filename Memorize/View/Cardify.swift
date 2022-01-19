//
//  Cardify.swift
//  Memorize
//
//  Created by Samuel Alake on 1/18/22.
//

import SwiftUI

struct Cardify: ViewModifier{
    var isFaceUp: Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if isFaceUp{
                shape.fill().foregroundColor(Color(UIColor.secondarySystemFill))
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            }else{
                shape.fill()
            }
            
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
    }
}

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
