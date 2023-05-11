//
//  LogInView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: FireBaseViewModel
    @EnvironmentObject var registerVM: RegisterViewModel
   
    @State private var isAnimating = false
    @State private var showPassword = false
    @State private var isRegisterViewPresented = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .padding(.top, 50)
                    .shadow(radius: 10)

                VStack(spacing: 10) {
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    HStack {
                        if showPassword { // Passwort anzeigen, wenn showPassword true ist
                            TextField("Password", text: $viewModel.password)
                        } else { // Sonst sicheres Textfeld anzeigen
                            SecureField("Password", text: $viewModel.password)
                        }
                        
                        // Button mit Auge-Icon zum Anzeigen des Passworts
                        Button(action: { showPassword.toggle() }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
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
                .padding(.bottom, 10)

                Button(action: {
                                    // Register button action
                                    isRegisterViewPresented = true
                                }) {
                                    HStack {
                                        Text("Register")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.green) // Customize the button color as needed
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                    }
                                }
                            }
                            .padding()
                            .navigationBarTitle("Log in")
                        }
                        .sheet(isPresented: $isRegisterViewPresented) {
                            // Present the RegisterView as a sheet when isRegisterViewPresented is true
                            RegisterView()
                            // Pass the appropriate RegisterViewModel
                        }
                    }
                }

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
