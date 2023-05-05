//
//  CategoryHeaderView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct CategoryHeaderView: View {
    let category: String

    var body: some View {
        
        HStack {
            Text(category)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .onTapGesture {
            // TODO: Show all cards for the selected category
        }
    }
}
