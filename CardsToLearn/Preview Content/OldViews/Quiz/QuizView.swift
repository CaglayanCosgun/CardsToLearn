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
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
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
                    if !userAnswer.isEmpty {
                        Button("Submit") {
                            checkAnswer()
                        }
                    }
                    
                    if showAnswer {
                        Text(card.answer ?? "")
                            .font(.headline)
                            .padding()
                    }
                    
                    Text("Score: \(correctAnswers)/\(cards.count)")
                }  else {
                    VStack(spacing: 20) {
                        Text("Quiz is over! Final score: \(correctAnswers)/\(cards.count)")
                            .font(.title)
                        HStack(spacing: 20) {
                            VStack {
                                Text("Correct Answers")
                                    .font(.headline)
                                Text("\(correctAnswers)")
                                    .font(.title)
                            }
                            VStack {
                                Text("Wrong Answers")
                                    .font(.headline)
                                Text("\(wrongAnswers)")
                                    .font(.title)
                            }
                        }
                        Button("Play Again") {
                            startQuiz()
                        }
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        // "Back to Quiz" button
                        //                        NavigationLink(destination: QuizSelectionView(flashcards: cards)) {
                        //                            Text("Back to Quiz")
                        //                                .font(.headline)
                        //                                .padding(.vertical, 10)
                        //                                .padding(.horizontal, 20)
                        //                                .background(Color.gray)
                        //                                .foregroundColor(.white)
                        //                                .cornerRadius(10)
                        //                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
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
            if userAnswer.isEmpty {
                showAlert(title: "Bitte eine Antwort eingeben",message: "")
            } else {
                if isCorrect {
                    correctAnswers += 1
                    showAlert(title: "Correct", message: "Great job!")
                } else {
                    wrongAnswers += 1
                    showAlert(title: "Wrong", message: "The correct answer is \(card.answer ?? "")")
                }
                showAnswer = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if currentCardIndex < cards.count {
                        currentCardIndex += 1
                        userAnswer = ""
                        showAnswer = false
                    } else if currentCardIndex >= cards.count  {
                        let totalScore = correctAnswers * 100 / cards.count
                        showAlert(title: "Quiz Over", message: "Congratulations! You have completed the quiz. Your score is \(totalScore)%")
                        isQuizOver = true
                    }
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
