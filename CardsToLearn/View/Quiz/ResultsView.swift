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
    
    var body: some View {
        VStack {
            Text("Ergebnisse")
                .font(.title)
                .padding()
            
            Text("Du hast \(score) von \(totalQuestions) Fragen richtig beantwortet.")
                .font(.headline)
                .padding()
            
            Spacer()
        }
    }
}
