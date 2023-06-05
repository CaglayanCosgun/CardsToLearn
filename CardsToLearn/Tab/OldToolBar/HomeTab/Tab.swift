//
//  Tab.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 01.06.23.
//

import SwiftUI

enum Tab: String,CaseIterable {
    case home = "Home"
    case quotes = "Quotes"
    case cards = "Cards"
    case quiz = "Quiz"
    case profile = "Profile"
    
    var systemImage: String {
        switch self {
        case.home:
            return "house"
        case.quotes:
            return "quote.bubble"
        case.cards:
            return "square.grid.2x2"
        case.quiz:
            return "gamecontroller"
        case.profile:
            return "person.crop.circle"
        }
    }
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}


