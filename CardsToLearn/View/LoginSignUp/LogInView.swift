//
//  LogInView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.05.23.
//

import SwiftUI

struct LoginView: View { // Deklaration der View mit dem Namen "LoginView"
    @State private var email = "" // Deklaration einer @State-Variable mit dem Namen "email" und einem leeren String als Standardwert
    @State private var password = "" // Deklaration einer @State-Variable mit dem Namen "password" und einem leeren String als Standardwert
    @State private var isAnimating = false // Deklaration einer @State-Variable mit dem Namen "isAnimating" und dem Boolean-Wert "false" als Standardwert
    
    var body: some View { // Die View wird deklariert
        ZStack { // ZStack erstellt eine Schicht für die anderen Views in der View-Hierarchie
            LinearGradient( // Hintergrund mit einem Farbverlauf wird definiert
                gradient: Gradient(colors: [.gray, .white,.blue]), // Gradient mit den Farben Grau, Weiß und Blau
                startPoint: .topLeading, // Anfangspunkt des Farbverlaufs
                endPoint: .bottomTrailing // Endpunkt des Farbverlaufs
            )
            .ignoresSafeArea() // Der Farbverlauf soll die SafeArea ignorieren
            VStack(spacing: 20) { // Eine vertikale StackView mit einem Abstand von 20 zwischen den Elementen wird erstellt
                Image(systemName: "book") // Ein Symbol aus dem SF-Symbol-Set wird erstellt
                    .resizable() // Das Symbol kann skaliert werden
                    .frame(width: 100, height: 100) // Die Größe des Symbols wird festgelegt
                    .scaledToFit() // Das Symbol wird so skaliert, dass es in den Rahmen passt
                    .padding(.top, 50) // Das Symbol wird um 50 Punkte von oben gepaddet
                    .shadow(radius: 10) // Das Symbol erhält einen Schatten mit einem Radius von 10 Punkten
                    
                VStack(spacing: 10) { // Eine weitere vertikale StackView mit einem Abstand von 10 zwischen den Elementen wird erstellt
                    TextField("Email", text: $email) // Ein Textfeld wird erstellt, das den Inhalt der @State-Variable "email" enthält
                        .padding() // Das Textfeld erhält einen Innenabstand von 10 Punkten
                        .background(Color.white) // Das Textfeld erhält eine weiße Hintergrundfarbe
                        .cornerRadius(10) // Das Textfeld erhält eine abgerundete Ecke mit einem Radius von 10 Punkten
                        .shadow(radius: 5) // Das Textfeld erhält einen Schatten mit einem Radius von 5 Punkten
                    
                    SecureField("Password", text: $password) // Ein sicheres Textfeld wird erstellt, das den Inhalt der @State-Variable "password" enthält
                        .padding() // Das sichere Textfeld erhält einen Innenabstand von 10 Punkten
                        .background(Color.white) // Das sichere Textfeld erhält eine weiße Hintergrundfarbe
                        .cornerRadius(10) // Das sichere Textfeld erhält eine abgerundete Ecke mit einem Radius von 10 Punkten
                        .shadow(radius: 5) // Das sichere Textfeld erhält einen Schatten mit einem Radius von 5 Punkten
                    
                    

                    
                    HStack {
                        Spacer() // Ein Leerzeichen am rechten Rand des HStack hinzufügen
                        Button(action: {}) { // Button erstellen
                            Text("Passwort vergessen?") // Button-Text erstellen
                                .font(.footnote) // Schriftgröße des Button-Texts einstellen
                                .foregroundColor(.black) // Schriftfarbe des Button-Texts einstellen
                                .shadow(radius: 2) // Schatteneffekt auf den Button-Text anwenden
                        }
                        .padding(.top, 5) // Einen Abstand von 5pt nach oben hinzufügen
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
