// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import Foundation
import SwiftUI

enum GuessResult: String {
    case notInWord = "Not In Word"
    case wrongPosition = "Wrong Position"
    case rightPosition = "Correct Position"
    
    var color: Color {
        switch self {
        case .notInWord: return .incorrectLetterBackground
        case .wrongPosition: return .wrongPositionBackground
        case .rightPosition: return .correctLetterBackground
        }
    }
}

typealias Guess = [(character: String, result: GuessResult)]
