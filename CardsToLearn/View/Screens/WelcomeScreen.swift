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
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
            
            VStack {
                // Welcome Text
                Text("Welcome User")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .scaleEffect(isAnimated ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 1.0))
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
                
                if showText {
                    Text("Cardq")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .transition(.scale)
                }
                
                Spacer()
                
                // Buttons
                HStack {
                    Button(action: {
                        // Action for Button 1
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                    }
                    .frame(width: showButtons ? 150 : 0, height: showButtons ? 50 : 0)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.5))
                    
                    Button(action: {
                        // Action for Button 2
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.black)
                    }
                    .frame(width: showButtons ? 150 : 0, height: showButtons ? 50 : 0)
                    .background(Color.green)
                    .cornerRadius(10)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.7))
                }
                
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