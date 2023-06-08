//
//  BaseView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.06.23.
//

import SwiftUI

struct BaseView: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    
    
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?
    
    @State var showMenu: Bool = false
    
    @GestureState var gestureOffset: CGFloat = 0
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "Home"
    
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View {
        
        let sideBarWidth = getRectBase().width - 90
        
        NavigationView {
            HStack(spacing: 0){
                
                SideBaseMenu(showMenu: $showMenu)
                
                VStack(spacing: 0){
                    
                    TabView(selection: $currentTab){
                        
                        BaseHome(showMenu: $showMenu)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Home")
                        
                        MyCardsSideBar()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Quotes")
                        
//                            CardListView(selectedCard: $selectedCard, viewModel: viewModel)
                        HomeCard(selectedCard: $selectedCard, viewModel: viewModel)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarHidden(true)
                                .tag("Cards")
                        
                        
                        QuizSelectionView(flashcards: viewModel.cards)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Quiz")
                    }
                    VStack(spacing: 0){
                        
                        Divider()
                        
                        HStack(spacing: 0){
                            SideBaseTabButton(image: "Home")
                            
                            SideBaseTabButton(image: "Quotes")
                            
                            SideBaseTabButton(image: "Cards")
                            
                            SideBaseTabButton(image: "Quiz")
                            
                        }
                        .padding([.top],15)
                    }
                }
                .frame(width: getRectBase().width)
                .overlay(
                
                Rectangle()
                    .fill(
                    
                        Color.primary
                            .opacity(Double((offset / sideBarWidth) / 5))
                            
                    )
                    .ignoresSafeArea(.container,edges: .vertical)
                    .onTapGesture {
                        withAnimation{
                            showMenu.toggle()
                        }
                    }
                    
                )
                
            }
            .frame(width: getRectBase().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            .gesture(
                
                DragGesture()
                    .updating($gestureOffset, body: {value, out, _ in out = value.translation.width
                        
                    })
                    .onEnded(onEnd(value: ))
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu){newValue in
            if showMenu && offset == 0{
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            if !showMenu && offset == sideBarWidth{
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset){ newValue in
            onChange()
        }
    }
    
    func onChange(){
        let sideBarWidth = getRectBase().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    
    func onEnd(value: DragGesture.Value){
        
        let sideBarWidth = getRectBase().width - 90
        
        let translation = value.translation.width
        
        withAnimation{
            
            if translation > 0{
                
                if translation > (sideBarWidth / 2){
                    offset = sideBarWidth
                    showMenu = true
                }
                else{
                    
                    if offset == sideBarWidth{
                        return
                    }
                    
                    offset = 0
                    showMenu = false
                }
            }
            else{
                if -translation > (sideBarWidth / 2){
                    offset = 0
                    showMenu = false
                }
                else{
                    if offset == 0 || !showMenu{
                        return
                    }
                    
                    offset = sideBarWidth
                    showMenu = true
                }
            }
        }
        
        lastStoredOffset = offset
    }
    
    @ViewBuilder
    func SideBaseTabButton(image: String)->some View{
        
        Button{
            withAnimation{currentTab = image}
        }label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 23,height: 22)
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
