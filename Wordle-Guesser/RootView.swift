// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        VStack {
            
            Header()
                .overlay(Color(white: 0.3).frame(height: 0.5), alignment: .bottom)
            
            GuessView()
                .frame(maxHeight: 800)
                .padding([.horizontal, .top])
            
            Spacer()
            
            BottomControls()
                .frame(maxWidth: .infinity)
                .frame(height: 4 * resultButtonHeight + 3 * resultButtonSpacing + 96)
                .background(.ultraThickMaterial)
                .overlay(Color(white: 0.3).frame(height: 0.5), alignment: .top)
        }
        .textCase(.uppercase)
        .environmentObject(game)
    }
    
    @EnvironmentObject private var game: Game
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        RootView()
//            .environmentObject(Game.firstGuessFilledButNotSubmitted)
        
        Canvas(models: [Game(), .noGuessesOneLetterSelected], deviceSize: .iPhone12Pro)
        Canvas(models: [.firstGuessFilledButNotSubmitted, .oneGuess], deviceSize: .iPhone12Pro)
    }
}
