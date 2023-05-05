//
//  CardListView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI


struct CardListView: View {
    let cards: [Card]
    @Binding var selectedCard: Card?
    @ObservedObject var viewModel: CardViewModel
    
    @State private var isRectangular = false
    
    private var categories: [String] {
        Array(Set(cards.compactMap { $0.category })).sorted()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            List {
                ForEach(categories, id: \.self) { category in
                    Section(header: Text(category)) {
                        ForEach(filteredCards(forCategory: category)) { card in
                            NavigationLink(destination: CardDetailView(card: card), tag: card, selection: $selectedCard) {
                                if isRectangular {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(height: 100)
                                        .overlay(
                                            VStack(alignment: .leading) {
                                                Text(card.question ?? "")
                                                Text(card.answer ?? "")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            .padding()
                                        )
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                } else {
                                    VStack(alignment: .leading) {
                                        Text(card.question ?? "")
                                        Text(card.answer ?? "")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteCard)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isRectangular.toggle()
                    }) {
                        Image(systemName: isRectangular ? "rectangle.grid.1x2.fill" : "rectangle.grid.2x2.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    private func filteredCards(forCategory category: String) -> [Card] {
        cards.filter { $0.category == category }
            .sorted { $0.question?.localizedCaseInsensitiveCompare($1.question ?? "") == .orderedAscending }
    }
}

    


