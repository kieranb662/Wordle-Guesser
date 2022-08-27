// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct ResetButton: View {
    var body: some View {
        Button("Reset") {
            withAnimation(.hideAndShow) {
                game.reset()
            }
        }
            .font(.textButton)
            .tint(.destructiveAction)
            .disabled(game.guesses.count == 0)
    }
    
    @EnvironmentObject private var game: Game
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton()
            .prepareForPreview()
        
        ResetButton()
            .prepareForPreview(.oneGuess)
    }
}
