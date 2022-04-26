// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI


struct CurrentGuessRow: View {
    var body: some View {
        
        HStack {
            ForEach(0..<5) { letterIndex in
                if letterIndex < game.guessCurrentlyEditing.count {
                    Text(game.guessCurrentlyEditing[letterIndex].character)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(game.guessCurrentlyEditing[letterIndex].result.color)
                    
                } else if letterIndex == game.guessCurrentlyEditing.count,
                          let selectedLetter = game.letterSelected {
                    
                    Text(selectedLetter)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(white: 0.4))
                } else  {
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
                Text(game.guesses[index][letterIndex].character)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(game.guesses[index][letterIndex].result.color)
            }
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct GuessView: View {
    var body: some View {
        VStack {
            
            ForEach(0..<5) { index in
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
