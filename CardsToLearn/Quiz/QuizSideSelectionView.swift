//
//  QuizSideSelectionView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.06.23.
//

import SwiftUI

struct QuizSideSelectionView: View {
    @State var midY: CGFloat = 0
    @State var selected = "Card Quiz"
    
    var tabs = ["Card Quiz", "Creat Quiz", "Api Quiz"]
    
    var flashcards: [Card]
    @State private var animate = false
    @State var selectedCard: Card?
   
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                VStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer(minLength: 0)
                    
                    ForEach(tabs, id: \.self) { name in
                        ZStack {
                            Circle()
                                .fill(Color("gray3"))
                                .frame(width: 13, height: 13)
                                .offset(x: selected == name ? 28 : -80)
                            
                            Color("gray2")
                                .frame(width: 150, height: 110)
                                .rotationEffect(.init(degrees: -90))
                                .offset(x: -50)
                            
                            GeometryReader { reader in
                                NavigationLink(destination: destinationView(for: name)) {
                                    Text(name)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                }
                                .frame(width: 150, height: 110)
                                .rotationEffect(.init(degrees: -90))
                                .onAppear {
                                    if name == tabs.first {
                                        midY = reader.frame(in: .global).midY
                                    }
                                }
                                .offset(x: -8)
                            }
                        }
                        .frame(width: 150, height: 110)
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(width: 70)
                .background(
                    Color("gray2")
                        .clipShape(Curve(midY: midY))
                        .ignoresSafeArea()
                )
                
                VStack {
                    HStack {
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "gamecontroller.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Quiz Selection")
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 25) {
                            ForEach(items) { item in
                                ItemView(item: item)
                            }
                        }
                        .padding()
                        .padding(.top)
                    }
                }
                .padding(.leading)
                
                Spacer()
            }
        }
    }
    
    func destinationView(for tab: String) -> AnyView {
        switch tab {
        case "Card Quiz":
            return AnyView(QuizSettingsView(selectedCard: $selectedCard, cards: flashcards))
        case "Creat Quiz":
            return AnyView(QuizCreationView())
        case "Api Quiz":
            return AnyView(ApiQuizView())
        default:
            return AnyView(EmptyView())
        }
    }
}

struct Curve: Shape{
    
    var midY: CGFloat
    
    var animatableData: CGFloat{
        
        get{return midY}
        
        set{midY = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            
            
            let width = rect.width
            
            path.move(to: CGPoint(x: width, y: midY - 40))
            
            let to = CGPoint(x: width - 25, y: midY)
            
            let control1 = CGPoint(x: width, y: midY - 20)
            let control2 = CGPoint(x: width - 25, y: midY - 20)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: width, y: midY + 40)
            
            let control3 = CGPoint(x: width - 25, y: midY + 20)
            let control4 = CGPoint(x: width, y: midY + 20)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
        
    }
}

//struct QuizSideSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizSideSelectionView()
//    }
//}
