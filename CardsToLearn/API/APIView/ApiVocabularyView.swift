//
//  ApiVocabularyView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI

struct ApiVocabularyView: View {
    
    @EnvironmentObject var wordVM: ApiWordViewModel
    @State private var searchWord: String = ""
    
    @State var show: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                if !self.show {
                    Text("Dictionary")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
                
                HStack {
                    if self.show {
                        
                        Image(systemName: "magnifyingglass.circle")
                            .padding(.horizontal, 8)
                        
                        TextField("Search a Word", text: self.$searchWord)
                        Button {
                            wordVM.fetchWord(word: searchWord)
                            wordVM.lastWord = searchWord
                            withAnimation {
                                self.show.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 8)
                    } else {
                        Button {
                            withAnimation {
                                self.show.toggle()
                            }
                        } label: {
                            Image(systemName: "magnifyingglass.circle")
                                .foregroundColor(.black)
                                .padding(10)
                        }
                    }
                }
                .padding(self.show ? 10 : 0)
                .background(Color.white)
                .cornerRadius(20)
            }
            .padding(.top, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0 + 15)
            .padding(.horizontal)
            .padding(.bottom, 10)
            .background(Color.gray)
            
            if let word = wordVM.words?.word {
                Image("grayPic")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            Text("Vocabulary: \(word)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            ScrollView {
                            if let definition = wordVM.words?.definition {
                                Text("Definition: \(definition)")
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
                        .padding(),
                        alignment: .center
                    )
            } else {
                Text("Word not available")
                    .font(.title)
                    .foregroundColor(.red)
            }

            
        }
        .padding()
        .onAppear {
            wordVM.fetchWord(word: wordVM.lastWord)
        }
    }
}


class Host: UIHostingController<ContentView> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
}


struct ApiVocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        ApiVocabularyView()
    }
}
