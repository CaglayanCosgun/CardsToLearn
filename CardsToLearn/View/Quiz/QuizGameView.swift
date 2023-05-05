//
//  QuizGameView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct QuizGameView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    
    let quiz: Quiz
    let questions: [Questions]
    
    @State private var currentQuestion = 1
    @State private var score = 0
    
    var body: some View {
        VStack {
            HStack {
                Text(quiz.quizTitle ?? "")
                    .font(.title)
                Spacer()
                Text("Frage \(currentQuestion) von \(questions.count)")
            }
            .padding(.horizontal)
            
            VStack {
                Text(questions[currentQuestion-1].question ?? "")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                HStack(spacing: 20) { // zwei Frames nebeneinander
                    VStack(spacing: 20) { // zwei Frames untereinander
                        ForEach(0..<2) { index in
                            Button(action: {
                                checkAnswer(answer: questions[currentQuestion-1].answerOne ?? "")
                            }) {
                                Text(questions[currentQuestion-1].answerOne ?? "")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    
                    VStack(spacing: 20) { // zwei Frames untereinander
                        ForEach(2..<4) { index in
                            Button(action: {
                                checkAnswer(answer: questions[currentQuestion-1].answerTwo ?? "")
                            }) {
                                Text(questions[currentQuestion-1].answerTwo ?? "")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            NavigationLink(destination: ResultsView(score: score, totalQuestions: questions.count)) {
                Text("Ergebnisse anzeigen")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
            .opacity(currentQuestion == questions.count ? 1 : 0) // Ergebnisse anzeigen, wenn alle Fragen beantwortet wurden
        }
    }
    
    func checkAnswer(answer: String) {
        if answer == String(questions[currentQuestion-1].answerCorrect) {
            score += 1
        }
        
        if currentQuestion < questions.count {
            currentQuestion += 1
        }
    }

}
