//
//  ApiWordResponse.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 26.05.23.
//

import Foundation

struct ApiWordResponse: Codable, Hashable {
    let definition: String
    let word: String
    let valid: Bool
}
