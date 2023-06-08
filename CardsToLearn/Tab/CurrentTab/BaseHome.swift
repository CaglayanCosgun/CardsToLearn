//
//  BaseHome.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.06.23.
//

import SwiftUI

struct BaseHome: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack{
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Button{
                        withAnimation{showMenu.toggle()}
                    }label: {
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35,height: 35)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    NavigationLink{
                        
                        Home()
                            .navigationTitle("Notes")
                        
                    }label: {
                        Image(systemName: "note")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22,height: 22)
                            .foregroundColor(.primary)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                Divider()
                
            }
            .overlay(
            
            Image("splashlogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
            )
            
            Spacer()
            
        }
    }
}

