//
//  QuizGameView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct QuizGameView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Binding var shouldPopToRootView3: Bool
    
    
    let quiz: Quiz
    let questions: [Questions]
    @State var answerCorrect = false
    
    @State private var currentQuestion = 1
    @State private var score = 0
    @State private var correctAnswers: [Int] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
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
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<4) { index in
                            Button(action: {
                                checkAnswer(answer: index)
                                
                            }) {
                                Text(getAnswer(index: index))
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
                    .padding()
                }
                
                Spacer()
                
                NavigationLink(destination: ResultsView(score: score, totalQuestions: questions.count,questions: questions,correctAnswers: correctAnswers)) {
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
                Button {
                    self.shouldPopToRootView3 = false
                    
                } label: {
                    Text("Back To Home")
                }
            }
        }
    }
    
    
    func checkAnswer(answer: Int) {
        if answer == questions[currentQuestion-1].answerCorrect {
            score += 1
            answerCorrect = true
            correctAnswers.append(1)
        }else {
            correctAnswers.append(0)
        }
        
        if currentQuestion < questions.count {
            currentQuestion += 1
        }
    }
    
    func getAnswer(index: Int) -> String {
        switch index {
        case 0:
            return questions[currentQuestion-1].answerOne ?? ""
        case 1:
            return questions[currentQuestion-1].answerTwo ?? ""
        case 2:
            return questions[currentQuestion-1].answerThree ?? ""
        case 3:
            return questions[currentQuestion-1].answerFour ?? ""
        default:
            return ""
        }
    }
}
