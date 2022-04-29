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
        VStack(alignment: .leading, spacing: 4) {
            Text("Recommended Next Guess")
                .font(.callout)
                .foregroundColor(.black)
            
            HStack {
                ForEach(0..<5) { letterIndex in
                    Text(String(word[letterIndex]))
                        .letterBoxStyle(color: .purple)
                        .cornerRadius(3)
                }
            }
        }
        .padding(8)
        .background(Color(white: 0.9))
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
