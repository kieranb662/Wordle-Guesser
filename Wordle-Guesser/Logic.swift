// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    @Published var guesses = [Guess]()
    @Published var guessCurrentlyEditing: Guess = []
    @Published var letterSelected: String?
    
    func select(letter: String) {
        self.letterSelected = letter
    }
    
    func addResult(result: GuessResult) {
        if let letterSelected = letterSelected {
            guessCurrentlyEditing.append((letterSelected, result))
            self.letterSelected = nil
        }
    }
    
    func submitGuess() {
        guesses += [guessCurrentlyEditing]
        guessCurrentlyEditing = []
    }
    
    var lettersContained: [(position: Int, character: String)] {
        return guesses.flatMap { guess in
            return guess
                .enumerated()
                .filter { value in value.element.result == .wrongPosition }
                .map { offset, value in (offset, value.character) }
        }
    }
    
    var correctSpots: [(position: Int, character: String)] {
        guesses.flatMap { guess in
            guess
                .enumerated()
                .filter { value in value.element.result == .rightPosition }
                .map { offset, value in (offset, value.character) }
        }
    }
    
    var incorrectLetters: [String] {
        guesses.flatMap { guess in
            guess
                .filter({ $0.result == .notInWord })
                .map(\.character)
        }
    }
    
    func regex() -> String {
        var regex = ""
        let baseWrongCharacters = incorrectLetters.joined()
        
        for i in 0...4 {
            if let correctLetter = correctSpots.first(where: { $0.position == i }) {
                regex += correctLetter.character
            } else {
                let excludedFromSpotLetters = lettersContained
                    .filter { $0.position == i }
                    .map(\.character)
                    .joined()
                
                regex += "[^\(baseWrongCharacters)\(excludedFromSpotLetters)\n]"
            }
        }
        
        return regex
    }
    
    func possibleWords() -> [String] {
        let regex = try! NSRegularExpression(pattern: regex())
        let wordList = load(file: "5-letter-words")!
        let results = regex.capture(in: wordList)
        let contained = lettersContained.map(\.character)
        return results
            .filter({ contained.allSatisfy($0.value.contains) })
            .map(\.value)
    }
    
    
    func nextBestGuess() -> String? {
        guard !guesses.isEmpty else {
            return nil
        }
        
        let unguessedLetters = "qwertyuiopasdfghjklzxcvbnm".filter { letter in
            
            return !guesses.flatMap { guess in
                guess
            }.contains { guessedLetter, _ in
                guessedLetter == String(letter)
            }
        }
        
        let numberOfKnownLetters = Set(correctSpots.map(\.character) +
        lettersContained.map(\.character))
        .count
        
        return bestNextGuess(
            possibilities: possibleWords(),
            unguessedLetters: unguessedLetters,
            numberOfUnknownLetters: 5 - numberOfKnownLetters)
    }
}
