// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct RootView: View {
    
    var body: some View {
        VStack {
            
            
            VStack {
                
                HStack {
                    ShowWordListButton()
                    Spacer()
                    ResetButton()
                }.padding(.horizontal)
                
                
                if let nextBestGuess = game.recommendedNextGuess {
                    RecommendedGuessDisplay(word: nextBestGuess)
                        .padding(.horizontal)
                }
                
                Spacer()
                    .frame(height: 12)
                
            }
            .background(.thickMaterial)
            
            
            GuessView()
                .padding([.horizontal, .top])
            
            Spacer()
            
            if game.guessCurrentlyEditing.count == 5 {
                SubmitGuessButton()
                    .padding()
                
                Button("Reselect last letter") {
                    withAnimation(.hideAndShow) {
                        _ = game.guessCurrentlyEditing.removeLast()
                    }
                    MediumImpactHaptic()
                }
                
                Spacer()
            } else {
                if game.letterSelected == nil {
                    Keyboard().padding()
                } else {
                    ResultButtons().padding()
                }
            }
        }
        .textCase(.uppercase)
        .environmentObject(game)
    }
    
    @EnvironmentObject var game: Game
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Game.firstGuessFilledButNotSubmitted)
//            .preferredColorScheme(.dark)
    }
}
