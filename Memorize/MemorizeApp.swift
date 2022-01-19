//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Samuel Alake on 1/17/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject private var game = EmojiMemoryGameVM()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
