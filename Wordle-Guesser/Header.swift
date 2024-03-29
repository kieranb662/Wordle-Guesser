// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/30/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            
            HStack {
                ShowWordListButton()
                Spacer()
                ResetButton()
            }
            .padding([.horizontal, .top])
            
            if let nextBestGuess = game.recommendedNextGuess,
               !game.isFinished {
                RecommendedGuessDisplay(word: nextBestGuess)
                    .padding(.horizontal)
            }
            
            Spacer()
                .frame(height: 12)
        }
        .background(.ultraThickMaterial)
    }
    
    @EnvironmentObject private var game: Game
}

