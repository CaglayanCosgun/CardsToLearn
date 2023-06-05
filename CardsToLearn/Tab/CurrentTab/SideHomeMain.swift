//
//  SideHomeMain.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.06.23.
//

import SwiftUI

struct SideHomeMain: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    @EnvironmentObject var notesViewModel: NoteViewModel
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?
    
    
    @Binding var selectedTab: String
    
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeSideView()
                .tag("Home")
            
            NotesView()
                .tag("Note")
            
            QuotesView()
                .tag("Quotes")
            
            CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                .tag("Cards")
            
            QuizSelectionView(flashcards: viewModel.cards)
                .tag("Quiz")
            
            LearningTipsView()
                .tag("Tips")
            
            Relax()
                .tag("Relax")
            
            ProfileView()
                .tag("Profil")
            
        }
    }
}

