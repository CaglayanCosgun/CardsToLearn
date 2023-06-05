//
//  SideHomeTabButton.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct SideHomeTabButton: View {
    
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button{
            withAnimation(.spring()){selectedTab = title}
        }label: {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("gray2") : .white)
            .padding(.vertical,12)
            .padding(.horizontal,10)
            .frame(maxWidth: getRectSide().width - 170, alignment: .leading)
            .background(
            
                ZStack{
                    if selectedTab == title {
                        Color.white.opacity(selectedTab == title ? 1 : 0)
                            .clipShape(SideCustomCorner(corners: [.topRight, .bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        }
    }
}

struct SideHomeTabButton_Previews: PreviewProvider {
    static var previews: some View {
        SideHomeMenu()
    }
}
