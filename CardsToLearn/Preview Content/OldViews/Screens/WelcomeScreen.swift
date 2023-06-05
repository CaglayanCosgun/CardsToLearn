//
//  WelcomeScreen.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct WelcomeScreenView: View {
    
    // Properties
    @State private var showLogo: Bool = false
    @State private var showButtons: Bool = false
    @State private var isAnimated: Bool = false
    @State private var showText: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Welcome Text
                Text("Welcome User")
                    .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .scaleEffect(isAnimated ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 1.5))
                    .onAppear {
                        self.isAnimated.toggle()
                    }
                
                Spacer()
                
                // Logo
                Image(systemName: "pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: showLogo ? 150 : 0, height: showLogo ? 150 : 0)
                    .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false))
                    .onAppear {
                        self.showLogo = true
                        self.isAnimated.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                self.showText = true
                            }
                        }
                    }
                
                // Text "Cardq"
                if showText {
                    HStack(spacing: 0) {
                        ForEach(Array("Cardq").indices, id: \.self) { index in
                            Text(String(Array("Cardq")[index]))
                                .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .bold))
                                .foregroundColor(.white)
                                .opacity(self.showText ? 1 : 0)
                                .animation(Animation.easeInOut(duration: 0.5).delay(Double(index) * 0.1))
                                .rotationEffect(Angle(degrees: self.showText ? 0 : 180))
                                .scaleEffect(self.showText ? 1 : 0.5)
                                .offset(x: self.showText ? 0 : -50)
                        }
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
