// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/26/22.
//
// Author: Kieran Brown
//

import SwiftUI

@main
struct Wordle_GuesserApp: App {
    @StateObject var game = Game()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(game)
        }
    }
}
