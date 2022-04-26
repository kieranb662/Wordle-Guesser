// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct KeyboardButton: View {
    
    var character: String
    
    var body: some View {
        Button(character, action: { game.select(letter: character) })
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 24, height: 36)
            .padding(4)
            .background(Color(white: 0.2), in: RoundedRectangle(cornerRadius: 3))
        
    }
    
    @EnvironmentObject private var game: Game
}

struct KeyboardRow: View {
    var characters: String
    var body: some View {
        HStack(spacing: 4) {
            ForEach(characters.filter({_ in true}), id: \.self) { char in
                KeyboardButton(character: String(char))
            }
        }
    }
}

struct Keyboard: View {
    let topRow = "qwertyuiop"
    let middleRow = "asdfghjkl"
    let bottomRow = "zxcvbnm"
    
    var body: some View {
        VStack {
            KeyboardRow(characters: topRow)
            KeyboardRow(characters: middleRow)
            KeyboardRow(characters: bottomRow)
        }
        .overlay(alignment: .bottomTrailing) {
            Button(action: { _ = game.guessCurrentlyEditing.removeLast() }) {
                Image(systemName: "delete.left")
            }
            .disabled(game.guessCurrentlyEditing.isEmpty)
            .padding([.bottom, .trailing])
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct ResultButtons: View {
    var body: some View {
        VStack {
            Button("Correct Position", action: { game.addResult(result: .rightPosition) })
            Button("Wrong Position", action: { game.addResult(result: .wrongPosition) })
            Button("Not In Word", action: { game.addResult(result: .notInWord) })
            Button("Reselect Letter", action: { game.letterSelected = nil })
        }
        .buttonStyle(.borderedProminent)
    }
    
    @EnvironmentObject private var game: Game
}

struct Inputs: View {
    var body: some View {
        if game.guessCurrentlyEditing.count == 5 {
            Button("Submit Guess", action: game.submitGuess)
        } else {
            if game.letterSelected == nil {
                Keyboard()
            } else {
                ResultButtons()
            }
        }
        
    }
    
    @EnvironmentObject private var game: Game
}

struct Controls_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Keyboard()
            ResultButtons()
        }
        .padding()
        .environmentObject(Game())
        .previewLayout(.sizeThatFits)
    }
}
