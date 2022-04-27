// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import Foundation
import SwiftUI

extension String {
    
    /// The full range of the string as an NSRange.
    var nsRange: NSRange { return NSRange(startIndex..<endIndex, in: self) }
    
    /// Returns the substring of the given range.
    ///
    /// - parameter nsRange: The `NSRange` to retrieve substring with.
    /// - returns: The substring if the range is valid. `nil` otherwise.
    func substring(at nsRange: NSRange) -> String? {
        guard let range = Range(nsRange, in: self) else { return nil }
        
        return String(self[range])
    }
}

struct CaptureResult {
    /// The captured string
    let value: String
    /// The range of the captured string in the original content
    let range: NSRange
    /// The index of the capture group in the NSTextCheckingResult
    let captureId: Int
    /// If the capture result represents the entire expression match.
    var isFullMatch: Bool { return captureId == 0 }
}

extension NSRegularExpression {
    /// Retrieves the flattened capture results of all matches and capture groups
    ///
    /// - Parameters:
    ///   - content: The string to be searched
    /// - Returns: The first found capture group result
    func capture(in content: String) -> [CaptureResult] {
        self.matches(in: content, options: [], range: content.nsRange)
            .flatMap({ match -> [CaptureResult] in
                (0..<match.numberOfRanges).compactMap({ index in
                    let range = match.range(at: index)
                    guard let value = content.substring(at: range) else { return nil }
                    
                    return CaptureResult(value: value, range: range, captureId: index)
                })
            })
    }
}

func load(file named: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: named, withExtension: "txt") else {
        return nil
    }
    
    guard let content = try? String(contentsOf: fileUrl, encoding: .utf8) else {
        return nil
    }
    
    return content
}

enum GuessResult: String {
    case notInWord = "Not In Word"
    case wrongPosition = "Wrong Position"
    case rightPosition = "Correct Position"
    
    var color: Color {
        switch self {
        case .notInWord: return Color(white: 0.4)
        case .wrongPosition: return .yellow
        case .rightPosition: return .green
        }
    }
}

typealias Guess = [(character: String, result: GuessResult)]

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
}
