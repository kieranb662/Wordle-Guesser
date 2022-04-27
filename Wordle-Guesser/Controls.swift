// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

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
