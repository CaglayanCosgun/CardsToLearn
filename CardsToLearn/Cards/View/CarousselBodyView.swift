//
//  CarousselBodyView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.06.23.
//

import SwiftUI
import CoreData

struct CarousselBodyView: View {
    let card: Card
    @State private var showingQuestion = true
    @EnvironmentObject var viewModel: CardViewModel
    @State private var selectedCard : Card?
    
  
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            ZStack{
                Image("dark1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - 8,height: size.height / 1.2)
                    .cornerRadius(12)
                
                VStack{
                    if showingQuestion {
                        VStack(alignment: .leading, spacing: 10){
                            Text("Question:")
                                .font(.title2.bold())
                                .kerning(1.5)
                            
                            Text(card.question ?? "")
                                .kerning(1.2)
                                .foregroundColor(.white)
                        }
                        .foregroundStyle(.white)
                        .padding(.top)
                    }
                    else {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Answer:")
                                .font(.title2.bold())
                                .kerning(1.5)
                            
                            Text(card.answer ?? "")
                                .kerning(1.2)
                                .foregroundColor(.white)
                        }
                        .foregroundStyle(.white)
                        .padding(.top)
                    }
                    
                    Spacer(minLength: 20)
                    
                    VStack(alignment: .leading, spacing: 30){
                        
                        HStack(spacing: 15){
                            
                            Image("splashlogo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55,height: 55)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading,spacing: 6){
                                
                                Text("CardsToLearn")
                                    .font(.title2.bold())
                                
                                Text("Flashards")
                                    .foregroundStyle(.gray)
                            }
                            .foregroundStyle(.black)
                        }
                        
                        HStack{
                            
                           
                            
                            VStack{
                                
                                Text(card.category ?? "")
                                    .font(.title2.bold())
                                    
                                
                                Text("Category")
                                    .foregroundStyle(.secondary)
                            
                            }
                            .frame(maxWidth: .infinity)
                            
                           
                            
                            
                        }
                        .foregroundStyle(.black)
                    }
                    .padding(20)
                    .padding(.horizontal,10)
                    .background(.white,in: RoundedRectangle(cornerRadius: 4))
                    
                    HStack { // Ein horizontal ausgerichteter Container
                        Spacer()
        
                        
                        Button(showingQuestion ? "Show Answer" : "Show Question") { // Ein Button, um zwischen Frage und Antwort zu wechseln
                            showingQuestion.toggle() // Ändert den internen Zustand, um die Frage oder Antwort anzuzeigen
                        }
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        Spacer()
                    }
                }
                .padding(20)
                .padding() // Ein Innenabstand für den Container
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Stellt sicher, dass der Container den gesamten verfügbaren Platz einnimmt
                .toolbar { // Eine Toolbar zur Anzeige der Kategorie
                    ToolbarItem(placement: .principal) { // Definiert ein neues Toolbar-Element und platziert es zentral
                        VStack(alignment: .center, spacing: 0) { // Definiert ein vertikales Stack-Element mit zentrierter Ausrichtung und keinem Abstand zwischen den Elementen
                            Text(card.category ?? "") // Fügt einen Text hinzu, der die Kategorie der Karte darstellt; der Null-Coalescing-Operator stellt sicher, dass der Text angezeigt wird, wenn card.category nicht nil ist
                                .font(.title) // Definiert die Schriftgröße des Textes
                                .foregroundColor(.white) // Definiert die Schriftfarbe des Textes
                                .padding(.horizontal, 20) // Fügt einen horizontalen Abstand von 20 Punkten zu beiden Seiten des Textes hinzu
                                .padding(.vertical, 10) // Fügt einen vertikalen Abstand von 10 Punkten über und unter dem Text hinzu
                                .lineLimit(1) // Begrenzt die Anzahl der Textzeilen auf 1, um sicherzustellen, dass der Text innerhalb der verfügbaren Platzes bleibt
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                    
            }
            .frame(width: size.width - 8,height: size.height / 1.2)
            .frame(width: size.width,height: size.height)
            
        }
        .tag("dark1)")
        
        .rotation3DEffect(.init(degrees: getProgress() * 90), axis: (x: 0,y: 1,z: 0),anchor:offset > 0 ? .leading : .trailing,anchorZ: 0,perspective: 0.6)
        
        .modifier(ScrollViewOffsetModifier(anchorPoint: .leading, offset: $offset))
        
    }
    func getProgress()->CGFloat{
        
        let progress = -offset / UIScreen.main.bounds.width
        
        return progress
    }
}

//struct CarousselBodyView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardAnimateView()
//    }
//}
