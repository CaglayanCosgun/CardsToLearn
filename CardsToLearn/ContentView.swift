//
//  ContentView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct ContentView: View {
    @StateObject var viewModel = CardViewModel()
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?
    @State var showSplashScreen = true // Zustand für Anzeige des Splashscreens
    @State var isLoggedIn = false // Zustand für Überprüfung der Anmeldung
    
    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Den SplashScreen für 2 Sekunden anzeigen
                            withAnimation {
                                showSplashScreen = false // Die Zustandsvariable ändern, um den SplashScreen auszublenden
                                isLoggedIn = true // Setze isLoggedIn auf true, um zur Anmeldeansicht zu wechseln
                            }
                        }
                    }
            } else if isLoggedIn {
                LoginView()
                 
             }else {
                TabView {
                    NavigationView {
                        VStack {
                            Picker("Select category", selection: $selectedCategory) {
                                Text("All categories")
                                ForEach(viewModel.categories.sorted(), id: \.self) { category in
                                    Text(category)
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
                    
                    NavigationView {
                        ProfileView()
                    }
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    
                    NavigationView {
                        HomeView()
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    
                }
                .sheet(isPresented: $isPresentingCardCreateView, content: {
                    CardCreateView(viewModel: viewModel)
                })
            }
        }
    }
}




struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var vocabulary = [Date: String]() // Vokabeln für jeden ausgewählten Tag
    
    var body: some View {
        VStack {
            CalendarView(selectedDate: $selectedDate)
                .frame(height: 200)
            
            Spacer()
            
            VocabularyView(selectedDate: selectedDate, vocabulary: $vocabulary)
                .background(Color.gray.opacity(0.1))
                .padding()
                .cornerRadius(10)
        }
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Text("Kalender")
                .font(.title)
            
            DatePicker(
                selection: $selectedDate,
                displayedComponents: [.date],
                label: { Text("") }
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
        }
    }
}

struct VocabularyView: View {
    var selectedDate: Date
    @Binding var vocabulary: [Date: String]
    
    var body: some View {
        VStack {
            Text("Vokabeln")
                .font(.title)
            
            if let vocab = vocabulary[selectedDate] {
                Text(vocab)
                    .padding()
                    .background(Color.white)
                    .border(Color.gray, width: 1)
                    .cornerRadius(5)
            } else {
                Text("Keine Vokabel für diesen Tag")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}
