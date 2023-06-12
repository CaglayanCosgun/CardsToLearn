//
//  SideBaseMenu.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 06.06.23.
//

import SwiftUI

struct SideBaseMenu: View {
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            
            
            VStack(alignment: .leading,spacing: 14){
                Image("splashlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Text("User")
                    .font(.title2.bold())
                
                Text(firebaseViewModel.email)
                    .font(.callout)
                
                HStack(spacing: 12){
                    
                    Button{
                        
                    }label: {
                        Label{
                            Text("Following")
                        }icon: {
                            Text("1.2M")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Button{
                        
                    }label: {
                        Label{
                            Text("Followers")
                        }icon: {
                            Text("100")
                                .fontWeight(.bold)
                        }
                    }
                    
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal)
            .padding(.leading)
            .padding(.bottom)
            
            ScrollView(.vertical,showsIndicators: false){
                
                VStack{
                    VStack(alignment: .leading,spacing: 45){
                        
                        NavigationLink{
                            
                            ProfilPage()
                                .navigationTitle("Profile")
                            
                        }label: {
                            
                            Image(systemName: "person")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22,height: 22)
                                .foregroundColor(.primary)
                            
                            Text("Profile")
                                .foregroundColor(.black)
                        }
                        
                        NavigationLink{
                            
                            LastCardView()
                                .navigationTitle("LastCard")
                            
                        }label: {
                            
                            Image("LastCard")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22,height: 22)
                                .foregroundColor(.primary)
                            
                            Text("LastCard")
                                .foregroundColor(.black)
                        }
                        
                        
//                        SideTabButton(title: "LastCard", image: "LastCard")
                        
                        NavigationLink{
                            
                            LastQuizView()
                                .navigationTitle("LastQuiz")
                            
                        }label: {
                            
                            Image("LastQuiz")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22,height: 22)
                                .foregroundColor(.primary)
                            
                            Text("LastQuiz")
                                .foregroundColor(.black)
                        }
                        
                        
//                        SideTabButton(title: "LastQuiz", image: "LastQuiz")
                        
                        SideTabButton(title: "Favorites", image: "Favorites")
                        
                        SideTabButton(title: "Activity", image: "Activity")
                        
                        NavigationLink{
                            
                            StatisticView()
                                .navigationTitle("Learn Charts")
                            
                        }label: {
                            
                            Image(systemName: "chart.bar.xaxis")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22,height: 22)
                                .foregroundColor(.primary)
                            
                            Text("Statistics")
                                .foregroundColor(.black)
                        }
                        
                        SideTabButton(title: "Bell", image: "Bell")
                        
                        SideTabButton(title: "Settings", image: "Settings")
                        
                        
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.top,45)
                    
                    Divider()
                    
                    SideTabButton(title: "Info", image: "Info")
                        .padding()
                        .padding(.leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading,spacing: 30){
                        
                        Button("Privacy"){
                            
                        }
                        
                        Button("Help Center"){
                            
                        }
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(.primary)
                }
            }
            VStack(spacing: 0){
                
                Divider()
                
                HStack{
                    
                    Button {
                        
                    }label: {
                        
                        Image("Light")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22,height: 22)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    }label: {
                        
                        Image("QR")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22,height: 22)
                    }
                }
                .padding([.horizontal,.top],15)
                .foregroundColor(.primary)
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(width: getRectBase().width - 90)
        .frame(maxHeight: .infinity)
        .background(
        
            Color.primary.opacity(0.04)
                .ignoresSafeArea(.container,edges: .vertical)
        )
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    @ViewBuilder
    func SideTabButton(title: String,image: String)->some View{
        
        NavigationLink {
            
            Text("\(title) View")
                .navigationTitle(title)
        }label: {
    
            HStack(spacing: 14){
                
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22,height: 22)
                
                Text(title)
                
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}

struct SideBaseMenu_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}


extension View {
    
    func getRectBase()->CGRect{
        return UIScreen.main.bounds
    }
}


