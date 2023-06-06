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
    @Binding var shouldPopToRootView2: Bool
    
    var body: some View {
       
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
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
                    NavigationLink( destination: QuizGameView(shouldPopToRootView3: self.$shouldPopToRootView2, quiz: quiz.first!, questions: viewModel.questions.filter({ $0.quiz?.quizTitle == quiz.first!.quizTitle }))
                    ) {
                        Text("Start Quiz")
                    }
                    .isDetailLink(false)
                    
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
                .scrollContentBackground(.hidden)
            }
        
        
        var quizTitles: [String] {
            Array(Set(quiz.compactMap({ $0.quizTitle }))
                .sorted()
            )
        }
    }
}
