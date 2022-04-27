// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

extension Array where Element == (character: String, result: GuessResult) {
    static let firstGuess: Guess = [
        ("a", .notInWord),
        ("e", .rightPosition),
        ("r", .notInWord),
        ("o", .notInWord),
        ("s", .wrongPosition)
    ]
}

extension Game {
    static let noGuessesOneLetterSelected: Game = {
        let game = Game()
        game.select(letter: "a")
        return game
    }()
    
    static let oneGuess: Game = {
        let game = Game()
        game.guesses.append(.firstGuess)
        return game
    }()
}

extension View {
    func prepareForPreview(_ game: Game = .init()) -> some View {
        return environmentObject(game)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
