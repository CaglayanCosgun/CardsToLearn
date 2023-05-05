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
    @State private var selectedAnswers = [String]()

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
                let answeredCorrectly = String(question.answerCorrect) == (selectedAnswers.indices.contains(index) ? selectedAnswers[index] : "")

                HStack {
                    Text(question.question ?? "")
                        .font(.headline)
                        .padding()

                    Spacer()

                    if answeredCorrectly {
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

        }
    }
}
