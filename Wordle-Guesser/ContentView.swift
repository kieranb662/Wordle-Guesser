// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    @State var isPresentingPossibleSolutions = false
  
    var body: some View {
        VStack {
           GuessView()
            
            if game.guesses.count > 0 {
                Button("Show \(game.possibleWords().count) Possible Solutions",
                       action: { isPresentingPossibleSolutions = true })
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
        ContentView()
    }
}
