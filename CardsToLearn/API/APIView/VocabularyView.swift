//
//  VocabularyView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 26.05.23.
//

import SwiftUI

struct VocabularyView: View {
    @EnvironmentObject var wordVM: ApiWordViewModel
    @State private var searchWord: String = ""
    
    var body: some View {
        ZStack { // Ein Container, um die Ansicht zu rendern
            
            VStack(spacing: 16) {
                Text("Word Dictionary")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                HStack {
                    TextField("Enter a word", text: $searchWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Search") {
                        wordVM.fetchWord(word: searchWord)
                        wordVM.lastWord = searchWord
                    }
                    .disabled(searchWord.isEmpty)
                    .foregroundColor(.white)
                }
                
                if let word = wordVM.words?.word {
                    Text("Vocabulary: \(word)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } else {
                    Text("Word not available")
                        .font(.title)
                        .foregroundColor(.red)
                }
                
                ScrollView {
                    if let definition = wordVM.words?.definition {
                        Text("Definiton:\(definition)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    } else {
                        Text("Definition not available")
                            .font(.body)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding()
            .onAppear {
                wordVM.fetchWord(word: wordVM.lastWord)
            }
        }
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView()
    }
}
