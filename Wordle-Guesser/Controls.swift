// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct KeyboardRow: View {
    var characters: String
    var body: some View {
        HStack(spacing: keyboardButtonSpacing) {
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
        VStack(spacing: keyboardButtonSpacing) {
            
            KeyboardRow(characters: topRow)
            KeyboardRow(characters: middleRow)
            
            HStack(spacing: keyboardButtonSpacing) {
                KeyboardRow(characters: bottomRow)
                
                Button(action: {
                    withAnimation(.hideAndShow) {
                        _ = game.guessCurrentlyEditing.removeLast()
                    }
                
                    LightImpactHaptic()
                }) {
                    Image.backspace
                }
                .disabled(game.guessCurrentlyEditing.isEmpty)
                .buttonStyle(KeyboardButtonStyle())
            }
        }
        .transition(.moveDownAndFade)
    }
    
    @EnvironmentObject private var game: Game
}

struct Inputs: View {
    var body: some View {
        if game.guessCurrentlyEditing.count == 5 {
            SubmitGuessButton()
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
