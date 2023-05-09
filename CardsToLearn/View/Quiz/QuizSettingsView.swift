//
//  QuizSettingsView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.05.23.
//

import SwiftUI

struct QuizSettingsView: View {
    @Binding var selectedCard: Card?
    let cards: [Card]
    @State var questionCount: Int = 1
    @State var selectedCategory: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if let card = selectedCard {
                    let categories = Set(["All"] + cards.filter({ $0.category != nil }).map({ $0.category! })).sorted(by: { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending })
                    
                    Text("Quiz Einstellungen")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 32)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wähle deine Kategorie:")
                            .font(.headline)
                        
                        Picker(selection: $selectedCategory, label: Text("Select category")) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: 300)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wähle die Anzahl der Fragen:")
                            .font(.headline)
                        
                        Picker(selection: $questionCount, label: Text("Number of questions")) {
                            ForEach(0...totalQuestions(in: selectedCategory), id: \.self) { count in
                                Text("\(count)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: 300)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: QuizView(cards: selectedCategory == "All" ? cards.shuffled().prefix(questionCount).map({ $0 }) : cards.filter({ $0.category == selectedCategory }).shuffled().prefix(questionCount).map({ $0 })),
                                   label: {
                                    Text("Quiz starten")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                   })
                        .padding(.top, 32)
                        .padding(.horizontal)
                        .disabled(selectedCategory.isEmpty || questionCount <= 0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Quiz Settings")
                        .font(.headline)
                }
            }
        }
    }
    
    func totalQuestions(in category: String) -> Int {
        return category == "All" ? cards.count : cards.filter({ $0.category == category }).count
    }
}
