//
//  QuizApiView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 22.05.23.
//

import SwiftUI

struct QuizApiView: View {
    @EnvironmentObject var viewModel: ApiCallViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentQuestionIndex = 0
    @State private var correctAnswers = 0
    @State private var incorrectAnswers = 0
    @State private var showSummary = false
    @State private var showAlert = false
    @State private var quitQuiz = false
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                Button {
                    dismiss()
                    showAlert = true
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Bestätigung"),
                        message: Text("Möchten Sie wirklich das Quiz abbrechen?"),
                        primaryButton: .default(Text("Ja"),
                                                action: {
                                                    quitQuiz = true
                                                    
                                                    
                                                }),
                        secondaryButton: .cancel(Text("Nein"), action: {
                            quitQuiz = false
                        })
                    )
                }
                .hAlign(.top)
            }
            .padding()
            .navigationTitle("Quiz Api")
            .onAppear {
                viewModel.fetchQuiz()
            }
            
            if currentQuestionIndex < viewModel.quizzes.count {
                let currentQuestion = viewModel.quizzes[currentQuestionIndex]
                QuestionView2(question: currentQuestion, onNextQuestion: nextQuestion, updateScores: updateScores)
            } else if currentQuestionIndex == viewModel.quizzes.count {
                SummaryView(correctAnswers: correctAnswers, incorrectAnswers: incorrectAnswers)
            } else {
                Text("No questions available")
            }
            
            Text("Correct Answers: \(correctAnswers)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.green)
            Text("Incorrect Answers: \(incorrectAnswers)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex < viewModel.quizzes.count {
            currentQuestionIndex += 1
        }
    }
    
    func updateScores(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
        }
    }
}

struct QuestionView2: View {
    let question: ApiQuestions
    let onNextQuestion: () -> Void
    let updateScores: (Bool) -> Void
    
    @State private var selectedOption: Int?
    
    var body: some View {
        VStack(spacing: 15) {
            Text(question.text)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(question.options.indices) { index in
                Button(action: {
                    // Handle option selection
                    selectedOption = index
                    
                    // Update scores based on the correctness of the answer
                    let isCorrect = question.options[index].isCorrect
                    updateScores(isCorrect)
                    
                    // Move to the next question
                    onNextQuestion()
                }) {
                    Text(question.options[index].option)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonBackgroundColor(for: index))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedOption != nil) // Disable the button after selection
                
                .onChange(of: selectedOption) { newValue in
                    if newValue != index {
                        selectedOption = nil
                    }
                }
            }
        }
    }
    
    private func buttonBackgroundColor(for index: Int) -> Color {
        if let selectedOption = selectedOption {
            if index == selectedOption {
                return question.options[index].isCorrect ? .green : .red
            }
        }
        return .gray
            
    }
}



struct SummaryView: View {
    let correctAnswers: Int
    let incorrectAnswers: Int
    
    var body: some View {
        VStack {
            Text("Quiz Summary")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Correct Answers: \(correctAnswers)")
                .font(.headline)
                .padding()
            
            Text("Incorrect Answers: \(incorrectAnswers)")
                .font(.headline)
                .padding()
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}



struct QuizApiView_Previews: PreviewProvider {
    static var previews: some View {
        QuizApiView()
    }
}
