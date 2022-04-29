// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct RootView: View {
    
    var body: some View {
        VStack {
            
            if let nextBestGuess = game.recommendedNextGuess {
                RecommendedGuessDisplay(word: nextBestGuess)
            }
            
            HStack {
                ShowWordListButton()
                Spacer()
                ResetButton()
            }
            .padding()
            
            GuessView()
                .padding(.horizontal)
            
            Spacer()
            
            if game.guessCurrentlyEditing.count == 5 {
                SubmitGuessButton()
                Spacer()
            } else {
                if game.letterSelected == nil {
                    Keyboard()
                } else {
                    ResultButtons().padding(.horizontal)
                }
            }
        }
//        .padding()
        .textCase(.uppercase)
        .environmentObject(game)
    }
    
    @EnvironmentObject var game: Game
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Game.oneGuess)
            .preferredColorScheme(.dark)
    }
}
