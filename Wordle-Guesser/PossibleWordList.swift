// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/30/22.
//
// Author: Kieran Brown
//

import SwiftUI

struct PossibleWordList: View {
    var words: [String]
    
    var body: some View {
        let groups = wordsGroupedByFirstLetter
        NavigationView {
            List {
                ForEach(groups.keys.sorted(), id: \.self) { startingLetter in
                    DisclosureGroup(startingLetter) {
                        LazyVGrid(columns: [.init(.adaptive(minimum: 65), alignment: .leading)]) {
                            ForEach(groups[startingLetter]!.sorted(), id: \.self) { word in
                                Text(word)
                            }
                        }
                    }
                }
            }
            .textCase(.uppercase)
            .navigationTitle("\(words.count) words")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }

    }
    
    var wordsGroupedByFirstLetter: [String: [String]] {
        var temp = [String: [String]]()
        
        for word in words where word.count == 5 {
            let wordsStartingWithSameLetter = temp[String(word.first!)]
            
            if wordsStartingWithSameLetter == nil {
                temp[String(word.first!)] = [word]
            } else {
                temp[String(word.first!)]? += [word]
            }
        }
        
        return temp
    }
    
    @Environment(\.dismiss) var dismiss
}

struct PossibleWordList_Previews: PreviewProvider {
    static var previews: some View {
        PossibleWordList(words: Game().possibleWords())
    }
}