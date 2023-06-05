//
//  QuotesView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 30.05.23.
//

import SwiftUI

struct QuotesView: View {
    @EnvironmentObject var quotesVM: ApiQuotesViewModel
    @State private var searchCategory: String = ""
    @State private var showMenu: Bool = false
    @State private var textOffset: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "info.bubble")
                            .font(.title)
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                            if showMenu {
                                textOffset = 0
                            }
                        }
                    }
                    
                    Text("Quotes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.top)
                
                HStack {
                    TextField("Enter a category", text: $searchCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Search") {
                        quotesVM.fetchQuote(category: searchCategory)
                    }
                    .disabled(searchCategory.isEmpty)
                    .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                if !quotesVM.quotes.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(quotesVM.quotes, id: \.self) { quote in
                                VStack(spacing: 8) {
                                    Text(quote.quote)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                    
                                    Text("- \(quote.author)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 3, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    Text("Quotes not available")
                        .font(.body)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            
            if showMenu {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                            if !showMenu {
                                textOffset = UIScreen.main.bounds.width
                            }
                        }
                    }
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("Nur diese Kategorien sind zur Suche verfügbar")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(x: textOffset)
                            .onAppear {
                                if showMenu {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        textOffset = 0
                                    }
                                }
                            }
                        
                        ScrollView {
                            VStack(spacing: 8) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .offset(x: textOffset)
                                        .onAppear {
                                            if showMenu {
                                                withAnimation(.easeOut(duration: 0.5)) {
                                                    textOffset = 0
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .transition(.move(edge: .trailing))
                }
            }
        }
        .onAppear {
            quotesVM.fetchQuote(category: "happiness")
        }
    }
    
    let categories = [
        "age", "alone", "amazing", "anger", "architecture", "art", "attitude", "beauty", "best",
        "birthday", "business", "car", "change", "communications", "computers", "cool", "courage",
        "dad", "dating", "death", "design", "dreams", "education", "environmental", "equality",
        "experience", "failure", "faith", "family", "famous", "fear", "fitness", "food", "forgiveness",
        "freedom", "friendship", "funny", "future", "god", "good", "government", "graduation", "great",
        "happiness", "health", "history", "home", "hope", "humor", "imagination", "inspirational",
        "intelligence", "jealousy", "knowledge", "leadership", "learning", "legal", "life", "love",
        "marriage", "medical", "men", "mom", "money", "morning", "movies", "success"
    ]
}
