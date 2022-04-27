// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct KeyboardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let width = (UIScreen.main.bounds.width - 9 * 5 - 40) / 10
        return configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: width, height: width * 1.5)
            .background(Color(white: 0.2), in: RoundedRectangle(cornerRadius: 3))
            .scaleEffect(configuration.isPressed ? 2 : 1)
            .offset(y: configuration.isPressed ? -(width * 1.5) : 0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}

struct KeyboardButton: View {
    
    var character: String
    
    var body: some View {
        Button(character, action: {
            withAnimation(.spring().speed(1.5)) {
                game.select(letter: character)
            }
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
