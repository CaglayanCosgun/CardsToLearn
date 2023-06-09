//
//  QuizApiView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 22.05.23.
//

import SwiftUI

struct QuizApiView: View {
    @EnvironmentObject var viewModel: ApiCallViewModel
    @State private var selectedCategory: String?
    
    var body: some View {
            VStack {
                Button(action: {
                    viewModel.fetchQuiz()
                }) {
                    Text("Aktualisieren der Fragen")
                }
                
                List {
                    ForEach(Array(Set(viewModel.quizzes.map { $0.category.name })), id: \.self) { categoryName in
                        Button(action: {
                            selectedCategory = categoryName
                        }) {
                            Text(categoryName)
                                .font(.headline)
                                .foregroundColor(selectedCategory == categoryName ? .blue : .black)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                        
                        if let selectedCategory = selectedCategory, selectedCategory == categoryName {
                            ForEach(viewModel.quizzes.filter { $0.category.name == categoryName }, id: \.self) { quiz in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(quiz.text)
                                        .font(.headline)
                                    
                                    ForEach(quiz.options, id: \.self) { option in
                                        Button(action: {
                                            viewModel.selectedOption = option
                                        }) {
                                            Text(option.option)
                                                .foregroundColor(option == viewModel.selectedOption && option.isCorrect ? .green : option == viewModel.selectedOption ? .red : .black)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    
                                    
                                    Text("Difficulty: \(quiz.difficulty.degree)")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Quiz Api")
            .onAppear {
                viewModel.fetchQuiz()
            }
        
    }
}

struct QuizApiView_Previews: PreviewProvider {
    static var previews: some View {
        QuizApiView()
    }
}
