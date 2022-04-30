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
            
            Header()
                .overlay(Color(white: 0.3).frame(height: 0.5), alignment: .bottom)
            
            GuessView()
                .padding([.horizontal, .top])
            
            Spacer()
            
            BottomControls()
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
        RootView()
            .environmentObject(Game.oneGuess)
            .preferredColorScheme(.dark)
    }
}
