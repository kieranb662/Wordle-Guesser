// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct SubmitGuessButton: View {
    var body: some View {
        Button(action: {
            withAnimation(.hideAndShow) {
                game.submitGuess()
            }
            SuccessHaptic()
        }) {
            Text("Submit Guess")
                .font(.resultButton)
                .frame(maxWidth: .infinity)
                .frame(height: submitButtonHeight)
        }
        .tint(.selectedBoxBackground)
        .buttonStyle(.borderedProminent)
    }
    
    @EnvironmentObject private var game: Game
}

struct SubmitGuessButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitGuessButton()
            .prepareForPreview()
    }
}
