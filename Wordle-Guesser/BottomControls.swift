// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/30/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct BottomControls: View {
    var body: some View {
        if game.guessCurrentlyEditing.count == 5 {
            VStack {
                SubmitGuessButton()
                    .padding()
                
                Button("Reselect last letter") {
                    withAnimation(.hideAndShow) {
                        _ = game.guessCurrentlyEditing.removeLast()
                    }
                    MediumImpactHaptic()
                }
            }
            .padding(.bottom)
            .transition(.moveDownAndFade)
           
        } else if game.letterSelected == nil {
            Keyboard()
                .padding()
        } else {
            ResultButtons()
                .padding()
        }
    }
    
    @EnvironmentObject private var game: Game
}

struct BottomControls_Previews: PreviewProvider {
    static var previews: some View {
        BottomControls()
            .prepareForPreview(.noGuessesOneLetterSelected)
    }
}