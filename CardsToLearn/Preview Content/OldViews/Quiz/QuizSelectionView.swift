//
//  QuizSelectionView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct QuizSelectionView: View {
    var flashcards: [Card]
    @State private var animate = false
    @State var selectedCard : Card?
    @State var isActive = false
    
    var body: some View {
        
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    HStack {
                        Text("Choose a Quiz")
                            .font(.system(size: 50, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : -100, y: animate ? 0 : 20)
                            .animation(Animation.easeInOut(duration: 1.5).delay(1.5))
                        
                        Image(systemName: "pencil")
                            .font(.system(size: 60, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .offset(y: animate ? -20 : 0)
                            .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true))
                            .onAppear() {
                                self.animate = true
                            }
                    }
                    
                    VStack(spacing: 20) { // Add another VStack for the navigation links
                        NavigationLink(destination: QuizApiView()) {
                            Text("API Quiz")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 50)
                                .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                                .cornerRadius(25)
                                .shadow(color: .white, radius: 5, x: 0, y: 5)
                                .scaleEffect(animate ? 1.05 : 1)
                                .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.5))
                                .onAppear() {
                                    self.animate = true
                                }
                        }
                        
                        NavigationLink(destination: QuizCreationView(rootIsActive: self.$isActive),
                                       isActive: self.$isActive) {
                            Text("Create a Quiz")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 50)
                                .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                                .cornerRadius(25)
                                .shadow(color: .white, radius: 5, x: 0, y: 5)
                                .scaleEffect(animate ? 1.05 : 1)
                                .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.7))
                                .onAppear() {
                                    self.animate = true
                                }
                        }
                                       .isDetailLink(false)
                        
                        NavigationLink(
                            destination: QuizSettingsView(selectedCard: $selectedCard, cards: flashcards)
                        ) {
                            Text("Flashcards Quiz")
                            
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 50)
                                .background(Color(red: 192/255, green: 192/255, blue: 192/255))
                                .cornerRadius(25)
                                .shadow(color: .white, radius: 5, x: 0, y: 5)
                                .scaleEffect(animate ? 1.05 : 1)
                                .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.9))
                                .onAppear() {
                                    self.animate = true
                                }
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .navigationBarTitle("Quiz Selection")
        
    }
}
