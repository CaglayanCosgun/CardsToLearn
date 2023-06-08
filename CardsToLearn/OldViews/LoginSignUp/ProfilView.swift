//
//  ProfilView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var registerViewModel: RegisterViewModel
    
    @State private var showingAlert = false
    @State private var logoutConfirmed = false
    @State private var showPassword = false
    @State private var showNewPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)), Color.gray, Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            ScrollView {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Welcome, User!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .foregroundColor(.black)
                    
                    Group {
                        Text("User Information")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                        HStack {
                            Text("Username:")
                            TextField("First Name", text: $firebaseViewModel.surname)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Vorname:")
                            TextField("Last Name", text: $firebaseViewModel.lastname)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Name:")
                            TextField("Username", text: $firebaseViewModel.username)
                        }
                        .padding(.bottom)
                        HStack {
                            Text("Email:")
                            TextField("Email", text: $firebaseViewModel.email)
                        }
                        .padding(.bottom)
                        
                        Text(firebaseViewModel.gender)
                            .padding(.bottom)
                    }
                    .padding(.horizontal, 20)
                    
                    Group {
                        Text("Change Password")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Current Password:")
                            if showPassword { // Passwort anzeigen, wenn showPassword true ist
                                TextField("Password", text: $firebaseViewModel.password)
                            } else { // Sonst sicheres Textfeld anzeigen
                                SecureField("Password", text: $firebaseViewModel.password)
                            }
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding()
                        .shadow(radius: 5)
                        
                        VStack(alignment: .leading) {
                            Text("New Password:")
                            if showNewPassword { // Passwort anzeigen, wenn showPassword true ist
                                TextField("New Password", text: $firebaseViewModel.newPassword)
                            } else { // Sonst sicheres Textfeld anzeigen
                                SecureField("New Password", text: $firebaseViewModel.newPassword)
                            }
                            Button(action: { showNewPassword.toggle() }) {
                                Image(systemName: showNewPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding()
                        .shadow(radius: 5)
                        
                        VStack(alignment: .leading) {
                            Text("Confirm Password:")
                            if showConfirmPassword { // Passwort anzeigen, wenn showPassword true ist
                                TextField("Confirm Password", text: $firebaseViewModel.confirmNewPassword)
                            } else { // Sonst sicheres Textfeld anzeigen
                                SecureField("Confirm Password", text: $firebaseViewModel.confirmNewPassword)
                            }
                            Button(action: { showConfirmPassword.toggle() }) {
                                Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding()
                        .shadow(radius: 5)
                        
                        .padding(.bottom)
                        
                        Button(action: {
                            firebaseViewModel.savePassword()
                            
                        }) {
                            Text("Save")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 20)
                    
                    Group {
                        Text("Settings")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                        Toggle(isOn: .constant(false)) {
                            Text("Push Notifications")
                        }
                        .padding(.bottom)
                        
                        Toggle(isOn: .constant(true)) {
                            Text("Email Notifications")
                        }
                        .padding(.bottom)
                        
                        Group {
                            Text("Konto")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.top)
                            
                            Divider()
                            
                            Button(action: {
                                showingAlert = true
                            }) {
                                Text("Logout")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            .padding(.bottom)
                            .alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Bestätigung"),
                                    message: Text("Möchten Sie sich wirklich ausloggen?"),
                                    primaryButton: .default(Text("Ja"),
                                                            action: {
                                                                logoutConfirmed = true
                                                                // Hier der Logout-Code
                                                                firebaseViewModel.logout()
                                                            }),
                                    secondaryButton: .cancel(Text("Nein"), action: {
                                        logoutConfirmed = false
                                    })
                                )
                            }
                            Button(action: {
                                
                            }) {
                                Text("Konto löschen")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .padding(.bottom)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .navigationBarTitle(Text("Profile"))
                }
            }
        }
    }
}
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

