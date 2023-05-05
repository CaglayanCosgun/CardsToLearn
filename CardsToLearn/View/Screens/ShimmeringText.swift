//
//  ShimmeringText.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct ShimmeringText: View {
    let text: String
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.clear, .white, .clear]), startPoint: .leading, endPoint: .trailing)
                .frame(width: 200, height: 50)
                .rotationEffect(.degrees(70))
                .offset(x: isAnimating ? 150 : -50, y: 0)
                .opacity(isAnimating ? 1.0 : 0.2)
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
                .opacity(isAnimating ? 0.2 : 1.0)
        }
        .onAppear() {
            withAnimation(Animation.linear(duration: 2.0)) {
                self.isAnimating = true
            }
        }
        .onDisappear() {
            self.isAnimating = false
        }
    }
}
