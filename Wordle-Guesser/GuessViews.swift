// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct CharacterBox: View {
    var value: (character: String, result: GuessResult)
    
    var body: some View {
        Text(value.character)
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(value.result.color)
    }
}

struct CurrentGuessRow: View {
    var body: some View {
        
        HStack {
            ForEach(0..<5) { letterIndex in
                if letterIndex < game.guessCurrentlyEditing.count {
                    CharacterBox(value: game.guessCurrentlyEditing[letterIndex])
                    
                } else if letterIndex == game.guessCurrentlyEditing.count {
                    
                    if let selectedLetter = game.letterSelected {
                        Text(selectedLetter)
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                        
                    } else {
                        Color.blue
                            .frame(width: 50, height: 50)
                    }
                  
                } else {
                    Color(white: 0.6)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct AlreadyGuessedRow: View {
    var index: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5) { letterIndex in
                if index < game.guesses.count &&
                    letterIndex < game.guesses[index].count {
                    CharacterBox(value: game.guesses[index][letterIndex])
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct GuessRow: View {
    var index: Int
    
    var body: some View {
        if index < game.guesses.count {
            AlreadyGuessedRow(index: index)
        } else if index == game.guesses.count {
            CurrentGuessRow()
        } else {
            HStack {
                ForEach(0..<5) { _ in
                    Rectangle()
                        .stroke(Color.gray)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct GuessView: View {
    var body: some View {
        VStack {
            ForEach(0..<5, content: GuessRow.init)
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct GuessViews_Previews: PreviewProvider {
    static var previews: some View {
        GuessView()
            .environmentObject(Game())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
