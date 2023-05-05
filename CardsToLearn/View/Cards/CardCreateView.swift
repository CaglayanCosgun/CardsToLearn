//
//  CardCreateView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI

struct CardCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var category: String = ""
    @State var question: String = ""
    @State var answer: String = ""
    @ObservedObject var viewModel : CardViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.gray, .white, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .ignoresSafeArea()
                Form {
                    Section(header: Text("Category")) {
                        TextField("Enter category", text: $category)
                    }
                    Section(header: Text("Question")) {
                        TextField("Enter question", text: $question)
                    }
                    Section(header: Text("Answer")) {
                        TextField("Enter answer", text: $answer)
                    }
                }
                .navigationBarTitle("Add Card")
                .navigationBarItems(
                    leading:
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        },
                    trailing:
                        Button("Save") {
                            viewModel.addCard(category: category, question: question, answer: answer)
                            presentationMode.wrappedValue.dismiss()
                        }.disabled(category.isEmpty || question.isEmpty || answer.isEmpty)
                )
            }
        }
    }
}
