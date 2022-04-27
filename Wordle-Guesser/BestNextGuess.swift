// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import Foundation

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
