//
//  LogInView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .padding(.top, 50)
                    .shadow(radius: 10)
                
                VStack(spacing: 10) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("Passwort vergessen?")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .shadow(radius: 2)
                        }
                        .padding(.top, 5)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .background(Color.black.opacity(0.2))
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Button(action: {
                    // Log in button action
                    isAnimating = true
                }) {
                    VStack {
                        Text("Login")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .scaleEffect(isAnimating ? 0.9 : 1)
                            .animation(
                                Animation.easeInOut(duration: 0.5)
                                    .repeatForever(autoreverses: true)
                            )
                    }
                }
                .padding(.bottom, 50)
            }
            .padding()
            .navigationBarTitle("Log in")
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
