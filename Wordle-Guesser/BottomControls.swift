// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/30/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct BottomControls: View {
    var body: some View {
        if game.guessCurrentlyEditing.count == 5 {
            VStack {
                
                if !game.isFinished {
                    SubmitGuessButton()
                        .padding()
                }
        
                Button("Reselect last letter") {
                    withAnimation(.hideAndShow) {
                        _ = game.guessCurrentlyEditing.removeLast()
                    }
                    MediumImpactHaptic()
                }
            }
            .frame(maxWidth: 413)
            .padding(.bottom)
            .transition(.moveDownAndFade)
           
        } else if game.letterSelected == nil {
            Keyboard()
                .padding(.vertical)
        } else {
            ResultButtons()
                .frame(maxWidth: 413)
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
