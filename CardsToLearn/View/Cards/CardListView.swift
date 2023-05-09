//
//  CardListView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI


struct CardListView: View {
    let cards: [Card] // Die Liste der Karten
    @Binding var selectedCard: Card? // Die ausgewählte Karte
    @ObservedObject var viewModel: CardViewModel // Das ViewModel, welches die Logik enthält
    
    @State private var isRectangular = false // Ein interner Zustand, um zwischen rechteckigen und normalen Karten zu wechseln
    
    private var categories: [String] { // Eine berechnete Eigenschaft, um eine Liste der Kategorien zu erhalten
        Array(Set(cards.compactMap { $0.category })).sorted() // Durchlaufen Sie die Liste der Karten, um alle Kategorien zu erhalten, entfernen Sie dann alle nils, und sortieren Sie die Kategorien alphabetisch.
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea() // Ein Farbverlauf als Hintergrund für die Ansicht, der den sicheren Bereich der Ansicht überschreitet
            
            List { // Die Hauptliste, die alle Karten nach Kategorie gruppiert darstellt
                ForEach(categories, id: \.self) { category in // Für jede Kategorie eine Sektion erstellen
                    Section(header: Text(category)) {
                        ForEach(filteredCards(forCategory: category)) { card in // Für jede Karte in dieser Kategorie eine Zeile erstellen
                            NavigationLink(destination: CardDetailView(card: card), tag: card, selection: $selectedCard) { // Navigationslink, um zur Detailansicht der Karte zu gelangen
                                if isRectangular { // Falls der interne Zustand rechteckig ist
                                    Rectangle() // Eine rechteckige Karte erstellen
                                        .foregroundColor(.white)
                                        .frame(height: 100)
                                        .overlay(
                                            VStack(alignment: .leading) { // Eine vertikale Schicht erstellen
                                                Text(card.question ?? "")
                                                Text(card.answer ?? "")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            .padding() // Einen inneren Abstand hinzufügen
                                        )
                                        .cornerRadius(10) // Rundungen an den Ecken hinzufügen
                                        .shadow(radius: 3) // Einen Schatten hinzufügen
                                } else { // Andernfalls eine normale Karte erstellen
                                    VStack(alignment: .leading) {
                                        Text(card.question ?? "")
                                        Text(card.answer ?? "")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteCard) // Ein Löschvorgang, wenn der Benutzer die Zeile nach links wischt
            }
            .toolbar { // Eine Symbolleiste am oberen Rand der Ansicht
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isRectangular.toggle() // Ein Button, um zwischen rechteckigen und normalen Karten zu wechseln
                    }) {
                        Image(systemName: isRectangular ? "rectangle.grid.1x2.fill" : "rectangle.grid.2x2.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
            .scrollContentBackground(.hidden)// Die Methode .scrollContentBackground(.hidden) wird auf die List angewendet und setzt den Hintergrund der Inhaltsansicht der Liste auf transparent.
        }
    }
    //Die Funktion verwendet die filter-Funktion, um nur Karten mit der angegebenen Kategorie beizubehalten, und sortiert sie dann aufsteigend nach der Frage.
    private func filteredCards(forCategory category: String) -> [Card] {
        cards.filter { $0.category == category }
            .sorted { $0.question?.localizedCaseInsensitiveCompare($1.question ?? "") == .orderedAscending }
        // Die Methode localizedCaseInsensitiveCompare vergleicht zwei Zeichenketten und gibt einen ComparisonResult zurück, der besagt, ob die erste Zeichenkette aufsteigend, absteigend oder gleich der zweiten Zeichenkette ist. Wenn die erste Frage alphabetisch vor der zweiten Frage steht, wird ComparisonResult.orderedAscending zurückgegeben, andernfalls wird ComparisonResult.orderedDescending zurückgegeben. Wenn beide Fragen gleich sind, wird ComparisonResult.orderedSame zurückgegeben.Die Funktion gibt das sortierte Array von Card-Objekten zurück.
        
        
    }
}

