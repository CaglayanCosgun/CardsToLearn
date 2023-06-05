//
//  Logo.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 01.06.23.
//

import SwiftUI

struct Logo: View {
    
    @State var startAnimation = false
    @State var bowAnimation = false
    
    @State var glow = false
    
    @State var showLearn = false
    @State var learnBGGlow = false
    @State var isFinished = false
    
    var body: some View {
        
        if !isFinished {
            ZStack {
                
                Color("black")
                    .ignoresSafeArea()
                
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    ZStack {
                        
                        Circle()
                            .trim(from: 0, to: bowAnimation ? 0.5 : 0)
                            .stroke(
                                
                                .linearGradient(.init(colors: [
                                    
                                    Color("gray"),
                                    Color("gray"),
                                    Color("lightgray"),
                                    Color("white"),
                                    Color("white")
                                        .opacity(0.5),

                                    Color("gray"),
                                    Color("gray"),
                                    Color("gray"),
                                    
                                ]),startPoint: .leading, endPoint: .trailing)
                                
                                ,style: StrokeStyle(lineWidth: 5,lineCap: .round,lineJoin: .round)
                            )
                            .overlay(
                                Circle()
                                    .fill(Color.white.opacity(0.4))
                                    .frame(width: 6, height: 6)
                                    .overlay(
                                        Circle()
                                            .fill(Color.white.opacity(glow ? 0.2 : 0.1))
                                            .frame(width: 20, height: 20)
                                    )
                                    .blur(radius: 2.5)
                                    .offset(x: (size.width / 2) / 2)
                                    .rotationEffect(.init(degrees: bowAnimation ? 180 : 0))
                                    .opacity(bowAnimation ? 1 : 0)
                            )
                            .frame(width: size.width / 1.4, height: size.width / 1.3)
                            .rotationEffect(.init(degrees: -200))
                            .offset(y: 10)
                        
                        HStack(spacing: -20) {
                            Image("cards")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width / 1.3, height: size.width / 1.3)
                                .opacity(startAnimation ? 1 : 0)
                            
                            Image("learn")
                               // .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(
                                
                                    ZStack {
                                        
                                        Circle()
                                            .fill(Color.white.opacity(0.25))
                                            .frame(width: 20, height: 20)
                                            .blur(radius: 2)
                                        
                                        Circle()
                                            .fill(Color.white.opacity(0.2))
                                            .frame(width: 35, height: 35)
                                            .blur(radius: 2)
                                    }
                                        .opacity(learnBGGlow ? 1 : 0)
                                )
                                .scaleEffect(showLearn ? 1 : 0)
                        }
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }
            }
            .onAppear{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    withAnimation(.linear(duration: 2)) {
                        bowAnimation.toggle()
                    }
                    
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                        glow.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        withAnimation(.spring()){
                            startAnimation.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.spring()){
                            
                            showLearn.toggle()
                            startAnimation.toggle()
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        withAnimation(.linear(duration: 0.5)) {
                            learnBGGlow.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            withAnimation(.linear(duration: 0.4)) {
                                learnBGGlow.toggle()
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            withAnimation {
                                isFinished.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
