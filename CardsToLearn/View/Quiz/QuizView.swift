//
//  QuizView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 27.04.23.
//


import SwiftUI

struct QuizView: View {
    let cards: [Card]
    @State private var currentCard: Card?
    @State private var userAnswer = ""
    @State private var showAnswer = false
    @State private var isQuizOver = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
            VStack {
                if let card = currentCard {
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
                    Text("Score: \(score)")
                } else if isQuizOver {
                    Text("Quiz is over! Final score: \(score)")
                    Button("Play again") {
                        restartQuiz()
                    }
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                startQuiz()
            }
        }
    }
    private func startQuiz() {
        currentCard = cards.randomElement()
        showAnswer = false
        isQuizOver = false
        score = 0
    }
    
    private func restartQuiz() {
        startQuiz()
    }
    
    private func checkAnswer() {
        if let card = currentCard {
            if userAnswer.lowercased() == card.answer?.lowercased() {
                score += 1
            }
            showAnswer = true
            if let index = cards.firstIndex(of: card), index < cards.count - 1 {
                currentCard = cards[index + 1]
                userAnswer = ""
                showAnswer = false
            } else {
                isQuizOver = true
            }
        }
    }
}

