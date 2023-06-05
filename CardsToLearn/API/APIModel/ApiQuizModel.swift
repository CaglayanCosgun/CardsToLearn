//
//  ApiQuiz.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 22.05.23.
//

import SwiftUI

struct ApiResponse: Codable,Hashable {
    var questions: [ApiQuestions]
}

struct ApiQuestions: Codable,Hashable {
    var _id : String
    var text: String
    var options : [Options]
    var category : Category
    var difficulty : Difficulty
}

struct Options: Codable,Hashable {
    var option : String
    var isCorrect : Bool
}

struct Category: Codable,Hashable {
    var _id : String
    var name: String
}
struct Difficulty: Codable,Hashable {
    var _id : String
    var degree : String
}
