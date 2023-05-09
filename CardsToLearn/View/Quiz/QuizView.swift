//
//  QuizView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 27.04.23.
//


import SwiftUI

struct QuizView: View {
    let cards: [Card]
    @State private var currentCardIndex = 0
    @State private var userAnswer = ""
    @State private var showAnswer = false
    @State private var isQuizOver = false
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                if currentCardIndex < cards.count {
                    let card = cards[currentCardIndex]
                    Text(card.category ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(card.question ?? "")
                        .font(.title)
                        .padding()
                    TextField("Your answer", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Submit") {
                        checkAnswer()
                    }
                    if showAnswer {
                        Text(card.answer ?? "")
                            .font(.headline)
                            .padding()
                    }
                    Text("Score: \(correctAnswers)/\(cards.count)")
                } else if isQuizOver {
                    VStack {
                        Text("Quiz is over! Final score: \(correctAnswers)/\(cards.count)")
                        Text("Correct answers: \(correctAnswers)")
                        Text("Wrong answers: \(wrongAnswers)")
                        Button("Play again") {
                            startQuiz()
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                startQuiz()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func startQuiz() {
        currentCardIndex = 0
        showAnswer = false
        isQuizOver = false
        correctAnswers = 0
        wrongAnswers = 0
    }
    
    private func checkAnswer() {
        if currentCardIndex < cards.count {
            let card = cards[currentCardIndex]
            let isCorrect = userAnswer.lowercased() == card.answer?.lowercased()
            if isCorrect {
                correctAnswers += 1
                showAlert(title: "Correct", message: "Great job!")
            } else {
                wrongAnswers += 1
                showAlert(title: "Wrong", message: "The correct answer is \(card.answer ?? "")")
            }

            showAnswer = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if currentCardIndex < cards.count - 1 {
                    currentCardIndex += 1
                    userAnswer = ""
                    showAnswer = false
                } else {
                    let totalScore = correctAnswers * 100 / cards.count
                    showAlert(title: "Quiz Over", message: "Congratulations! You have completed the quiz. Your score is \(totalScore)%")
                    isQuizOver = true
                
                }
            }
        }
    }

    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
