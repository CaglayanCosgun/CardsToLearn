//
//  SplashScreenView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 28.04.23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Image(systemName: "book.closed") // Symbol für Lernen mit Karten
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 5) // Schatten-Effekt
                Text("CardQ") // Text- oder Bild-Logo einfügen
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .scaleEffect(isAnimating ? 1.2 : 1.0) // Skalierungseffekt
                    .opacity(isAnimating ? 0.5 : 1.0) // Transparenz-Effekt
                    .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Rotations-Effekt
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true) // Endlosschleife mit umgekehrter Wiederholung
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
