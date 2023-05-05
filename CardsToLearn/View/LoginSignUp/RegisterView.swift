//
//  RegisterView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 28.04.23.
//


import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username = ""
    @State private var email = ""
    @State private var surname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var birthdate = Date()
    @State private var gender = "Männlich"
    @State private var isRegistered = false

    let genderOptions = ["Männlich", "Weiblich"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextField("Surname", text: $surname)
                    TextField("Lastname", text: $lastname)
                    SecureField("Password", text: $password)
                }

                Section(header: Text("Personal Information")) {
                    DatePicker("Birthdate", selection: $birthdate, in: ...Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }


                Section {
                    Button("Register") {
                        let user = User(context: viewContext)
                        user.username = username
                        user.email = email
                        user.surname = surname
                        user.lastname = lastname
                        user.password = password
                        user.birthdate = birthdate
                        user.gender = gender
                        do {
                            try viewContext.save()
                            isRegistered = true
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
            .navigationBarTitle("Register")
            .alert(isPresented: $isRegistered) {
                Alert(
                    title: Text("Erfolgreich registriert"),
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
