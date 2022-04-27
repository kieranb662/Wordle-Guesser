// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct ShowSolutionsButton: View {
    @State var isPresentingPossibleSolutions = false
    
    var body: some View {
        let numberOfWords = game.possibleWords().count
        let text = numberOfWords > 0
        ? "Show \(numberOfWords) Possible Solutions"
        : "No possible words (retry)"
        
        Button(text) {
            if numberOfWords > 0 {
                isPresentingPossibleSolutions = true
                SelectionHaptic()
            } else {
                game.reset()
            }
        }
        .font(.textButton)
        .transition(.moveLeftAndFade)
        .sheet(isPresented: $isPresentingPossibleSolutions, content: {
            List {
                ForEach(game.possibleWords().sorted(), id: \.self) { word in
                    Text(word)
                }
            }
        })
    }
    
    
    @EnvironmentObject private var game: Game
}

struct ShowSolutionsButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowSolutionsButton()
            .prepareForPreview(.oneGuess)
    }
}
