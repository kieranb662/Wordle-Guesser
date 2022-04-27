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
                
                Button("Reset", action: {
                    game.guessCurrentlyEditing = []
                    game.guesses = []
                    game.letterSelected = nil
                    RigidImpactHaptic()
                })
                .tint(.red)
                .disabled(game.guesses.count == 0)
            }
            .padding()
            
            GuessView()
                .padding(.horizontal)
            
            if let nextBestGuess = game.nextBestGuess() {
                HStack {
                    Text("Best Next Guess:")
                    Spacer()
                    Text(nextBestGuess)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(4)
                        .background(Color.pink, in: RoundedRectangle(cornerRadius: 3))
                }
                .font(.title)
                .padding()
            }
            
            if game.guesses.count > 0 {
                Button("Show \(game.possibleWords().count) Possible Solutions") {
                    isPresentingPossibleSolutions = true
                    SelectionHaptic()
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
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
