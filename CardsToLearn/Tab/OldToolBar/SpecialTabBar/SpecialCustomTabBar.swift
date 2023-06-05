//
//  SpecialCustomTabBar.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.06.23.
//

import SwiftUI

struct SpecialCustomTabBar: View {
    @Binding var activeTab: SpecialTabBar
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(SpecialTabBar.allCases,id: \.rawValue) { tab in
                    Image(tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .offset(y: offset(tab))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7,blendDuration: 0.7)) {
                                activeTab = tab
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                    
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
        .padding(.bottom, safeAreas.bottom == 0 ? 30 : safeAreas.bottom)
        .background(content: {
            ZStack{
                SpecialTabBarTopCurve()
                    .stroke(.white, lineWidth: 0.5)
                    .blur(radius: 0.5)
                    .padding(.horizontal,-10)
                SpecialTabBarTopCurve()
                    .fill(Color("gray").opacity(0.5).gradient)
                    
            }
        })
        .overlay(content: {
            GeometryReader { proxy in
                
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxedWidth = width * 5
                let heigth = rect.height
                
                Circle()
                    .fill(.clear)
                    .frame(width: maxedWidth, height: maxedWidth)
                    .background(alignment: .top){
                        Rectangle()
                            .fill(.linearGradient(colors: [
                            Color("lightgray"),
                            Color("white"),
                            Color("white"),
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(width: width, height: heigth)
                            .mask(alignment: .top) {
                                Circle()
                                    .frame(width: maxedWidth,height: maxedWidth,alignment: .top)
                            }
                    }
                    .overlay(content: {
                    Circle()
                        .stroke(.white, lineWidth: 0.2)
                        .blur(radius: 0.5)
                })
                    .frame(width: width)
                    .background(content: {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45, height: 4)
                            .glows(.white.opacity(0.5), radius: 50)
                            .glows(Color("Blue").opacity(0.7),radius: 30)
                            .offset(y: -1.5)
                            .offset(y: -maxedWidth / 2)
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth / 2, actualWidth: width,true)))
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth / 2, actualWidth: width)))
                    })
                    .offset(y: heigth / 2.1)
                
            }
            .overlay(alignment: .bottom) {
                Text(activeTab.rawValue)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .offset(y: safeAreas.bottom == 0 ? -15 : -safeAreas.bottom + 12)
            }
        })
        .preferredColorScheme(.dark)
    }
    
    func calculateRotation(maxedWidth y : CGFloat, actualWidth: CGFloat, _ isInitial: Bool = false) -> CGFloat {
        let tabWidth = actualWidth / SpecialTabBar.count
        let firstTabPositionX: CGFloat = -(actualWidth - tabWidth) / 2
        let tan = y / firstTabPositionX
        let radians = atan(tan)
        let degree = radians * 180 / .pi
        
        if isInitial {
            return -(degree + 90)
        }
        let x = tabWidth * activeTab.index
        let tan_ = y / x
        let radians_ = atan(tan_)
        let degree_ = radians_ * 180 / .pi
        
        return -(degree_ - 90)
        
    }
    
    
    func offset(_ tab: SpecialTabBar) -> CGFloat {
        let totalIndices = SpecialTabBar.count
        let currentIndex = tab.index
        let progress = currentIndex / totalIndices
        
        return progress < 0.5 ? (currentIndex * -10) : ((totalIndices - currentIndex - 1)) * -10
    }
}

struct SpecialCustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTabBarView()
    }
}


struct SpecialTabBarTopCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let heigth = rect.height
            let midWitdh = width / 2
            path.move(to: .init(x: 0, y: 5))
            
            path.addCurve(to: .init(x: midWitdh, y: -20), control1: .init(x: midWitdh / 2, y: -20), control2: .init(x: midWitdh, y: -20))
            
            path.addCurve(to: .init(x: width, y: 5), control1: .init(x: (midWitdh + (midWitdh / 2)),y: -20), control2: .init(x: width, y: 5))
            
            path.addLine(to: .init(x: width, y: heigth))
            path.addLine(to: .init(x: 0, y: heigth))
            
            path.closeSubpath()
            
        }
    }
}
