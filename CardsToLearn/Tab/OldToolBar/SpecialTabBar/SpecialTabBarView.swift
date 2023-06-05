//
//  SpecialToolBarView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import Foundation
import SwiftUI

struct SpecialTabBarView: View {
    @State private var activeTab: SpecialTabBar = .home
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    @State var selectedCard: Card?
    @State var selectedCategory: String?

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                NotesView()
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("Notes")
                    }
                    .tag(SpecialTabBar.home)

                QuotesView()
                    .environmentObject(quotesViewModel)
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "quote.bubble")
                        Text("Quotes")
                    }
                    .tag(SpecialTabBar.quotes)

                VStack {
                    Picker("Select category", selection: $selectedCategory) {
                        Text("All categories")
                        ForEach(viewModel.categories.sorted(), id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)

                    CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                }
                .navigationBarTitle("Flashcards")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Cards")
                }
                .tag(SpecialTabBar.cards)

                QuizSelectionView(flashcards: viewModel.cards)
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "questionmark.circle")
                        Text("Quiz")
                    }
                    .tag(SpecialTabBar.quiz)

                ProfileView()
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(SpecialTabBar.profile)
            }
            
            SpecialCustomTabBar(activeTab: $activeTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color("Black"))
                .ignoresSafeArea()
        }
    }
}


struct SpecialTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTabBarView()
    }
}

