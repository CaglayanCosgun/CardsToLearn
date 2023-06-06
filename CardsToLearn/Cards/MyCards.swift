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
                Button(action: {
                    
                }) {
                    Image("menu")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 22,height: 22)
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                Button(action: {
                    
                }) {
                    Image("search")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 22,height: 22)
                }.padding(.top,30)
                
                
                Group {
                    Button(action: {
                        self.index = 3
                    }) {
                        VStack{
                            Text("MyProfile")
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
                            Text("Notifications")
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
                            Text("Invoice")
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
                        Invoice()
                    }
                    else if self.index == 2{
                        Notifications()
                    }
                    else {
                        Profil()
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
                
                Text("Food & Delivery")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.top,20)
            .padding(.horizontal,20)
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack{
                    
                    Button(action: {
                        self.index = 0
                    }) {
                        Text("Asian")
                            .foregroundColor(self.index == 0 ? Color("gray1") : Color.black.opacity(0.7))
                            .padding(.horizontal,30)
                            .padding(.vertical,12)
                    }
                    .background(self.index == 0 ? Color.black.opacity(0.06) : Color.clear)
                    .clipShape(CShapeCard1())
                    
                    Button(action: {
                        self.index = 1
                    }) {
                        Text("American")
                            .foregroundColor(self.index == 1 ? Color("gray1") : Color.black.opacity(0.7))
                            .padding(.horizontal,30)
                            .padding(.vertical,12)
                    }
                    .background(self.index == 1 ? Color.black.opacity(0.06) : Color.clear)
                    .clipShape(CShapeCard1())
                    
                    Button(action: {
                        self.index = 2
                    }) {
                        Text("Mexican")
                            .foregroundColor(self.index == 2 ? Color("gray1") : Color.black.opacity(0.7))
                            .padding(.horizontal,30)
                            .padding(.vertical,12)
                    }
                    .background(self.index == 2 ? Color.black.opacity(0.06) : Color.clear)
                    .clipShape(CShapeCard1())
                    
                    Button(action: {
                        self.index = 3
                    }) {
                        Text("Turkish")
                            .foregroundColor(self.index == 3 ? Color("gray1") : Color.black.opacity(0.7))
                            .padding(.horizontal,30)
                            .padding(.vertical,12)
                    }
                    .background(self.index == 3 ? Color.black.opacity(0.06) : Color.clear)
                    .clipShape(CShapeCard1())
                    
                    Button(action: {
                        self.index = 4
                    }) {
                        Text("Arabish")
                            .foregroundColor(self.index == 4 ? Color("gray1") : Color.black.opacity(0.7))
                            .padding(.horizontal,30)
                            .padding(.vertical,12)
                    }
                    .background(self.index == 4 ? Color.black.opacity(0.06) : Color.clear)
                    .clipShape(CShapeCard1())
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
                                .frame(width: 125,height: 125)
                                .clipShape(Circle())
                            
                            Text(i.price)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(Color("gray1"))
                                .padding(.top)
                            
                            Text(i.name)
                                .padding(.vertical,20)
                            
                            Button(action: {
                                
                            }) {
                                Text("Add")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .padding(.horizontal,35)
                            }
                            .background(Color("gray2"))
                            .clipShape(CShapeCard1())
                        }
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(Color.black.opacity(0.05))
                        .clipShape(CShapeCard1())
                    }
                }
                .padding(.horizontal,20)
            }
            .padding(.top,25)
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("View All")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal,35)
                        .padding(.vertical)
                }
                .background(Color("gray3"))
                .clipShape(CShapeCard1())
            }
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
Type(name: "Chill", cName: "Arabish", price: "1", image: "pic1"),
Type(name: "Chill", cName: "Arabish", price: "2", image: "pic2"),
Type(name: "Chill", cName: "Arabish", price: "3", image: "pic3"),
Type(name: "Chill", cName: "Arabish", price: "4", image: "pic4"),
Type(name: "Chill", cName: "Arabish", price: "5", image: "pic5"),
Type(name: "Chill", cName: "Arabish", price: "6", image: "pic6"),
Type(name: "Chill", cName: "Arabish", price: "7", image: "pic7"),
Type(name: "Chill", cName: "Arabish", price: "8", image: "pic8"),
Type(name: "Chill", cName: "Arabish", price: "9", image: "pic9"),
Type(name: "Chill", cName: "Arabish", price: "10", image: "pic10")

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
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.bottomRight],cornerRadii: CGSize(width: 35, height: 35))
        
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
