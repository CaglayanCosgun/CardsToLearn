//
//  HomeSlideOutView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct HomeSlideOutView: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    
    
    @State var selectedTab: SlideTabs = .notes
    
    
    
    @State var showMenu: Bool = false
    
    @State var animatePath: Bool = false
    @State var animateBG: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 15) {
                
                HStack {
                    
                    Button {
                        
                        withAnimation{
                            animateBG.toggle()
                            
                        }
                        
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                        
                        withAnimation(.interactiveSpring(response: 0.4,dampingFraction: 0.3,blendDuration: 0.3).delay(0.2)) {
                            
                            animatePath.toggle()
                        }
                        
                    }label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1)
                    }
                    Spacer()
                    
                    Button {
                        
                    }label: {
                        Image("add")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1)
                    }
                }
                .overlay (
                
                    Text("Stories")
                        .font(.title2.bold())
                    
                )
                .foregroundColor(Color.white.opacity(0.8))
                .padding([.horizontal,.top])
                .padding(.bottom,5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        ForEach(stories) { story in
                            StoryCardView(story: story)
                        }
                    }
                    .padding()
                    .padding(.top,10)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                
                LinearGradient(colors: [
                    
                    Color("color2"),
                    Color("color1"),
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )
            
            Color.black.opacity(animateBG ? 0.25 : 0)
                .ignoresSafeArea()
            
            MenuView(showMenu: $showMenu,animatePath: $animatePath,animateBG: $animateBG)
                .offset(x: showMenu ? 0 : -getRect().width)
        }
        
    }
    
    @ViewBuilder
    func StoryCardView(story: Story) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            GeometryReader { proxy in
                
                let size = proxy.size
                
                Image(story.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
                
            }
            .frame(height: 200)
            
            Text(story.titel)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
            
            Button {
                
            }label: {
                Text("Read Now")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,6)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color("Red"))
                    )
                
            }
        }
    }
}

struct MenuView: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    

    
    @Binding var showMenu: Bool
    @Binding var animatePath: Bool
    @Binding var animateBG: Bool
    
    var body: some View {
        
        ZStack {
            
            BlurView(style: .systemUltraThinMaterialDark)
            
            Color("color2")
                .opacity(0.7)
                .blur(radius: 15)
            
            VStack(alignment: .leading, spacing: 25) {
                
                Button {
                    
                    withAnimation(.interactiveSpring(response: 0.4,dampingFraction: 0.3,blendDuration: 0.3)) {
                        
                        animatePath.toggle()
                    }
                    
                    withAnimation{
                        animateBG.toggle()
                        
                    }
                    
                    withAnimation(.spring().delay(0.1)){
                        showMenu.toggle()
                    }
                    
                   
                    
                }label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(Color.white.opacity(0.8))
                
                MenuButton(title: "Notes", image: "note", offset: 0)
                    .padding(.top,40)
                
                
                MenuButton(title: "Quotes", image: "ellipsis.bubble", offset: 10)
                MenuButton(title: "My Account", image: "Profile", offset: 30)
                MenuButton(title: "Cards", image: "square.grid.2x2", offset: 10)
                MenuButton(title: "Quiz", image: "gamecontroller", offset: 10)
                MenuButton(title: "Tips", image: "lightbulb", offset: 10)
                MenuButton(title: "Relax", image: "beach.umbrella", offset: 0)
                
                Spacer(minLength: 10)
                MenuButton(title: "LOGOUT", image: "rectangle.portrait.and.arrow.right", offset: 0)
            }
            .padding(.trailing,120)
            .padding()
            .padding(.top,getSafeArea().top)
            .padding(.bottom,getSafeArea().bottom)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        }
        .clipShape(MenuShape(value: animatePath ? 150 : 0))
        .background(
            MenuShape(value: animatePath ? 150 : 0)
            .stroke(
                .linearGradient(.init(colors: [
                    
                    Color("lightgray"),
                    Color("lightgray")
                        .opacity(0.7),
                    Color("lightgray")
                        .opacity(0.5),
                    Color.clear
                    
                ]), startPoint: .top, endPoint: .bottom),
                lineWidth: animatePath ? 7 : 0
            )
            .padding(.leading, -50)
        )
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func MenuButton(title: String,image: String,offset: CGFloat)-> some View {
        
        Button {
            
        }label: {
            HStack(spacing: 12) {
                if image == "Profile" {
                    
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                }
                else {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(title == "LOGOUT" ? .semibold : .medium)
                    .kerning(title == "LOGOUT" ? 1.2 : 0.8)
                    .foregroundColor(Color.white.opacity(title == "LOGOUT" ? 0.9 : 0.65))
            }
            .padding(.vertical)
        }
        .offset(x: offset)
    }
}

struct MenuShape: Shape {
    
    var value: CGFloat
    
    var animatableData: CGFloat {
        
        get {return value}
            set{value = newValue}
        
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            let width = rect.width - 100
            let height = rect.height
            
            path.move(to: CGPoint(x: width, y: height))
            
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            path.move(to: CGPoint(x: width, y: 0))
            
            path.addCurve(to: CGPoint(x: width, y: height + 100), control1: CGPoint(x: width + value, y: height / 3), control2: CGPoint(x: width - value, y: height / 2))
            
        }
    }
}

struct HomeSlideOutView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSlideOutView()
    }
}


extension View {
    
    func getSafeArea()-> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}

