// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct KeyboardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let width = (UIScreen.main.bounds.width - 9 * keyboardButtonSpacing - 2 * keyboardHorizontalPadding) / 10
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


struct KeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
       KeyboardButton(character: "a")
            .environmentObject(Game())
    
    }
}
