//
//  CardDetailView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card // Die anzuzeigende Karte
    @State private var showingQuestion = true // Ein interner Zustand, der angibt, ob die Frage oder Antwort angezeigt wird

    var body: some View {
        ZStack { // Ein Container, um die Ansicht zu rendern
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.gray]), // Ein Farbverlauf für den Hintergrund
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund

            VStack(alignment: .center, spacing: 20) { // Ein vertikal ausgerichteter Container mit Abständen zwischen den Elementen
                if showingQuestion { // Wenn die Frage angezeigt wird
                    VStack(alignment: .center, spacing: 10) { // Ein vertikal ausgerichteter Container für die Frage
                        Text("Question:")
                            .font(.largeTitle)
                            .fontWeight(.bold) // Ein großer Text für die Überschrift
                        ShimmeringText(text: card.question ?? "") // Ein animiertes Textfeld, um die Frage anzuzeigen
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 400, height: 300) // Ein Rahmen für die Frage
                    .background(Color.yellow) // Ein gelber Hintergrund für die Frage
                    .cornerRadius(10) // Runde Ecken für den Rahmen
                } else { // Wenn die Antwort angezeigt wird
                    VStack(alignment: .center, spacing: 10) { // Ein vertikal ausgerichteter Container für die Antwort
                        Text("Answer:")
                            .font(.largeTitle)
                            .fontWeight(.bold) // Ein großer Text für die Überschrift
                        ShimmeringText(text: card.answer ?? "") // Ein animiertes Textfeld, um die Antwort anzuzeigen
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 400, height: 300) // Ein Rahmen für die Antwort
                    .background(Color(red: 255/255, green: 215/255, blue: 0/255)) // Ein orangefarbener Hintergrund für die Antwort
                    .cornerRadius(10) // Runde Ecken für den Rahmen
                }

                Spacer() // Ein Abstand zwischen dem vorherigen Container und dem folgenden

                HStack { // Ein horizontal ausgerichteter Container
                    Spacer()
                    Button(showingQuestion ? "Show Answer" : "Show Question") { // Ein Button, um zwischen Frage und Antwort zu wechseln
                        showingQuestion.toggle() // Ändert den internen Zustand, um die Frage oder Antwort anzuzeigen
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10) // Ein Button, um zwischen Frage und Antwort zu wechseln
                    Spacer()
                }
            }
            .padding() // Ein Innenabstand für den Container
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Stellt sicher, dass der Container den gesamten verfügbaren Platz einnimmt
            .toolbar { // Eine Toolbar zur Anzeige der Kategorie
                ToolbarItem(placement: .principal) { // Definiert ein neues Toolbar-Element und platziert es zentral
                    VStack(alignment: .center, spacing: 0) { // Definiert ein vertikales Stack-Element mit zentrierter Ausrichtung und keinem Abstand zwischen den Elementen
                        Text(card.category ?? "") // Fügt einen Text hinzu, der die Kategorie der Karte darstellt; der Null-Coalescing-Operator stellt sicher, dass der Text angezeigt wird, wenn card.category nicht nil ist
                            .font(.title) // Definiert die Schriftgröße des Textes
                            .foregroundColor(.black) // Definiert die Schriftfarbe des Textes
                            .padding(.horizontal, 20) // Fügt einen horizontalen Abstand von 20 Punkten zu beiden Seiten des Textes hinzu
                            .padding(.vertical, 10) // Fügt einen vertikalen Abstand von 10 Punkten über und unter dem Text hinzu
                            .lineLimit(1) // Begrenzt die Anzahl der Textzeilen auf 1, um sicherzustellen, dass der Text innerhalb der verfügbaren Platzes bleibt
                    }
                }
            }
                .navigationBarTitleDisplayMode(.large) // Definiert, dass der Titel in der Navigation Bar groß angezeigt werden soll

        }
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card()
        CardDetailView(card: card)
    }
}

