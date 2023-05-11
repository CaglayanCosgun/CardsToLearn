//
//  ResultsView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct ResultsView: View {
    let score: Int
    let totalQuestions: Int
    let questions: [Questions]
    let correctAnswers: [Int]
    @State private var selectedAnswers = [String]()
    @State private var currentQuestion = 1
    @State var answerCorrect = false
    
    var body: some View {
        VStack {
            Text("Ergebnisse")
                .font(.title)
                .padding()

            Text("Score: \(score) / \(totalQuestions)")
                .font(.headline)
                .padding()

            ForEach(questions.indices) { index in
                let question = questions[index]
                

                HStack {
                    Text(question.question ?? "")
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                    

                    if correctAnswers[index] == 1 {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .padding()
                    } else {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                            .padding()
                        
                        
                    }
                }
                
            }
            
            Button("Play Again") {
                reStartQuiz()
            }
            .font(.headline)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
         
    }
    private func reStartQuiz() {
       currentQuestion = 1
       answerCorrect = false
       selectedAnswers = [String]()
        
   }
    
}

