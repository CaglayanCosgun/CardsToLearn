//
//  SlideOutView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct SlideOutView: View {
    
    @State var currentTab: String = "Home"
    
    @State var showMenu: Bool = false
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            SlideMenu(currentTab: $currentTab)
                
            
            CustomSlideTabView(currentTab: $currentTab,showMenu: $showMenu)
                .cornerRadius(showMenu ? 25 : 0)
                .rotation3DEffect(.init(degrees: showMenu ? -15 : 0),axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                .offset(x: showMenu ? getRectSlide().width / 2 : 0)
                .ignoresSafeArea()
                
        }
        .preferredColorScheme(.dark)
    }
}

struct SlideOutView_Previews: PreviewProvider {
    static var previews: some View {
        SlideOutView()
    }
}


extension View {
    
    func getSafeAreaSlide()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
