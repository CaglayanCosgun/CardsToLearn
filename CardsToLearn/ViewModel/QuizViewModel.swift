//
//  QuizViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.04.23.
//

import SwiftUI
import CoreData

class QuizViewModel: ObservableObject {
    
    var container: NSPersistentContainer
    @Published var quizzes: [Quiz] = []
    @Published var questions: [Questions] = []
    
    
    init() {
        container = NSPersistentContainer(name: "ModelQuiz")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
        
        fetchQuizzes()
        fetchQuestions()
    }
    
    func fetchQuizzes() {
        let request = NSFetchRequest<Quiz>(entityName: "Quiz")
        
        do {
            quizzes = try container.viewContext.fetch(request)
        } catch {
            print("Loading the data failed: \(error)")
        }
    }
    func fetchQuestions() {
        let request = NSFetchRequest<Questions>(entityName: "Questions")
        
        do {
            questions = try container.viewContext.fetch(request)
        } catch {
            print("Loading the data failed: \(error)")
        }
    }
    
    
    func saveQuiz(answerCorrect:Int16,question:String,answerOne:String,answerTwo:String,answerThree:String,answerFour:String,quizTitle:String) {
        
        let newQuiz = Quiz(context: container.viewContext)
        
        let newQuestion = Questions(context: container.viewContext)
        newQuestion.question = question
        newQuestion.answerOne = answerOne
        newQuestion.answerTwo = answerTwo
        newQuestion.answerThree = answerThree
        newQuestion.answerFour = answerFour
        newQuestion.answerCorrect = answerCorrect
        newQuestion.quiz = newQuiz
        newQuestion.quiz?.quizTitle = quizTitle
        
        
        do {
            try container.viewContext.save()
            fetchQuizzes()
            fetchQuestions()
        } catch {
            print("Saving Quiz failed: \(error)")
        }
    }
    
    func deleteQuiz(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("No index inside IndexSet")
            return
        }
        
        let quizToDelete = quizzes[index]
        container.viewContext.delete(quizToDelete)
        do {
            try container.viewContext.save()
            fetchQuizzes()
        } catch {
            print("Error while deleting a todo \(error)")
        }
    }
    
    func deleteQuestion(_ question: Questions) {
           container.viewContext.delete(question)
           do {
               try container.viewContext.save()
               fetchQuestions()
           } catch {
               print("Error while deleting a question: \(error)")
           }
       }
   }

