// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import Foundation
import SwiftUI
import Primitives

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
    
    func reset() {
        guessCurrentlyEditing = []
        guesses = []
        letterSelected = nil
        RigidImpactHaptic()
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
        
        let numberOfKnownLetters = Set(
            correctSpots.map(\.character) + lettersContained.map(\.character)
        ).count
        
        let numberOfUnknownLetters = 5 - numberOfKnownLetters
        
        guard !possibleWords().isEmpty && numberOfUnknownLetters > 0 else {
            return nil
        }
        
        return bestNextGuess(
            possibilities: possibleWords(),
            unguessedLetters: unguessedLetters,
            numberOfUnknownLetters: numberOfUnknownLetters)
    }
    
    // For each letter know the number of possible words that contain that letter
    func bestNextGuess(possibilities: [String], unguessedLetters: String, numberOfUnknownLetters: Int) -> String {
        var wordsContainingLetter = [String: [String]]()
        
        for letter in unguessedLetters {
            for word in possibilities where word.contains(letter) {
                if wordsContainingLetter[String(letter)] == nil {
                    wordsContainingLetter[String(letter)] = [word]
                } else {
                    wordsContainingLetter[String(letter)]? += [word]
                }
             
            }
        }
        
        let sortedByMostCommonLetters = wordsContainingLetter
            .map { (letter: $0, words: $1) }
            .sorted { previous, next in previous.words.count > next.words.count}
        
        let mostCommonLetters = Array(sortedByMostCommonLetters[0..<numberOfUnknownLetters])
        
        var bestChoice = ""
        var currentBestScore = 0
        
        for word in possibilities {
            var amountOfIntersectingPossibilities = 0
            
            for (letter, words) in mostCommonLetters where word.contains(letter) {
                amountOfIntersectingPossibilities += words.count
            }
            
            if amountOfIntersectingPossibilities > currentBestScore {
                currentBestScore = amountOfIntersectingPossibilities
                bestChoice = word
            }
        }
        
        return bestChoice
    }

}

