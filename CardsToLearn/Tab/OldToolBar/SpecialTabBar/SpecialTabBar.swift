//
//  SpecialToolBar.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

enum SpecialTabBar: String, CaseIterable {
case home = "Home"
case quotes = "Quotes"
case cards = "Card"
case quiz = "Quiz"
case profile = "Profile"
    
    var index: CGFloat {
        return CGFloat (SpecialTabBar.allCases.firstIndex(of: self) ?? 0)
    }
    
    static var count: CGFloat {
        return CGFloat(SpecialTabBar.allCases.count)
    }
}
