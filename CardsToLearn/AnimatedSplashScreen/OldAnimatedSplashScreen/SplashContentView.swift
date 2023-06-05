//
//  SplashContentView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct SplashContentView: View {
    var body: some View {
        AnimatedSplashScreen(color: "white", logo: "splashlogo",animationTiming: 5) {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(1...5,id: \.self) { index in
                        GeometryReader { proxy in
                            let size = proxy.size
                            Image("Thumb\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                                .cornerRadius(15)
                            
                        }
                        .frame(height: 200)
                    }
                }
            }
        } onAnimationEnd: {
            print("")
        }
    }
}

struct SplashContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashContentView()
    }
}
