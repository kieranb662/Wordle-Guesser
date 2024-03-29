// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct KeyboardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let baseWidth = min(UIScreen.main.bounds.width, 500)
        let width = (baseWidth - 9 * keyboardButtonSpacing - 2 * keyboardHorizontalPadding) / 10
        return configuration.label
            .font(.keyboard)
            .foregroundColor(.keyboardForeground)
            .frame(width: width, height: width * 1.5)
            .background(Color.keyboardBackground, in: .keyboardButtonShape)
            .scaleEffect(configuration.isPressed ? 2 : 1)
            .offset(y: configuration.isPressed ? -(width * 1.5) : 0)
            .animation(.keyboardButtonExpansion, value: configuration.isPressed)
    }
}

struct KeyboardButton: View {
    var character: String
    
    var body: some View {
        Button(character, action: {
            withAnimation(.hideAndShow) {
                game.select(letter: character)
            }
            
            LightImpactHaptic()
        })
        .buttonStyle(KeyboardButtonStyle())
    }
    
    @EnvironmentObject private var game: Game
}


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

    var body: some View {
        VStack(spacing: keyboardButtonSpacing) {
            
            KeyboardRow(characters: "qwertyuiop")
            KeyboardRow(characters: "asdfghjkl")
            
            HStack(spacing: keyboardButtonSpacing) {
                KeyboardRow(characters: "zxcvbnm")
                
                Button(action: {
                    withAnimation(.hideAndShow) {
                        if game.letterSelected == nil && game.guessCurrentlyEditing.isEmpty &&
                            game.guesses.count > 0 {
                            
                            game.guessCurrentlyEditing = game.guesses.removeLast()
                            _ = game.guessCurrentlyEditing.removeLast()
                            game.recommendedNextGuess = game.recommendedGuess()
                            
                        } else if !game.guessCurrentlyEditing.isEmpty {
                            _ = game.guessCurrentlyEditing.removeLast()
                        }
                    }
                
                    LightImpactHaptic()
                }) {
                    Image.backspace
                }
                .buttonStyle(KeyboardButtonStyle())
            }
        }
        .transition(.moveDownAndFade)
    }
    
    @EnvironmentObject private var game: Game
}


struct KeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
       KeyboardButton(character: "a")
            .prepareForPreview()
        
        Keyboard()
            .prepareForPreview()
    
    }
}
