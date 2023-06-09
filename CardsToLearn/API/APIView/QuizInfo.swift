//
//  QuizInfo.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 09.06.23.
//

import SwiftUI

struct QuizInfo {
    var title: String
    var rules: [Rules]
}

struct Rules: Identifiable{
    var id = UUID().uuidString
    var rule: String
}

var sampleRules: [Rules] = [
    Rules(rule: "Alle Fragen sind auf Englisch"),
    Rules(rule: "Nach jedem neu Start ändern sich die Quiz fragen"),
    Rules(rule: "4 Optionen stehen zur verfügung und nur eine ist Richtig")

]
