//
//  RegisterView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 28.04.23.
//


import SwiftUI
import CoreData

struct RegisterView: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var isRegistered = false
    
    let genderOptions = ["Männlich", "Weiblich"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Account Information")) {
                    TextField("Username", text: $firebaseViewModel.username)
                    TextField("Email", text: $firebaseViewModel.email)
                    TextField("Surname", text: $firebaseViewModel.surname)
                    TextField("Lastname", text: $firebaseViewModel.lastname)
                    SecureField("Password", text: $firebaseViewModel.password)
                }
                
                Section(header: Text("Personal Information")) {
                    DatePicker("Birthdate", selection: $firebaseViewModel.birthdate, in: ...Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                    Picker("Gender", selection: $firebaseViewModel.gender) {
                        ForEach(genderOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Register") {
                        if firebaseViewModel.username.isEmpty || firebaseViewModel.email.isEmpty || firebaseViewModel.surname.isEmpty || firebaseViewModel.lastname.isEmpty || firebaseViewModel.password.isEmpty {
                            // Wenn ein Feld leer ist, zeige einen Alert an
                            showAlert(title: "Fehler", message: "Bitte füllen Sie alle Felder aus.")
                        } else if firebaseViewModel.password.count < 6 {
                            // Wenn das Passwortfeld weniger als 6 Zeichen enthält, zeige einen Alert an
                            showAlert(title: "Fehler", message: "Das Passwort muss mindestens 6 Zeichen enthalten.")
                        } else if !firebaseViewModel.email.contains("@") {
                            // Wenn die E-Mail-Adresse kein @ enthält, zeige einen Alert an
                            showAlert(title: "Fehler", message: "Bitte geben Sie eine gültige E-Mail-Adresse ein.")
                        } else {
                            // Führe die Registrierung aus, wenn alle Bedingungen erfüllt sind
                            do {
                                try firebaseViewModel.signUp()
                                firebaseViewModel.saveUser()
                                firebaseViewModel.clearAllLoginField()
                                isRegistered = true
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .navigationBarTitle("Register")
            .alert(isPresented: $isRegistered) {
                Alert(
                    title: Text("Erfolgreich registriert"),
                    message: Text("Sie haben sich erfolgreich registriert."),
                    dismissButton: .default(Text("OK")) {
                        // Code, um zur Login-Ansicht zurückzukehren
                        isRegistered = false // Setze die isRegistered-Flag auf false, um die Navigation auszulösen
                    }
                )
            }
            .background(
                NavigationLink(
                    destination: LoginView(),
                    isActive: $isRegistered,
                    label: { EmptyView() }
                )
            )
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
}
