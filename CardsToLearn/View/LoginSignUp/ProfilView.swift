//
//  ProfilView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct ProfileView: View {
    
    // Properties
    @State private var username: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var gender: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
            ScrollView {
                VStack {
                    // Profile Image
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                        .padding()
                    
                    // Welcome Text
                    Text("Welcome, User!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .foregroundColor(.black)
                    
                    // User Information
                    Group {
                        Text("User Information")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                        TextField("Username", text: $username)
                            .padding(.bottom)
                        
                        TextField("First Name", text: $firstName)
                            .padding(.bottom)
                        
                        TextField("Last Name", text: $lastName)
                            .padding(.bottom)
                        
                        TextField("Email", text: $email)
                            .padding(.bottom)
                        
                        Text(gender)
                            .padding(.bottom)
                    }
                    .padding(.horizontal, 20)
                    
                    // Change Password
                    Group {
                        Text("Change Password")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                        SecureField("Current Password", text: $password)
                            .padding(.bottom)
                        
                        SecureField("New Password", text: $password)
                            .padding(.bottom)
                        
                        SecureField("Confirm Password", text: $password)
                            .padding(.bottom)
                    }
                    .padding(.horizontal, 20)
                    
                    // Settings
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
                        
                        Picker(selection: .constant(0), label: Text("Language")) {
                            Text("English").tag(0)
                            Text("Deutsch").tag(1)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .navigationBarTitle(Text("Profile"))
            }
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
