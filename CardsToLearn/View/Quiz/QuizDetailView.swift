//
//  QuizDetailView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct QuizDetailView: View {
    let quiz: [Quiz]
    @EnvironmentObject var viewModel: QuizViewModel
    
    @State private var showConfirmationAlert = false
    @State private var selectedQuestion: Questions?
    @State private var startQuiz = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(quizTitles, id: \.self) { quizTitle in
                        Section(header: Text(quizTitle)) {
                            let filteredQuestions = viewModel.questions.filter({ $0.quiz?.quizTitle == quizTitle })
                            ForEach(filteredQuestions, id: \.self) { question in
                                VStack(alignment: .leading) {
                                    Text(question.question ?? "")
                                        .font(.headline)
                                    Text("A: " + (question.answerOne ?? ""))
                                    Text("B: " + (question.answerTwo ?? ""))
                                    Text("C: " + (question.answerThree ?? ""))
                                    Text("D: " + (question.answerFour ?? ""))
                                    Button(action: {
                                        selectedQuestion = question
                                        showConfirmationAlert = true
                                    }) {
                                        Text("Delete")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                }
                NavigationLink( destination: QuizGameView(quiz: quiz.first!, questions: viewModel.questions.filter({ $0.quiz?.quizTitle == quiz.first!.quizTitle }))
                                ) {
                                    Text("Start Quiz")
                                }
                
            }
            .navigationBarTitle(Text(quiz.first?.quizTitle ?? ""), displayMode: .inline)
            .alert(isPresented: $showConfirmationAlert) {
                Alert(
                    title: Text("Delete Question"),
                    message: Text("Are you sure you want to delete this question?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let questionToDelete = selectedQuestion {
                            viewModel.deleteQuestion(questionToDelete)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        
        var quizTitles: [String] {
            Array(Set(quiz.compactMap({ $0.quizTitle }))
                .sorted()
                  )
        }
    }
}
