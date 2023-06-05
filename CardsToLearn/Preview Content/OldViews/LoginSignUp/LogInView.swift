//
//  LogInView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var isAnimating = false
    @State private var showPassword = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
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
                        TextField("Email", text: $firebaseViewModel.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        HStack {
                            if showPassword { // Passwort anzeigen, wenn showPassword true ist
                                TextField("Password", text: $firebaseViewModel.password)
                            } else { // Sonst sicheres Textfeld anzeigen
                                SecureField("Password", text: $firebaseViewModel.password)
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
                        isAnimating = false
                        firebaseViewModel.login()
                        
                        // Check, ob der Login erfolgreich war
                        if firebaseViewModel.loggedIn {
                            showAlert = false
                        } else {
                            showAlert = true
                        }
                    }) {
                        VStack {
                            Text("Login")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 400, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .scaleEffect(isAnimating ? 0.9 : 1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 3)
                                        .shadow(color: .gray, radius: 5)
                                )
                        }
                    }
                    .padding(.bottom, 10)
                    
                    NavigationLink(destination: RegisterView()) {
                        HStack {
                            Text("Register")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 400, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 3)
                                        .shadow(color: .gray, radius: 5)
                                )
                        }
                    }
                }
                .padding()
                .navigationBarTitle("Log in")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Falsche E-Mail oder Passwort"),
                message: Text("Bitte überprüfe deine Eingaben und versuche es erneut."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
