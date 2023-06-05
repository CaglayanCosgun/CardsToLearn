//
//  Stories.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import Foundation
import SwiftUI

struct Story: Identifiable,Hashable {
    var id = UUID().uuidString
    var image: String
    var titel: String
}

var stories = [
    Story(image: "morning", titel: "Good Morning"),
    Story(image: "noon", titel: "Good Noon"),
    Story(image: "evening", titel: "Good Evening"),
    Story(image: "night", titel: "Good Night")
]

enum SlideTabs: String,CaseIterable {
    case notes = "Note"
    case quotes = "Quotes"
    case account = "Profile"
    case cards = "Cards"
    case quiz = "Quiz"
    case tips = "Tips"
    case relax = "Relax"
    
    var systemImage: String {
        switch self {
        case.notes:
            return "house"
        case.quotes:
            return "quote.bubble"
        case.account:
            return "Profile"
        case.cards:
            return "square.grid.2x2"
        case.quiz:
            return "gamecontroller"
        case.tips:
            return "lightbulb"
        case.relax:
            return "beach.umbrella"
        }
    }
    var index: Int {
        return SlideTabs.allCases.firstIndex(of: self) ?? 0
    }
}
