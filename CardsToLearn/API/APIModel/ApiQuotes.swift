//
//  ApiQuotes.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 30.05.23.
//

import Foundation

struct ApiQuotes: Codable,Hashable {
    var quote: String
    var author: String
    var category: String
    
}


struct QuotePic:  Hashable, Identifiable{
    var id = UUID().uuidString
    var title: String
    var imageText: String
    var author: String
    var category: String
    
}

var sampleImages: [QuotePic] = [
    .init(title: "A", imageText: "dark1", author: "1",category: "W"),
    .init(title: "b", imageText: "dark2", author: "1",category: "W"),
    .init(title: "c", imageText: "dark3", author: "1",category: "W"),
    .init(title: "d", imageText: "dark4", author: "1",category: "W"),
    .init(title: "e", imageText: "dark5", author: "1",category: "W"),
    .init(title: "f", imageText: "dark6", author: "1",category: "W"),
    .init(title: "b", imageText: "dark2", author: "1",category: "W"),
    .init(title: "d", imageText: "dark4", author: "1",category: "W"),
    .init(title: "e", imageText: "dark5", author: "1",category: "W"),
    .init(title: "f", imageText: "dark6", author: "1",category: "W"),
    .init(title: "b", imageText: "dark2", author: "1",category: "W")
]
