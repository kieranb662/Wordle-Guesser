// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct ContentView: View {
    @StateObject var game = Game()
    @State var isPresentingPossibleSolutions = false
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                ResetButton()
            }
            .padding()
            
            GuessView()
                .padding(.horizontal)
            
            if let nextBestGuess = game.nextBestGuess() {
                NextBestGuessDisplay(word: nextBestGuess)
            }
            
            if game.guesses.count > 0 {
                ShowSolutionsButton()
            }
            
            Spacer()
            
            Inputs()
        }
        .padding()
        .environmentObject(game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
