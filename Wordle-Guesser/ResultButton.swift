// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/27/22.
//
// Author: Kieran Brown
//

import SwiftUI
import Primitives

struct ResultButton: View {
    var result: GuessResult
    
    var body: some View {
        Button(action: {
            withAnimation(.hideAndShow) {
                game.addResult(result: result)
            }
            
            SelectionHaptic()
        }) {
            Text(result.rawValue)
                .font(.resultButton)
                .foregroundColor(.resultButtonForeground)
                .frame(maxWidth: .infinity)
                .frame(height: resultButtonHeight)
        }
        .textCase(.uppercase)
        .tint(result.color)
        .buttonStyle(.borderedProminent)
    }
    
    @EnvironmentObject private var game: Game
}


struct ResultButtons: View {
    var body: some View {
        VStack(spacing: resultButtonSpacing) {
            ResultButton(result: .rightPosition)
            ResultButton(result: .wrongPosition)
            ResultButton(result: .notInWord)
            
            Button("Reselect Letter", action: {
                withAnimation(.hideAndShow) {
                    game.letterSelected = nil
                }
                ErrorHaptic()
            })
            .font(.resultButton)
        }
        .transition(.moveDownAndFade)
    }
    
    @EnvironmentObject private var game: Game
}

struct ResultButton_Previews: PreviewProvider {
    static var previews: some View {
        ResultButton(result: .notInWord)
            .environmentObject(Game())
    }
}
