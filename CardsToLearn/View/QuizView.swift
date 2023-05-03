//
//  QuizView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 27.04.23.
//


import SwiftUI

struct QuizSelectionView: View {
    var flashcards: [Card]
    @State private var animate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                               
                               VStack(spacing: 30) {
                                   Spacer()
                                   
                                   Text("Choose a Quiz:")
                                       .font(.system(size: 36, weight: .bold, design: .default))
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.center)
                                   
                                   Spacer()
                    
                    NavigationLink(destination: QuizView(cards: flashcards)) {
                        Text("Flashcards Quiz")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 50)
                            .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                            .cornerRadius(25)
                            .shadow(color: .blue, radius: 5, x: 0, y: 5)
                            .scaleEffect(animate ? 1.05 : 1)
                            .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.5))
                            .onAppear() {
                                self.animate = true
                            }
                    }
                    
                    NavigationLink(destination: QuizCreationView()) {
                        Text("Create a Quiz")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 50)
                            .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                            .cornerRadius(25)
                            .shadow(color: .blue, radius: 5, x: 0, y: 5)
                            .scaleEffect(animate ? 1.05 : 1)
                            .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.7))
                            .onAppear() {
                                self.animate = true
                            }
                    }
                    
                    NavigationLink(destination: Text("FinishedQuizView")) {
                        Text("Finished Quizzes")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 50)
                            .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                            .cornerRadius(25)
                            .shadow(color: .blue, radius: 5, x: 0, y: 5)
                            .scaleEffect(animate ? 1.05 : 1)
                            .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.9))
                            .onAppear() {
                                self.animate = true
                            }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Quiz Selection")
        }
    }
}




struct QuizView: View {
    let cards: [Card]
    @State private var currentCard: Card?
    @State private var userAnswer = ""
    @State private var showAnswer = false
    @State private var isQuizOver = false
    @State private var score = 0
    
    var body: some View {
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

