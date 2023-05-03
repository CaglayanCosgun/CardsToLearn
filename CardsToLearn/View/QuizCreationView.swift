//
//  QuizCreationView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.05.23.
//

import SwiftUI


struct QuizCreationView: View {

    @StateObject var viewModel = QuizViewModel()

    @State private var quizTitle = ""
    @State private var question = ""
    @State private var answerOne = ""
    @State private var answerTwo = ""
    @State private var answerThree = ""
    @State private var answerFour = ""
    @State private var answerCorrect = 0

    @State private var isQuizListPresented = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Quiz Title")) {
                    TextField("Enter Quiz Title", text: $quizTitle)
                }

                Section(header: Text("Question")) {
                    TextField("Enter Question", text: $question)
                }

                Section(header: Text("Answers")) {
                    TextField("Enter Answer 1", text: $answerOne)
                    TextField("Enter Answer 2", text: $answerTwo)
                    TextField("Enter Answer 3", text: $answerThree)
                    TextField("Enter Answer 4", text: $answerFour)
                }

                Section(header: Text("Correct Answer")) {
                    Picker(selection: $answerCorrect, label: Text("Select Correct Answer")) {
                        Text(answerOne).tag(0)
                        Text(answerTwo).tag(1)
                        Text(answerThree).tag(2)
                        Text(answerFour).tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button("Add Question") {
                        viewModel.saveQuiz(answerCorrect: Int16(answerCorrect),
                                           question: question,
                                           answerOne: answerOne,
                                           answerTwo: answerTwo,
                                           answerThree: answerThree,
                                           answerFour: answerFour,
                                           quizTitle: quizTitle)

                        question = ""
                        answerOne = ""
                        answerTwo = ""
                        answerThree = ""
                        answerFour = ""
                        answerCorrect = 0
                        quizTitle = ""
                    }
                    .disabled(question.isEmpty || answerOne.isEmpty || answerTwo.isEmpty || answerThree.isEmpty || answerFour.isEmpty)
                }
            }
            .navigationBarTitle("Create Quiz")
            .navigationBarItems(trailing: Button(action: {
                isQuizListPresented = true
            }, label: {
                Image(systemName: "list.bullet")
            }))
            .sheet(isPresented: $isQuizListPresented, content: {
                QuizCreateCollectionView()
            })
        }
    }
}

struct QuizCreateCollectionView: View {
    @StateObject var viewModel = QuizViewModel()

    var body: some View {
        NavigationView {
            let groupedQuizzes = Dictionary(grouping: viewModel.quizzes, by: { $0.quizTitle ?? "" })
            let quizTitles = Array(groupedQuizzes.keys).sorted()

            List {
                ForEach(quizTitles, id: \.self) { title in
                    Section(header: Text(title)) {
                        ForEach(groupedQuizzes[title] ?? []) { quiz in
                            NavigationLink(destination: QuizDetailView(quiz: quiz)) {
                                Text("Question \(quiz.questions?.count ?? 0)")
                            }
                        }
                        .onDelete { indexSet in
                            guard let quizToDelete = groupedQuizzes[title]?[indexSet.first ?? 0] else { return }
                            viewModel.deleteQuiz(quizToDelete)
                        }
                    }
                }
            }
            .navigationBarTitle("Created Quizzes")
            .listStyle(GroupedListStyle())
        }
    }

    
    
    
    struct QuizDetailView: View {
        let quiz: Quiz
        @StateObject var viewModel = QuizViewModel()
        
        var body: some View {
            List {
                ForEach(Array(quiz.questions?.allObjects as? [Questions] ?? []), id: \.self) { question in
                    VStack(alignment: .leading) {
                        Text(question.question ?? "")
                            .font(.headline)
                        Text("A: " + (question.answerOne ?? ""))
                        Text("B: " + (question.answerTwo ?? ""))
                        Text("C: " + (question.answerThree ?? ""))
                        Text("D: " + (question.answerFour ?? ""))
                    }
                }
            }
            .navigationBarTitle(Text(quiz.quizTitle ?? ""), displayMode: .inline)
        }
    }
}
