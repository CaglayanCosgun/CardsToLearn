//
//  CustomSlideTabView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct CustomSlideTabView: View {
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    @EnvironmentObject var noteViewModel: NoteViewModel
    @State var selectedCategory: String?
    @State var selectedCard: Card?
    
    @Binding var currentTab: String
    @Binding var showMenu: Bool
    
    
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation(.spring()) {
                        showMenu = true
                    }
                }label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title)
                        .foregroundColor(.white)
                        
                }
                .opacity(showMenu ? 0 : 1)
                
                Spacer()
                
                Button {
                    
                }label: {
                    Image("splashlogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .cornerRadius(5)
                }
            }
            .overlay(
            Text(currentTab)
                .font(.title2.bold())
                .foregroundColor(.white)
                .opacity(showMenu ? 0 : 1)
            )
            .padding([.horizontal, .top])
            .padding(.bottom,8)
            .padding(.top,getSafeAreaSlide().top)
            TabView(selection: $currentTab) {
                HomeSideView()
                    .tag("Home")
                
                NotesView()
                    .tag("Note")
                
                QuotesView()
                    .tag("Quotes")
                
                CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                    .tag("Card")
                
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            
            Button {
                withAnimation(.spring()) {
                    showMenu = false
                }
            }label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
                    
            }
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top)
            ,alignment: .topLeading
        )
        .background(
            Color.black
        )
    }
}

struct CustomSlideTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlideOutView()
    }
}
