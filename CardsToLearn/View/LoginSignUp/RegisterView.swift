//
//  RegisterView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 28.04.23.
//


import SwiftUI
import CoreData

struct RegisterView: View {
    // Zugriff auf den verwalteten Kontext des Core Data-Stacks
    @Environment(\.managedObjectContext) private var viewContext
    
    // State Variablen für die Benutzerdaten
    @State private var username = ""
    @State private var email = ""
    @State private var surname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var birthdate = Date()
    @State private var gender = "Männlich"
    @State private var isRegistered = false

    // Optionen für das Geschlecht
    let genderOptions = ["Männlich", "Weiblich"]

    var body: some View {
        NavigationView {
            // Form ist eine View, die eine Gruppe von steuerbaren Benutzeroberflächenelementen wie TextField, SecureField, Picker und Toggle enthält. Sie ist dafür gedacht, Informationen von Benutzern zu sammeln oder anzuzeigen
            Form {
                // Abschnitt für Account-Informationen
                // Section ist eine View, die verwendet wird, um eine Gruppierung von Inhalten in einer Form zu erstellen. Sie können beispielsweise einen Header-Text definieren, um eine Untergruppe von Inhalten zu kennzeichnen. Dies macht es einfacher, die Inhalte der Form zu organisieren und dem Benutzer eine bessere Navigation zu ermöglichen.
                Section(header: Text("Account Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextField("Surname", text: $surname)
                    TextField("Lastname", text: $lastname)
                    SecureField("Password", text: $password)
                }

                // Abschnitt für persönliche Informationen
                Section(header: Text("Personal Information")) {
                    DatePicker("Birthdate", selection: $birthdate, in: ...Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Button zum Registrieren des Benutzers
                Section {
                    Button("Register") {
                        let user = User(context: viewContext) // Erstelle eine neue Benutzerinstanz im Core Data-Stack
                        user.username = username
                        user.email = email
                        user.surname = surname
                        user.lastname = lastname
                        user.password = password
                        user.birthdate = birthdate
                        user.gender = gender
                        do {
                            try viewContext.save() // Speichern des neuen Benutzers im Core Data-Stack
                            isRegistered = true // Setzen des Registrierungsschalters auf "true"
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .navigationBarTitle("Register") // Titel der Navigationsleiste
            .alert(isPresented: $isRegistered) {
                //Alert: Eine View, die dazu verwendet wird, dem Benutzer eine wichtige Nachricht anzuzeigen. Wenn ein bestimmtes Ereignis eintritt, kann eine Alert-View angezeigt werden, um den Benutzer über die Situation zu informieren. Der Benutzer kann die Alert-View durch Tippen auf eine Schaltfläche schließen.
                Alert(
                    title: Text("Erfolgreich registriert"), // Erfolgsmeldung
                    message: Text("Sie haben sich erfolgreich registriert."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
