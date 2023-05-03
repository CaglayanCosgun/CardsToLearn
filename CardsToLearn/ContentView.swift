//
//  ContentView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject var viewModel = CardViewModel()
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?
    @State var showSplashScreen = true // Zustand für Anzeige des Splashscreens
    
    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Den SplashScreen für 2 Sekunden anzeigen
                            withAnimation {
                                showSplashScreen = false // Die Zustandsvariable ändern, um den SplashScreen auszublenden
                            }
                        }
                    }
            } else {
                TabView {
                    NavigationView {
                        VStack {
                            Picker("Select category", selection: $selectedCategory) {
                                Text("All categories").tag(nil as String?)
                                ForEach(viewModel.categories.sorted(), id: \.self) { category in
                                    Text(category).tag(category as String?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)

                            CardListView(cards: viewModel.filteredCards(forCategory: selectedCategory), selectedCard: $selectedCard,viewModel: viewModel)
                        }
                        .navigationBarTitle("Flashcards")
                        .navigationBarItems(trailing:
                                                Button(action: {
                            isPresentingCardCreateView.toggle()
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                        )
                    }
                    .tabItem {
                        Label("Cards", systemImage: "square.grid.2x2")
                    }

                    if let card = selectedCard {
                        CardDetailView(card: card)
                            .tabItem {
                                Label("Card Detail", systemImage: "info.circle")
                            }
                    } else {
                        Text("No card selected")
                            .tabItem {
                                Label("Card Detail", systemImage: "info.circle")
                            }
                    }

                    NavigationView {
                        QuizSelectionView(flashcards: viewModel.cards)
                    }
                    .tabItem {
                        Label("Quiz", systemImage: "gamecontroller")
                    }

                    Text("Profile")
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                }
                .sheet(isPresented: $isPresentingCardCreateView, content: {
                    CardCreateView(viewModel: viewModel)
                })
            }
        }
    }
}
