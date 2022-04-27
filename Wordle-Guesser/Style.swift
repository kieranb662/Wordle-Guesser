// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

extension Color {
    static let correctLetterBackground = Color("correct-letter-background")
    static let emptyGuessRowStroke = Color("empty-guessrow-stroke")
    static let incorrectLetterBackground = Color("incorrect-letter-background")
    static let selectedBoxBackground = Color("selected-box-background")
    static let unfilledGuessBackground = Color("unfilled-guess-background")
    static let wrongPositionBackground = Color("wrong-position-background")
    static let bestGuessForeground = Color("best-guess-foreground")
    static let bestGuessBackground = Color("best-guess-background")
    static let destructiveAction = Color("destructive-action")
    static let keyboardForeground = Color("keyboard-foreground")
    static let keyboardBackground = Color("keyboard-background")
    static let letterBoxForeground = Color("letter-box-foreground")
    static let resultButtonForeground = Color("result-button-foreground")
    static let text = Color("text")
}

extension Shape where Self == RoundedRectangle {
    static var keyboardButtonShape: Self {
        RoundedRectangle(cornerRadius: 3)
    }
    
    static var bestGuessShape: Self {
        RoundedRectangle(cornerRadius: 3)
    }
}

let keyboardButtonSpacing = 5.0
let keyboardHorizontalPadding = 10.0
let maxLetterBoxSize = 200.0
let resultButtonHeight = 36.0
let submitButtonHeight = 36.0
let resultButtonSpacing = 16.0

extension Image {
    static let backspace = Image(systemName: "delete.left")
}

extension Animation {
    static let hideAndShow = Animation.spring().speed(1.5)
    static let keyboardButtonExpansion = Animation.linear(duration: 0.1)
}

extension AnyTransition {
    static let moveLeftAndFade = AnyTransition.move(edge: .leading).combined(with: .opacity)
    static let moveDownAndFade = AnyTransition.move(edge: .bottom).combined(with: .opacity)
}


extension Font {
    static let letterBox = Font.title
    static let bestGuess = Font.headline
    static let keyboard = Font.headline
    static let resultButton = Font.body
    static let label = Font.title2
    static let textButton = Font.body
}

struct Style_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
    }
}
