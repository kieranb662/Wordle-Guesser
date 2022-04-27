// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct LetterBox: View {
    var value: (character: String, result: GuessResult)
    
    var body: some View {
        Text(value.character)
            .letterBoxStyle(color: value.result.color)
    }
}

struct CurrentGuessRow: View {
    var body: some View {
        
        HStack {
            ForEach(0..<5) { letterIndex in
                if letterIndex < game.guessCurrentlyEditing.count {
                    LetterBox(value: game.guessCurrentlyEditing[letterIndex])
                    
                } else if letterIndex == game.guessCurrentlyEditing.count {
                    Text(game.letterSelected ?? " ")
                        .letterBoxStyle(color: .selectedBoxBackground)

                } else {
                    Color.unfilledGuessBackground
                        .squareAspectRatio()
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

extension View {
    func squareAspectRatio() -> some View {
        return frame(maxWidth: maxLetterBoxSize, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            
    }
    
    func letterBoxStyle(color: Color) -> some View {
        return font(.letterBox)
            .foregroundColor(.letterBoxForeground)
            .squareAspectRatio()
            .background(color)
    }
}

struct AlreadyGuessedRow: View {
    var index: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5) { letterIndex in
                if index < game.guesses.count && letterIndex < game.guesses[index].count {
                    LetterBox(value: game.guesses[index][letterIndex])
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct EmptyGuessRow: View {
    var body: some View {
        HStack {
            ForEach(0..<5) { _ in
                Rectangle()
                    .stroke(Color.emptyGuessRowStroke)
                    .squareAspectRatio()
            }
        }
    }
}

struct GuessView: View {
    var body: some View {
        VStack {
            ForEach(0..<6) { index in
                if index < game.guesses.count {
                    AlreadyGuessedRow(index: index)
                } else if index == game.guesses.count {
                    CurrentGuessRow()
                } else {
                    EmptyGuessRow()
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct GuessViews_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGuessRow()
            .prepareForPreview()
        
        CurrentGuessRow()
            .prepareForPreview()
        
        CurrentGuessRow()
            .prepareForPreview(.noGuessesOneLetterSelected)
        
        AlreadyGuessedRow(index: 0)
            .prepareForPreview(.oneGuess)
        
        GuessView()
            .prepareForPreview(.oneGuess)
    }
}
