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
        game.recommendedNextGuess = game.recommendedGuess()
        return game
    }()
    
    static let firstGuessFilledButNotSubmitted: Game = {
        let game = Game()
        game.guessCurrentlyEditing = .firstGuess
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

extension Game: Identifiable {}

struct Canvas: View {
    var models: [Game]
    var deviceSize: CGSize
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(models) { game in
                RootView()
                    .background(.background)
                    .frame(width: deviceSize.width, height: deviceSize.height)
                    .environmentObject(game)
            }
        }
        .background(Color(white: 101/255))
        .previewLayout(.sizeThatFits)
    }
}

extension CGSize {
    static let iPhoneSE = CGSize(width: 320, height: 568)
    static let iPhone12Pro = CGSize(width: 390, height: 844)
    static let iPadPro12_9 = CGSize(width: 1024, height: 1366)
}
