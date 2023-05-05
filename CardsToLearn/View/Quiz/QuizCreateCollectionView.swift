//
//  QuizCreateCollectionView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct QuizCreateCollectionView: View {
    @EnvironmentObject var viewModel : QuizViewModel
    
    var body: some View {
        NavigationView {
            let groupedQuizzes = Dictionary(grouping: viewModel.quizzes, by: { $0.quizTitle ?? "" })
            let quizTitles = Array(groupedQuizzes.keys).sorted()
            
            List {
                ForEach(quizTitles, id: \.self) { title in
                    Section(header: Text(title)) {
                        NavigationLink(destination: QuizDetailView(quiz: groupedQuizzes[title] ?? [])) {
                            Text("Questions")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteQuiz)
            }
            .navigationBarTitle("Created Quizzes")
            .listStyle(GroupedListStyle())
        }
    }
}
