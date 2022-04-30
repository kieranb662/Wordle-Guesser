// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct ShowWordListButton: View {
    @State var isPresentingPossibleSolutions = false
    
    var body: some View {
        let numberOfWords = game.possibleWords().count
        let text: String = {
            switch numberOfWords {
            case ...0:  return "No possible words (retry)"
            case 2... : return "\(numberOfWords) possible words"
            default:    return ""
            }
        }()
        
        Button(action:  {
            if numberOfWords > 0 {
                isPresentingPossibleSolutions = true
                SelectionHaptic()
            } else {
                game.reset()
            }
        }) {
            Label(text, systemImage: "list.dash")
        }
        .font(.textButton)
        .transition(.moveLeftAndFade)
        .sheet(isPresented: $isPresentingPossibleSolutions) {
            PossibleWordList(words: game.possibleWords())
        }
        .disabled(numberOfWords < 1)
    }
    
    
    @EnvironmentObject private var game: Game
}

struct ShowSolutionsButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowWordListButton()
            .prepareForPreview(.oneGuess)
    }
}
