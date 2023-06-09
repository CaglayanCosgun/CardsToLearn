//
//  Itemview.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.06.23.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    
    var body: some View {
        
        VStack{
            
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300,height: 300)
        }
        .background(Color(item.image))
        .cornerRadius(35)
    }
}

struct Item: Identifiable {
    var id = UUID().uuidString
    var image: String
}

var items = [
    
    Item(image: "quiz1"),
    Item(image: "quiz2"),
    Item(image: "quiz3")
]


