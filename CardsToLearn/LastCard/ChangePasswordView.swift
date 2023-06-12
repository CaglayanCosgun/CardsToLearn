//
//  ChangePasswordView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 12.06.23.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var showingAlert = false
    @State private var logoutConfirmed = false
    @State private var showPassword = false
    @State private var showNewPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            Text("Change Password")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Current Password:")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                if showPassword { // Passwort anzeigen, wenn showPassword true ist
                    TextField("Password", text: $firebaseViewModel.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
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
        }
    }
}

