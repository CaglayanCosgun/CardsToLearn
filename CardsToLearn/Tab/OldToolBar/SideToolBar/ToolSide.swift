//
//  ToolSide.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import Foundation
import SwiftUI

struct Tool: Identifiable {
    var id = UUID().uuidString
    var icon: String
    var name: String
    var color: Color
    var toolPosition: CGRect = .zero
}
