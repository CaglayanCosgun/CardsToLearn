//
//  SlideMenu.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import Foundation
import SwiftUI

struct SlideMenu: View {
    
    
    @Binding var currentTab: String
    
    @Namespace var animation
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image("splashlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45,height: 45)
                    .clipShape(Circle())
                    .cornerRadius(15)
                
                Text("CardsToLearn")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    
            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(getRectSlide().height < 750 ? .vertical : .init(),showsIndicators: false,content: {
                
                VStack(alignment: .leading, spacing: 25) {
                    CustomTabButton(icon: "house", title: "Home")
                    CustomTabButton(icon: "note", title: "Note")
                    CustomTabButton(icon: "ellipsis.bubble", title: "Quotes")
                    CustomTabButton(icon: "square.grid.2x2", title: "Cards")
                    CustomTabButton(icon: "gamecontroller", title: "Quiz")
                    CustomTabButton(icon: "lightbulb", title: "Tips")
                    CustomTabButton(icon: "beach.umbrella", title: "Relax")
                    CustomTabButton(icon: "person", title: "Profile")
                    
                    Spacer()
                    
                    CustomTabButton(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
                }
                .padding()
                .padding(.top,45)
                
            })
            .frame(width: getRectSlide().width / 2,alignment: .leading)
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding(.leading,10)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(
            Color("gray1")
        )
    }
    
    @ViewBuilder
    func CustomTabButton(icon: String, title: String)-> some View {
        
        Button{
            if title == "Logout"{
                
            }
            else{
                withAnimation {
                    currentTab = title
                }
            }
        }label: {
            HStack(spacing: 12){
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab == title ? 48 : nil, height: 48)
                    .foregroundColor(currentTab == title ?  Color("gray") : (title == "Logout" ? Color("Orange") : .white))
                    .background(
                        ZStack {
                            if currentTab == title {
                                Color.white.clipShape(Circle())
                                    .matchedGeometryEffect(id: "TABCIRCLE", in: animation)
                            }
                        }
                    )
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(title == "Logout" ? Color("Orange") : .white)
                
            }
            .padding(.trailing,18)
            .background(
                ZStack{
                    if currentTab == title {
                        Color("color2")
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "TABCAPSULE", in: animation)
                    }
                }
            )
        }
        .offset(x: currentTab == title ? 15 : 0)
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideOutView()
    }
}


extension View {
    func getRectSlide()->CGRect{
        return UIScreen.main.bounds
    }
}
