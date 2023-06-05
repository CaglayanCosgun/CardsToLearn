//
//  QuizCreateCollectionView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct QuizCreateCollectionView: View {
    @EnvironmentObject var viewModel: QuizViewModel // Eine Umgebungskomponente, die eine Instanz von QuizViewModel bereitstellt
    @Binding var shouldPopToRootView: Bool
    
    var body: some View {
        
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                let groupedQuizzes = Dictionary(grouping: viewModel.quizzes, by: { $0.quizTitle ?? "" }) // Bildet eine Gruppierung von Quizzelementen nach ihrem Titel in ein Wörterbuch ab
                let quizTitles = Array(groupedQuizzes.keys).sorted() // Erstellt eine sortierte Liste der Quiztitel
                
                List {
                    ForEach(quizTitles, id: \.self) { title in // Für jeden Quiztitel in der sortierten Liste
                        Section(header: Text(title)) { // Erstellt einen Abschnitt mit dem Titel als Überschrift
                            NavigationLink(destination: QuizDetailView(quiz: groupedQuizzes[title] ?? [] ,shouldPopToRootView2: self.$shouldPopToRootView)) { // Erstellt einen Navigationslink zu einer Detailansicht für das ausgewählte Quiz
                                Text("Questions")
                            }
                            .isDetailLink(false)
                        }
                    }
                    .onDelete(perform: viewModel.deleteQuiz) // Ermöglicht das Löschen eines Quizzelements durch Wischen oder Antippen des Löschsymbols
                }
                
                .navigationBarTitle("Created Quizzes") // Setzt den Titel der Navigationsleiste
                .listStyle(GroupedListStyle()) // Setzt den Stil der Liste auf einen gruppierten Stil
            }
            .scrollContentBackground(.hidden)
        
    }
}
