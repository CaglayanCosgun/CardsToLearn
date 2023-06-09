//
//  MyCards.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.06.23.
//

import SwiftUI

struct MyCardsSideBar: View {
    
    @State private var vocabulary = [Date: String]() // Vokabeln für jeden ausgewählten Tag
    @EnvironmentObject var wordVM: ApiWordViewModel
    
    @State var index = 0
    
    var body: some View {
        
        HStack(spacing: 0){
            
            VStack{
               

                Group {
                    Button(action: {
                        self.index = 3
                    }) {
                        VStack{
                            Text("Learntips")
                                .frame(width: 120,height: 35)
                                .foregroundColor(self.index == 3 ? Color.white : Color.black)
                        }
                        .background(Color("gray2").opacity(self.index == 3 ? 1 : 0))
                        .clipShape(CShapeCard1())
                    }
                    .rotationEffect(.init(degrees: -90))
                    .padding(.top,80)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 2
                    }) {
                        VStack{
                            Text("Quotes")
                                .frame(width: 120,height: 35)
                                .foregroundColor(self.index == 2 ? Color.white : Color.black)
                        }
                        .background(Color("gray2").opacity(self.index == 2 ? 1 : 0))
                        .clipShape(CShapeCard1())
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 1
                    }) {
                        VStack{
                            Text("Dictionary")
                                .frame(width: 120,height: 35)
                                .foregroundColor(self.index == 1 ? Color.white : Color.black)
                        }
                        .background(Color("gray2").opacity(self.index == 1 ? 1 : 0))
                        .clipShape(CShapeCard1())
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 0
                    }) {
                        VStack{
                            Text("Home")
                                .frame(width: 120,height: 35)
                                .foregroundColor(self.index == 0 ? Color.white : Color.black)
                        }
                        .background(Color("gray2").opacity(self.index == 0 ? 1 : 0))
                        .clipShape(CShapeCard1())
                    }
                    .rotationEffect(.init(degrees: -90))
                    
                    Spacer(minLength: 0)
         
                    Button(action: {
                        
                    }) {
                        Image("splashlogo")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 25, height: 30)
                    }
                    .padding(.bottom)
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }
                
              
            }
            .padding(.vertical)
            .frame(width: 85)
            .background(Color("gray3"))
            .clipShape(CShapeCard())
            
            GeometryReader {_ in
                
                VStack{
                    if self.index == 0{
                        MainView()
                    }
                    else if self.index == 1{
                        ApiVocabularyView()
                    }
                    else if self.index == 2{
                        ApiQuotesView()
                    }
                    else {
                        LearningTipsView()
                    }
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct MainView: View {
    
    @State var index = 0
    
    var body: some View {
        VStack{
            HStack{
                
                Text("Learning & Chill")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.top,20)
            .padding(.horizontal,20)
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack{
                    
                   
                }
                .padding(.horizontal,20)
            }
            .padding(.top,25)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 20){
                    ForEach(data) { i in
                        VStack{
                            Image(i.image)
                                .resizable()
                                .frame(width: 125,height: 500)
                                .clipShape(Circle())
                            
                            Text(i.price)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(Color("gray1"))
                                .padding(.top)
                            
                            Text(i.name)
                                .padding(.vertical,10)
                            
                            
                        }
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.black.opacity(0.05))
                        .clipShape(CShapeCard1())
                    }
                }
                .padding(.horizontal,5)
            }
            .padding(.top)
            .padding(.horizontal,20)
        }
    }
}


struct Type: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cName: String
    var price: String
    var image: String
}
var data = [
Type(name: "Chill", cName: "Arabish", price: "1", image: "one"),
Type(name: "Chill", cName: "Arabish", price: "2", image: "two"),
Type(name: "Chill", cName: "Arabish", price: "3", image: "three"),
Type(name: "Chill", cName: "Arabish", price: "4", image: "four"),
Type(name: "Chill", cName: "Arabish", price: "5", image: "five"),
Type(name: "Chill", cName: "Arabish", price: "6", image: "six"),
Type(name: "Chill", cName: "Arabish", price: "7", image: "seven")

]


struct Profil: View {
    var body: some View {
        VStack{
            Text("Profile")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct Invoice: View {
    var body: some View {
        VStack{
            Text("Invoice")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct Notifications: View {
    var body: some View {
        VStack{
            Text("Notifications")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct CShapeCard: Shape{
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.bottomRight],cornerRadii: CGSize(width: 0, height: 0))
        
        return Path(path.cgPath)
    }
}


struct CShapeCard1: Shape{
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.bottomRight],cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
}


struct MyCards_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsSideBar()
    }
}
