//
//  LastQuizView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 12.06.23.
//

import SwiftUI
import CoreData

struct LastQuizView: View {
    @EnvironmentObject var quizVM: QuizViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    // Handle left button action
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.6), lineWidth: 1)
                        )
                }
                
                Spacer()
                
                Button {
                    // Handle skip button action
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
            }
            .overlay(
                HStack(spacing: 4) {
                    // Add overlay content here if needed
                }
                
            )
            .padding()
            
            ScrollView(getRectLast().height < 750 ? .vertical : .init(), showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    
                    Text("Your last \nplayed Quiz")
                        .font(.system(size: 38, weight: .bold))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .foregroundColor(.white)
                    
                    if let lastPlayedQuiz = quizVM.quizzes.last {
                        InfiniteCarouselQuizView(quiz: lastPlayedQuiz)
                        }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            
            HStack {
                Text("Quiz")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    // Handle right button action
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(.top, 25)
            .padding(.horizontal, 30)
            .padding(.bottom, 12)
            .background(
                Color.black
                    .clipShape(CustomCornerLast(corners: [.topLeft, .topRight], radius: 38))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [
                Color("gray3"),
                Color("gray2"),
                Color("gray1"),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        )
    }
}


struct InfiniteCarouselQuizView: View{
    
    let quiz: Quiz
    
    
    var body: some View{
        
        VStack(spacing: 18){
            
            Text("Zuletzt gespieltes Quiz:")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            Text(quiz.quizTitle ?? "")
                .fontWeight(.bold)
                .font(.largeTitle)
                .foregroundColor(Color.black.opacity(0.6))
                
        
            
            Spacer()
            
            Image(systemName: "checkmark.circle")
                .font(.system(size: 75,weight: .light))
                .foregroundColor(.green)
                .padding(.bottom)
            
            Spacer()
            
        }
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.horizontal,50)
    }
}
