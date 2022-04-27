// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct ShowSolutionsButton: View {
    @State var isPresentingPossibleSolutions = false
    
    var body: some View {
        Button("Show \(game.possibleWords().count) Possible Solutions") {
            isPresentingPossibleSolutions = true
            SelectionHaptic()
        }
        .font(.textButton)
        .transition(.moveLeftAndFade)
        .sheet(isPresented: $isPresentingPossibleSolutions, content: {
            List {
                ForEach(game.possibleWords().sorted(), id: \.self) { word in
                    Text(word)
                }
            }
        })
    }
    
    
    @EnvironmentObject private var game: Game
}

struct ShowSolutionsButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowSolutionsButton()
            .environmentObject(Game())
    }
}
