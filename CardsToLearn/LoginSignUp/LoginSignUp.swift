//
//  LoginSignUp.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI
import CoreData

struct LoginSignUp: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var isRegistered = false
    
    @State var index = 0

    var body: some View {
        
        GeometryReader {_ in
            
            VStack {
                
                Image("applogo")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                ZStack {
                    
                    SignUp(index: self.$index)
                        .zIndex(Double(self.index))
                    Login(index: self.$index)
                    
                }
                
                HStack(spacing: 15) {
                    Rectangle()
                        .fill(Color("gray"))
                        .frame(height: 1)
                    
                    Text("OR")
                    
                    Rectangle()
                        .fill(Color("gray"))
                        .frame(height: 1)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                
                HStack(spacing: 25) {
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("apple")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("facebook")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("twitter")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 30)
            }
            .padding(.vertical)
            
        }
        .background(Color("white").edgesIgnoringSafeArea(.all))
    }
}


struct Login: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var showPassword = false
    @State private var showAlert = false
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                
                HStack {
                    
                    
                    
                    VStack(spacing: 10) {
                        
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .black : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                        
                    }
                    Spacer(minLength: 10)
                    
                }
                .padding(.top,30)
                
                
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName:"envelope.fill")
                            .foregroundColor(Color("white"))
                        
                        TextField("Email Address", text: $firebaseViewModel.email)
                    }
                    
                    Divider().background(Color.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,40)
                
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName:"eye.slash.fill")
                            .foregroundColor(Color("white"))
                        
                        SecureField("Password", text: $firebaseViewModel.password)
                    }
                    
                    Divider().background(Color.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Forget Password ?")
                            .foregroundColor(Color.white.opacity(0.6))
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top,30)
            }
            .padding()
            .padding(.bottom,65)
            .background(Color("lightgray"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius:5, x: 0, y: -5 )
            .onTapGesture {
                self.index = 0
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            Button(action: {
                
                firebaseViewModel.login()
                
                // Check, ob der Login erfolgreich war
                if firebaseViewModel.loggedIn {
                    showAlert = false
                } else {
                    showAlert = true
                }
                
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(Color("gray"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5,x: 0, y: 5)
            }
            .offset(y: 25)
            .opacity(self.index == 0 ? 1 : 0)
            
            
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



struct SignUp: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var isRegistered = false
    @State var email = ""
    @State var pass = ""
    @State var rePass = ""
    @Binding var index : Int
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                
                HStack {
                    
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10) {
                        
                        Text("SignUp")
                            .foregroundColor(self.index == 1 ? .black : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                        
                    }
                }
                .padding(.top,40)
                
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName:"envelope.fill")
                            .foregroundColor(Color("white"))
                        
                        TextField("Email Address", text: $firebaseViewModel.email)
                    }
                    
                    Divider().background(Color.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,70)
                
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName:"eye.slash.fill")
                            .foregroundColor(Color("white"))
                        
                        SecureField("Password", text: $firebaseViewModel.password)
                    }
                    
                    Divider().background(Color.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName:"eye.slash.fill")
                            .foregroundColor(Color("white"))
                        
                        SecureField("Password", text: $firebaseViewModel.newPassword)
                    }
                    
                    Divider().background(Color.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
            }
            .padding()
            .padding(.bottom,65)
            .background(Color("lightgray"))
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3), radius:5, x: 0, y: -5 )
            .onTapGesture {
                self.index = 1
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            Button(action: {
                if  firebaseViewModel.email.isEmpty || firebaseViewModel.password.isEmpty || firebaseViewModel.newPassword.isEmpty {
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
            }) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(Color("gray"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5,x: 0, y: 5)
            }
            .offset(y: 25)
            .opacity(self.index == 1 ? 1 : 0)
            
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}


struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 100))
            
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: rect.width, y: 100))
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}



struct LoginSignUp_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignUp()
    }
}
