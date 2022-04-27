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
                HStack {
                    Text("Best Next Guess:")
                        .font(.label)
                    
                    Spacer()
                    
                    Text(nextBestGuess)
                        .foregroundColor(.bestGuessForeground)
                        .font(.bestGuess)
                        .padding(4)
                        .background(Color.bestGuessBackground, in: .bestGuessShape)
                }
                .padding()
                .transition(.moveLeftAndFade)
            }
            
            if game.guesses.count > 0 {
                Button("Show \(game.possibleWords().count) Possible Solutions") {
                    isPresentingPossibleSolutions = true
                    SelectionHaptic()
                }
                .font(.textButton)
                .transition(.moveLeftAndFade)
            }
            
            Spacer()
            
            Inputs()
            
        }
        .sheet(isPresented: $isPresentingPossibleSolutions, content: {
            List {
                ForEach(game.possibleWords().sorted(), id: \.self) { word in
                    Text(word)
                }
            }
        })
        .padding()
        .environmentObject(game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
