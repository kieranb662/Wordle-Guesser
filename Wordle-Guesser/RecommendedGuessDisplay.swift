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
            Text("Recommended Next Guess")
                .textCase(.none)
                .font(.callout.weight(.semibold))
                
            
            HStack(spacing: 3) {
                ForEach(0..<5) { letterIndex in
                    Text(String(word[letterIndex]))
                        .font(.title2)
                        .letterBoxStyle(color: Color(white: 0.2))
                        .cornerRadius(3)
                }
            }
        }
        .frame(maxWidth: .infinity)
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
