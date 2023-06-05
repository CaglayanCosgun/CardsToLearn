//
//  AnimatedSplashScreen.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import Foundation
import SwiftUI

struct AnimatedSplashScreen<Content: View>: View {
    var content: Content
    var color: String
    var logo: String
    var barHeight: CGFloat = 60
    var animationTiming: Double = 0.65
    
    var onAnimationEnd: ()->()
    init(color: String,logo: String,barHeight: CGFloat = 60,animationTiming: Double = 0.65 ,@ViewBuilder content: @escaping () -> Content,onAnimationEnd: @escaping () -> ()) {
        self.content = content()
        self.onAnimationEnd = onAnimationEnd
        self.color = color
        self.logo = logo
        self.barHeight = barHeight
        self.animationTiming = animationTiming
    }
    @State var startAnimation: Bool = false
    @State var animateContent: Bool = false
    @Namespace var animation
    
    @State var disableControls: Bool = true
    var body: some View {
        VStack(spacing: 0) {
            if startAnimation {
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    VStack(spacing: 0) {
                        ZStack(alignment: .bottom){
                            Rectangle()
                                .fill(Color("white").gradient)
                                .matchedGeometryEffect(id: "SPLASHCOLOR", in: animation)
                                .frame(height: barHeight + safeArea().top)
                                
                            Image("Swifticon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: "SPLASHICON", in: animation)
                                .frame(width: 35, height: 35)
                                .padding(.bottom,20)
                        }
                        
                        content
                            .offset(y: animateContent ? 0 : (size.height - (barHeight + safeArea().top)))
                            .disabled(disableControls)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                }
                .transition(.identity)
                .ignoresSafeArea(.container,edges: .all)
                .onAppear {
                    if !animateContent {
                        withAnimation(.easeInOut(duration: animationTiming)) {
                            animateContent = true
                        }
                    }
                }
            }else {
                ZStack{
                    Rectangle()
                        .fill(Color("white").gradient)
                        .matchedGeometryEffect(id: "SPLASHCOLOR", in: animation)
                    Image("Swifticon")
                        .matchedGeometryEffect(id: "SPLASHICON", in: animation)
                }
                .ignoresSafeArea(.container,edges: .all)
            }
        }
        .onAppear {
            if !startAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeInOut(duration: animationTiming)) {
                        startAnimation = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + (animationTiming - 0.05)) {
                    disableControls = false
                    onAnimationEnd()
                }
            }
        }
    }
}

struct AnimatedSplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashContentView()
    }
}

//Mark: falls es wieder benutzt wird dann in der ContentView unter dem body einsetzen.

//        AnimatedSplashScreen(color: "white", logo: "splashlogo") {
//            ScrollView {
//                VStack(spacing: 15) {
//                    ForEach(1...5,id: \.self) { index in
//                        GeometryReader { proxy in
//                            let size = proxy.size
//                            Image("Thumb\(index)")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: size.width, height: size.height)
//                                .cornerRadius(15)
//
//                        }
//                        .frame(height: 200)
//                    }
//                }
//            }
//        } onAnimationEnd: {
//            print("Logo")
//        }
    
