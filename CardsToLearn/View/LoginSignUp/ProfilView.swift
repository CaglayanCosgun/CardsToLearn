//
//  ProfilView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct ProfileView: View {
    
    // Properties
    @State private var username: String = "" // Speichert den Nutzernamen
    @State private var firstName: String = "" // Speichert den Vornamen
    @State private var lastName: String = "" // Speichert den Nachnamen
    @State private var email: String = "" // Speichert die E-Mail-Adresse
    @State private var gender: String = "" // Speichert das Geschlecht
    @State private var password: String = "" // Speichert das Passwort
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .white,.gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ) // Verlauf als Hintergrund
            .ignoresSafeArea()
            ScrollView {
                VStack {
                    // Profile Image
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 150, height: 150) // Größe des Profilbilds
                        .foregroundColor(.gray)
                        .padding() // Innenabstand
                    
                    // Welcome Text
                    Text("Welcome, User!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30) // Abstand nach unten
                        .foregroundColor(.black) // Textfarbe
                    
                    // User Information
                    Group {
                        Text("User Information") // Überschrift
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top) // Abstand nach oben
                        
                        Divider() // Horizontale Trennlinie
                        
                        TextField("Username", text: $username) // Nutzername
                            .padding(.bottom) // Abstand nach unten
                        
                        TextField("First Name", text: $firstName) // Vorname
                            .padding(.bottom)
                        
                        TextField("Last Name", text: $lastName) // Nachname
                            .padding(.bottom)
                        
                        TextField("Email", text: $email) // E-Mail-Adresse
                            .padding(.bottom)
                        
                        Text(gender) // Geschlecht
                            .padding(.bottom)
                    }
                    .padding(.horizontal, 20) // Abstand links und rechts
                    
                    // Change Password
                    Group {
                        Text("Change Password") // Überschrift
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top) // Abstand nach oben
                        
                        Divider() // Horizontale Trennlinie
                        
                        SecureField("Current Password", text: $password) // Aktuelles Passwort
                            .padding(.bottom) // Abstand nach unten
                        
                        SecureField("New Password", text: $password) // Neues Passwort
                            .padding(.bottom)
                        
                        SecureField("Confirm Password", text: $password) // Passwort bestätigen
                            .padding(.bottom)
                    }
                    .padding(.horizontal, 20) // Abstand links und rechts
                    
                    // Settings
                    Group {
                        Text("Settings") // Überschrift
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top) // Abstand nach oben
                        
                        Divider() // Horizontale Trennlinie
                        
                        Toggle(isOn: .constant(false)) { // Schalter für Push-Benachrichtigungen
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
                        
                        Button(action: {
                            // Aktion für "Konto löschen"
                        }) {
                            Text("Konto löschen")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
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
