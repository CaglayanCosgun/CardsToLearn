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
    private func filteredCards(forCategory category: String) -> [Card] {
        cards.filter { $0.category == category }
            .sorted { $0.question?.localizedCaseInsensitiveCompare($1.question ?? "") == .orderedAscending }
    }
}



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


struct CardDetailView: View {
    let card: Card
    @State private var showingQuestion = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if showingQuestion {
                VStack(alignment: .center, spacing: 10) {
                    Text("Question:")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ShimmeringText(text: card.question ?? "")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(width: 400, height: 300)
                .background(Color.yellow)
                .cornerRadius(10)
            } else {
                VStack(alignment: .center, spacing: 10) {
                    Text("Answer:")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ShimmeringText(text: card.answer ?? "")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(width: 400, height: 300)
                .background(Color(red: 255/255, green: 215/255, blue: 0/255))
                .cornerRadius(10)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(showingQuestion ? "Show Answer" : "Show Question") {
                    showingQuestion.toggle()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text(card.category ?? "")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .lineLimit(1)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
    }
}




struct ShimmeringText: View {
    let text: String
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.clear, .white, .clear]), startPoint: .leading, endPoint: .trailing)
                .frame(width: 200, height: 50)
                .rotationEffect(.degrees(70))
                .offset(x: isAnimating ? 150 : -50, y: 0)
                .opacity(isAnimating ? 1.0 : 0.2)
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
                .opacity(isAnimating ? 0.2 : 1.0)
        }
        .onAppear() {
            withAnimation(Animation.linear(duration: 2.0)) {
                self.isAnimating = true
            }
        }
        .onDisappear() {
            self.isAnimating = false
        }
    }
}
