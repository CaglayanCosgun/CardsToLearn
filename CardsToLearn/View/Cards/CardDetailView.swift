//
//  CardDetailView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    @State private var showingQuestion = true
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
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
    
}

