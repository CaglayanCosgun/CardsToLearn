//
//  HomeCard.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI

struct HomeCard: View {
    
    
    @Binding var selectedCard: Card? // Die ausgewählte Karte
    @ObservedObject var viewModel: CardViewModel // Das ViewModel, welches die Logik enthält
    @State private var isRectangular = false // Ein interner Zustand, um zwischen rechteckigen und normalen Karten zu wechseln
    @State private var currentIndex = 0
    @State var isPresentingCardCreateView = false
    
    @State var isShowing: Bool = false
    
    private var categories: [String] { // Eine berechnete Eigenschaft, um eine Liste der Kategorien zu erhalten
        Array(Set(viewModel.cards.compactMap { $0.category })).sorted() // Durchlaufen Sie die Liste der Karten, um alle Kategorien zu erhalten, entfernen Sie dann alle nils, und sortieren Sie die Kategorien alphabetisch.
    }
    
    
    @State var startAnimation: Bool = false
    @State var animateContent: Bool = false
    @State var animateText: [Bool] = [false,false]
    @State var backgroundWidth: CGFloat? = 60
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(spacing: 15){
                    
                    HeaderView(isPresentingCardCreateView: $isPresentingCardCreateView, startAnimation: $startAnimation)
                    
                    
                    if isShowing{
                        ForEach(categories, id:\.self){ category in
                            
                            Section(header: Text(category)) {
                                ForEach(filteredCards(forCategory: category)) {card in
                                    NavigationLink(destination: CardAnimateView(card: card), tag: card, selection: $selectedCard){
                                        CardView(card: card)
                                        //                                        .zIndex(1)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
            }
        
            
                
                .padding(15)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .background{
                    Color("Gray")
                        .frame(width: backgroundWidth)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .ignoresSafeArea()
                }
                .overlay(alignment: .trailing, content: {
                    HStack(spacing: 10){
                        Text("My Cards")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 19))
                    .fontWeight(.semibold)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isShowing.toggle()
                        animatePage()
                    }
                    .rotationEffect(.init(degrees: -90))
                    .offset(x: startAnimation ? 120 : 22)
                    .opacity(startAnimation ? 0 : 1)
                })
                .background{
                    Color.white
                        .ignoresSafeArea()
                }
           
            
        }
       
    }
    func animatePage(){
        withAnimation(.easeInOut(duration: 0.4)){
            backgroundWidth = 40
        }
        withAnimation(.interactiveSpring(response: 1.1,dampingFraction: 0.75,blendDuration: 0).delay(0.3)){
            backgroundWidth = nil
            startAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15){
            animateText[0] = true
            animateText[1] = true
        }
    }
    
     func filteredCards(forCategory category: String) -> [Card] {
        viewModel.cards.filter { $0.category == category }
            .sorted { $0.question?.localizedCaseInsensitiveCompare($1.question ?? "") == .orderedAscending }
       
        
    }
    
    
    @ViewBuilder
    func DetailCardView()->some View{
        VStack(alignment: .leading,spacing: 12){
            Text(Date().formatted(date: .abbreviated, time: .omitted))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            HStack{
                Button{
                    
                }label: {
                    Text("Category")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background{
                            Capsule()
                                .stroke(.white,lineWidth: 1)
                        }
                }
                Button{
                    
                }label: {
                    Text("Sport")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,12)
        }
        .padding(15)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
        .padding(.vertical,10)
        .rotation3DEffect(.init(degrees: startAnimation ? 0 : 30), axis: (x: 1, y: 0, z: 0))
        .offset(y: startAnimation ? 0 : -200)
        .opacity(startAnimation ? 1 : 0)
        .animation(.interactiveSpring(response: 1,dampingFraction: 0.9,blendDuration: 1).delay(1.2), value: startAnimation)
    }
    
    
    
    @ViewBuilder
    //Im Parameter in einer View als variable geben
    func CardView(cardColor: Color = .white,cardNumber: String = "1",cardIndex: CGFloat = 0,card: Card)->some View{
        
        let extraDelay: CGFloat = (cardIndex / 3.5)
        
        VStack(alignment: .leading,spacing: 5){
            Image("splashlogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45,height: 45)
                .cornerRadius(10)
                .offset(x: startAnimation ? 0 : 15,y: startAnimation ? 0 : 15)
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeInOut(duration: 1).delay(1 + extraDelay), value: startAnimation)
            
            HStack(spacing: 4){
                Text("Q:")
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(Color("Gray"))
                    .offset(x: startAnimation ? 0 : 15,y: startAnimation ? 0 : 15)
                    .opacity(startAnimation ? 1 : 0)
                    .animation(.easeInOut(duration: 1).delay(1), value: startAnimation)
                
                Text(card.question ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .offset(x: startAnimation ? 0 : 15,y: startAnimation ? 0 : 15)
                    .opacity(startAnimation ? 1 : 0)
                    .animation(.easeInOut(duration: 1).delay(1), value: startAnimation)
                
                
                
            }
            .opacity(startAnimation ? 1 : 0)
            .animation(.easeInOut(duration: 1).delay(1.2 + extraDelay), value: startAnimation)
            .frame(maxWidth: .infinity,alignment: .leading)
            .overlay(alignment: .trailing){
                CVVView()
                    .opacity(startAnimation ? 1 : 0)
                    .offset(y: startAnimation ? 0 : 70)
                    .animation(.interactiveSpring(response: 1,dampingFraction: 1,blendDuration: 1).delay(1.5), value: startAnimation)
            }
            
            Text("A:")
                .fontWeight(.semibold)
                .foregroundColor(Color("Gray"))
                .opacity(startAnimation ? 1 : 0)
                .offset(x: startAnimation ? 0 : 70)
                .animation(.easeInOut(duration: 0.8).speed(0.7).delay(1.7 + extraDelay),value: startAnimation)
            
            Text(card.answer ?? "")
                .font(.headline)
                .fontWeight(.semibold)
                .opacity(startAnimation ? 1 : 0)
                .offset(x: startAnimation ? 0 : 70)
                .animation(.easeInOut(duration: 0.8).speed(0.6).delay(1.7),value: startAnimation)
            
            
            Text("CardNr: \(cardNumber)")
                .font(.headline)
                .fontWeight(.semibold)
                .opacity(startAnimation ? 1 : 0)
                .offset(x: startAnimation ? 0 : 70)
                .animation(.easeInOut(duration: 0.8).speed(0.8).delay(1.7 + extraDelay),value: startAnimation)
            
            
        }
        .opacity(startAnimation ? 1 : 0)
        .offset(y: startAnimation ? 0 : 70)
        .animation(.interactiveSpring(response: 1,dampingFraction: 1,blendDuration: 1).delay(1.6), value: startAnimation)
        
        .foregroundColor(.black)
        .padding(15)
        .padding(.horizontal,10)
        .frame(maxWidth: .infinity)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
        .rotation3DEffect(.init(degrees: startAnimation ? 0 : -70), axis: (x: 1, y: 0, z: 0),anchor: .center)
        .scaleEffect(startAnimation ? 1 : 0.001, anchor: .bottom)
        .animation(.interactiveSpring(response: 1,dampingFraction: 0.7,blendDuration: 1).delay(0.9 + extraDelay),value: startAnimation)
    }
    
    
    @ViewBuilder
    func CVVView()->some View{
        HStack(spacing: 5){
            ForEach(1...3,id: \.self){_ in
                Circle().frame(width: 8,height: 8)
            }
        }
        .padding(.trailing,8)
    }
    
}
