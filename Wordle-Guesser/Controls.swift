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
        Button(character, action: {
            withAnimation(.spring().speed(1.5)) {
                game.select(letter: character)
            }
        })
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

struct ResultButton: View {
    var result: GuessResult
    
    var body: some View {
        Button(action: {
            withAnimation(.spring().speed(1.5)) {
                game.addResult(result: result)
            }
        }) {
            Text(result.rawValue).frame(maxWidth: .infinity)
        }
        .textCase(.uppercase)
        .tint(result.color)
        .buttonStyle(.borderedProminent)
    }
    
    @EnvironmentObject private var game: Game
}

struct ResultButtons: View {
    var body: some View {
        VStack {
            ResultButton(result: .rightPosition)
            ResultButton(result: .wrongPosition)
            ResultButton(result: .notInWord)
            Button("Reselect Letter", action: { game.letterSelected = nil })
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct Inputs: View {
    var body: some View {
        if game.guessCurrentlyEditing.count == 5 {
  
            Button(action: {
                withAnimation(.spring().speed(1.5)) {
                    game.submitGuess()
                }
            }) {
                Text("Submit Guess")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
        } else {
            if game.letterSelected == nil {
                Keyboard()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(game.letterSelected == nil ? 1 : 0)
            } else {

                ResultButtons()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(game.letterSelected != nil ? 1 : 0)
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
