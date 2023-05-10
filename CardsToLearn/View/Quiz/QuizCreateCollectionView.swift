//
//  QuizCreateCollectionView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct QuizCreateCollectionView: View {
    @EnvironmentObject var viewModel: QuizViewModel // Eine Umgebungskomponente, die eine Instanz von QuizViewModel bereitstellt
    
    var body: some View {
        NavigationView { // Eine Navigationsansicht
            let groupedQuizzes = Dictionary(grouping: viewModel.quizzes, by: { $0.quizTitle ?? "" }) // Bildet eine Gruppierung von Quizzelementen nach ihrem Titel in ein Wörterbuch ab
            let quizTitles = Array(groupedQuizzes.keys).sorted() // Erstellt eine sortierte Liste der Quiztitel
            
            List {
                ForEach(quizTitles, id: \.self) { title in // Für jeden Quiztitel in der sortierten Liste
                    Section(header: Text(title)) { // Erstellt einen Abschnitt mit dem Titel als Überschrift
                        NavigationLink(destination: QuizDetailView(quiz: groupedQuizzes[title] ?? [])) { // Erstellt einen Navigationslink zu einer Detailansicht für das ausgewählte Quiz
                            Text("Questions")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteQuiz) // Ermöglicht das Löschen eines Quizzelements durch Wischen oder Antippen des Löschsymbols
            }
            .navigationBarTitle("Created Quizzes") // Setzt den Titel der Navigationsleiste
            .listStyle(GroupedListStyle()) // Setzt den Stil der Liste auf einen gruppierten Stil
        }
    }
}
