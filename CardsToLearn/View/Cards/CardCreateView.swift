//
//  CardCreateView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI

struct CardCreateView: View {
    @Environment(\.presentationMode) var presentationMode // Zugriff auf den Präsentationsmodus, um die Ansicht zu schließen
    @State var category: String = "" // Der Benutzer eingegebene Kategorie
    @State var question: String = "" // Der Benutzer eingegebene Frage
    @State var answer: String = "" // Der Benutzer eingegebene Antwort
    @ObservedObject var viewModel : CardViewModel // Ein CardViewModel-Objekt zur Verarbeitung der eingegebenen Daten
    
    var body: some View { // Die Darstellung der Ansicht
        NavigationStack { // Eine Navigation-Container-Ansicht, um die Ansicht in einer Navigation-Hierarchie einzubetten
            ZStack { // Ein Container, um eine Hintergrundfarbe zu rendern
                LinearGradient(
                    gradient: Gradient(colors: [.gray, .white, .blue]), // Ein Farbverlauf für den Hintergrund
                    startPoint: .topLeading, // Der Startpunkt des Farbverlaufs
                    endPoint: .bottomTrailing) // Der Endpunkt des Farbverlaufs
                .ignoresSafeArea() // Ignoriert den Safe Area der Ansicht, um den Farbverlauf über den Bildschirmrand hinaus zu rendern
                Form { // Ein Container, um Textfelder und Abschnitte in der Ansicht anzuzeigen
                    Section(header: Text("Category")) { // Ein Abschnitt mit einer Überschrift "Category"
                        TextField("Enter category", text: $category) // Ein Textfeld für die Eingabe der Kategorie
                    }
                    Section(header: Text("Question")) { // Ein Abschnitt mit einer Überschrift "Question"
                        TextField("Enter question", text: $question) // Ein Textfeld für die Eingabe der Frage
                    }
                    Section(header: Text("Answer")) { // Ein Abschnitt mit einer Überschrift "Answer"
                        TextField("Enter answer", text: $answer) // Ein Textfeld für die Eingabe der Antwort
                    }
                }
                .navigationBarTitle("Add Card") // Der Titel der Navigation-Bar
                .navigationBarItems(
                    leading:
                        Button("Cancel") { // Ein Button zum Abbrechen der Eingabe
                            presentationMode.wrappedValue.dismiss() // Schließt die Ansicht, wenn der Benutzer auf "Cancel" klickt
                        },
                    trailing:
                        Button("Save") { // Ein Button zum Speichern der eingegebenen Karteninformationen
                            viewModel.addCard(category: category, question: question, answer: answer) // Fügt eine neue Karte zum ViewModel hinzu
                            presentationMode.wrappedValue.dismiss() // Schließt die Ansicht, wenn der Benutzer auf "Save" klickt
                        }.disabled(category.isEmpty || question.isEmpty || answer.isEmpty) // Der Button ist deaktiviert, wenn eines der Textfelder leer ist
                )
            }
        }
    }
}

struct CardCreate_Previews: PreviewProvider {
    static var previews: some View {
        CardCreateView(viewModel: CardViewModel())
    }
}
