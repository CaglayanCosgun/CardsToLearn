//
//  ApiQuizView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.06.23.
//

import SwiftUI
import CoreData

struct ApiQuizView: View {
    @State var currentRules: Rules = sampleRules.first!
    @EnvironmentObject var viewModel: ApiCallViewModel
    @State private var startQuiz: Bool = false
    
    var body: some View {
        
        
            VStack(alignment: .leading, spacing: 15){
                Text("Welcome to the english quiz")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom,12)
                
                CustomLabel("list.bullet.rectangle.portrait", "20", "Random Multiple Choice Questions")
                    .padding(.top,20)
                
                Divider()
                    .padding(.horizontal,-15)
                    .padding(.top,15)
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Before you start")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom,12)
                }
                
                ForEach(sampleRules){rule in
                    HStack(alignment: .top,spacing: 10){
                        Circle()
                            .fill(.black)
                            .frame(width: 8,height: 8)
                        Text(rule.rule)
                            .font(.callout)
                            .lineLimit(3)
                    }
                }
                
                Button{
                    startQuiz.toggle()
                }label: {
                    Text("Start Quiz")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hAlign(.center)
                        .padding(.top,15)
                        .padding(.bottom,10)
                        .foregroundColor(.white)
                        .background{
                            
                            Rectangle()
                                .fill(Color("gray2"))
                                .ignoresSafeArea()
                        }
                }
                .padding([.bottom,.horizontal],-15)
                .vAlign(.bottom)
            }
            .padding(15)
            .vAlign(.top)
            .fullScreenCover(isPresented: $startQuiz){
                
                NavigationView{
                    QuizApiView()
                }
            }
    }
    
    
    
    @ViewBuilder
    func CustomLabel(_ image: String,_ title: String,_ subTitle: String)->some View{
        
        HStack(spacing: 12){
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45,height: 45)
                .background{
                    
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .padding(-1)
                        .background{
                            Circle()
                                .stroke(Color("gray1"),lineWidth: 1)
                        }
                }
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("gray1"))
                
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .hAlign(.leading)
        }
    }
}

struct ApiQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ApiQuizView()
    }
}


extension View{
    
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity,alignment: alignment)
    }
}

struct QuestionView: View{
    
    @EnvironmentObject var viewModel: ApiCallViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var showNextCard: Bool = false
    
    var body: some View{
        
        VStack(spacing: 15){
            
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hAlign(.leading)
            
            GeometryReader{
                
                let size = $0.size
                
                ZStack(alignment: .leading){
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    
                    Rectangle()
                        .fill(.green)
                        .frame(width: progress * size.width,alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 20)
            .padding(.top,5)
            
            GeometryReader{
                
                let size = $0.size
                
                ForEach(viewModel.quizzes.indices,id:\.self){ index in
                    
                    if currentIndex == index{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
            .padding(.vertical,15)
            
           
        }
        .padding(15)
        .hAlign(.center).vAlign(.top)
        .background{
            
            Color("gray2")
                .ignoresSafeArea()
        }
        .environment(\.colorScheme, .dark)
    }
}


