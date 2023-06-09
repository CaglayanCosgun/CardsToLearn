//
//  HeaderView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    
    @Binding var isPresentingCardCreateView: Bool
    @Binding var startAnimation: Bool 
    
    var body: some View {
       
        
        HStack{
            Text("My Cards")
                .font(.title.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .opacity(startAnimation ? 1 : 0)
                .offset(x: startAnimation ? 0 : 100)
                .animation(.interactiveSpring(response: 1,dampingFraction: 1,blendDuration: 1).delay(0.9), value: startAnimation)
            
            Button {
                isPresentingCardCreateView.toggle()
            }label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(Color("Gray"))
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 14,style: .continuous)
                            .fill(.white)
                    }
            }
            .sheet(isPresented: $isPresentingCardCreateView, content: {
                CardCreateView(viewModel: viewModel)
            })
            .scaleEffect(startAnimation ? 1 : 0.001)
            .animation(.interactiveSpring(response: 1,dampingFraction: 0.6,blendDuration: 0.7).delay(0.7), value: startAnimation)
        }
    
    }
}

