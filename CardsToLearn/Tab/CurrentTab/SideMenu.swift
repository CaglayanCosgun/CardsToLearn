//
//  SideMenu.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.06.23.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var selectedTab: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15,content: {
            Image("splashlogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(.top,50)
            
            VStack(alignment: .leading,spacing: nil, content: {
                Text("CardsToLearn")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Button(action: {
                    selectedTab = "Profil"
                }) {
                    Text("View Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }

            })
            VStack(alignment: .leading,spacing: 10){
                SideHomeTabButton(image: "house", title: "Home", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "note", title: "Note", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "ellipsis.bubble", title: "Quotes", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "square.grid.2x2", title: "Cards", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "gamecontroller", title: "Quiz", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "lightbulb", title: "Tips", selectedTab: $selectedTab,animation: animation)
                SideHomeTabButton(image: "beach.umbrella", title: "Relax", selectedTab: $selectedTab,animation: animation)
                
            }
            .padding(.leading, -15)
            .padding(.top,50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6,content: {
                
                SideHomeTabButton(image: "rectangle.portrait.and.arrow.right", title: "Logout", selectedTab: .constant(""),animation: animation)
                    .padding(.leading,-15)
            })
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading )
    }

}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideHomeMenu()
    }
}
