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

//struct VocabularyView_Previews: PreviewProvider {
//    static var previews: some View {
//        VocabularyView()
//    }
//}


//struct ApiVocabularyView: View {
//    
//    @EnvironmentObject var wordVM: ApiWordViewModel
//    @State private var searchWord: String = ""
//    
//    @State var show: Bool = false
//    @State var text: String = ""
//    
//    var body: some View{
//        
//        VStack(spacing: 0){
//            
//            HStack{
//                
//                if !self.show{
//                    
//                    Text("Dictionary")
//                        .fontWeight(.bold)
//                        .font(.title)
//                        .foregroundColor(.white)
//                }
//                
//                
//                
//                Spacer(minLength: 0)
//                
//                HStack{
//                    if self.show {
//                        
//                        Image(systemName: "magnifyingglass.circle")
//                            .padding(.horizontal, 8)
//                        
//                        TextField("Seach a Word",text: self.$searchWord)
//                            //.textFieldStyle(RoundedBorderTextFieldStyle())
//                        Button{
//                            withAnimation{
//                                self.show.toggle()
//                            }
//                           
//                        }label: {
//                            Image(systemName: "xmark")
//                                .foregroundColor(.black)
//                        }
//                        .padding(.horizontal, 8)
//                    }
//                    else {
//                        Button{
//                            
//                            withAnimation{
//                                self.show.toggle()
//                            }
//                            
//                        }label: {
//                            Image(systemName: "magnifyingglass.circle")
//                                .foregroundColor(.black)
//                                .padding(10)
//                                
//                        }
//                    }
//                }
//                
//                
//                .padding(self.show ? 10 : 0)
//                .background(Color.white)
//                .cornerRadius(20)
//            }
//            .padding(.top, (UIApplication.shared.connectedScenes
//            .first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0 + 15)
//            .padding(.horizontal)
//            .padding(.bottom,10)
//            .background(Color.gray)
//            
//            Spacer()
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}
//
//
//class Host: UIHostingController<ContentView> {
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        
//        return .lightContent
//    }
//    
//}
//
//
//struct ApiVocabularyView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApiVocabularyView()
//    }
//}
