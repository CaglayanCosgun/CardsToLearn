//
//  LoginSignUpView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 08.06.23.
//

import SwiftUI

struct LoginSignUpView: View {
    
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    
    @State private var isRegistered = false
    @State private var signUp = false
    
    @State private var showPassword = false
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center,vertical: .top)){
            
            ZStack{
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                    
                    Color("gray1")
                    
                        .clipShape(CShapeLogin())
                    
                    Path{path in
                        
                        path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120, y: UIScreen.main.bounds.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                        
                    }
                    .fill(Color.white)
                    
                    Button{
                        
                        withAnimation(.easeIn){
                            signUp = false
                        }
                        
                    }label: {
                        Image(systemName: signUp ? "xmark" : "person.fill")
                            .font(.system(size: 25,weight: .bold))
                            .foregroundColor(Color("gray1"))
                    }
                    .offset(x: -110,y: -50)
                    .disabled(signUp ? false : true)
                    
                    Button{
                        
                        withAnimation(.easeOut){
                            
                            signUp = true
                        }
                        
                    }label: {
                        Image(systemName: signUp ? "person.badge.plus.fill" : "xmark")
                            .font(.system(size: signUp ? 26 : 25,weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: -30,y: -40)
                    .disabled(signUp ? true : false)
                }
                
                VStack(alignment: .leading, spacing: 25){
                    
                    Text("Login")
                        .font(.system(size: 35,weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Email")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        
                        TextField("Email",text: $firebaseViewModel.email)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        
                        SecureField("Password",text: $firebaseViewModel.password)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    HStack{
                        
                        Spacer()
                        
                        Button{
                            
                            firebaseViewModel.login()
                            
                            // Check, ob der Login erfolgreich war
                            if firebaseViewModel.loggedIn {
                                showAlert = false
                            } else {
                                showAlert = true
                            }
                            
                        }label: {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(Color("gray1"))
                                .padding(.vertical)
                                .padding(.horizontal,45)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 0)
                    
                }
                .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 25)
                .padding()
            }
                
            .offset(y: signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
            .zIndex(1)
            
            VStack(alignment: .leading, spacing: 25){
                
                Text("Sign Up")
                    .font(.system(size: 35,weight: .bold))
                    .foregroundColor(Color("gray1"))
                
                Text("Email")
                    .foregroundColor(Color("gray1"))
                    .padding(.top,10)
                
                VStack{
                    
                    TextField("Email",text: $firebaseViewModel.email)
                    
                    Divider()
                        .background(Color("gray1").opacity(0.5))
                }
                
                Text("Password")
                    .foregroundColor(Color("gray1"))
                    .padding(.top,10)
                
                VStack{
                    
                    SecureField("Password",text: $firebaseViewModel.password)
                    
                    Divider()
                        .background(Color("gray1").opacity(0.5))
                }
                
                Text("Re-Password")
                    .foregroundColor(Color("gray1"))
                    .padding(.top,10)
                
                VStack{
                    
                    SecureField("Re-Password",text: $firebaseViewModel.rePassword)
                    
                    Divider()
                        .background(Color("gray1").opacity(0.5))
                }
                
                HStack{
                    
                    Spacer()
                    
                    Button{
                        
                        if  firebaseViewModel.email.isEmpty || firebaseViewModel.password.isEmpty || firebaseViewModel.rePassword.isEmpty {
                            // Wenn ein Feld leer ist, zeige einen Alert an
                            showAlert(title: "Fehler", message: "Bitte füllen Sie alle Felder aus.")
                        } else if firebaseViewModel.password.count < 6 {
                            // Wenn das Passwortfeld weniger als 6 Zeichen enthält, zeige einen Alert an
                            showAlert(title: "Fehler", message: "Das Passwort muss mindestens 6 Zeichen enthalten.")
                        } else if firebaseViewModel.rePassword.count < 6{
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
                        
                    }label: {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,45)
                            .background(Color("gray1"))
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                }
                .padding(.top)
                
                Spacer(minLength: 0)
                
            }
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
            .padding()
            
            
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Falsche E-Mail oder Passwort"),
                message: Text("Bitte überprüfe deine Eingaben und versuche es erneut."),
                dismissButton: .default(Text("OK"))
            )
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(signUp ? .light : .dark)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

struct LoginSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignUpView()
    }
}
