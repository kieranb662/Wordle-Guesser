// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct RecommendedGuessDisplay: View {
    var word: String
    var body: some View {
        HStack {
            Text("Recommended Next Guess:")
                .font(.label)
            
            Spacer()
            
            Text(word)
                .foregroundColor(.bestGuessForeground)
                .font(.bestGuess)
                .padding(4)
                .background(Color.bestGuessBackground, in: .bestGuessShape)
        }
        .padding()
        .transition(.moveLeftAndFade)
    }
    
    @EnvironmentObject private var game: Game
}

struct NextBestGuessDisplay_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedGuessDisplay(word: "deist")
            .prepareForPreview()
    }
}
