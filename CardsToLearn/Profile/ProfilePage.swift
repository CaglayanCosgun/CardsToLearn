//
//  ProfilePage.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI


struct ProfilPage: View {
    
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var registerViewModel: RegisterViewModel
    
    @State private var showingAlert = false
    @State private var logoutConfirmed = false
    @State private var showPassword = false
    @State private var showNewPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View{
        
        NavigationStack{
            
            ScrollView(.vertical,showsIndicators: false){
                
                VStack{
                    
                    Text("MyProfile")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 15){
                        
                        Image("User")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60,height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Text("User")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        HStack(alignment: .top, spacing: 10){
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.white)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Adress: Hamburger Straße 9\n22307\nHamburg,DE")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                    
                        Color("gray2")
                            .cornerRadius(12)
                    
                    )
                    .padding()
                    .padding(.top,40)
                    
                    CustomNavigationLink(title: "Change Password"){
                        
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
                                    SecureField("Password", text: $firebaseViewModel.password).padding()
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
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
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                if showNewPassword { // Passwort anzeigen, wenn showPassword true ist
                                    TextField("New Password", text: $firebaseViewModel.newPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                                } else { // Sonst sicheres Textfeld anzeigen
                                    SecureField("New Password", text: $firebaseViewModel.newPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
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
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                if showConfirmPassword { // Passwort anzeigen, wenn showPassword true ist
                                    TextField("Confirm Password", text: $firebaseViewModel.confirmNewPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                                } else { // Sonst sicheres Textfeld anzeigen
                                    SecureField("Confirm Password", text: $firebaseViewModel.confirmNewPassword)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
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
                        
                        Button(action: {
                            firebaseViewModel.savePassword()
                            
                        }) {
                            Text("Save")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("gray1"))
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                                                }
                    
                    CustomNavigationLink(title: "Account Info"){
                        
                        VStack(alignment: .leading,spacing: 12){
                        
                        Text("Konto")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        Divider()
                        
                            VStack(alignment: .leading) {
                            Text("Username:")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            TextField("First Name", text: $firebaseViewModel.surname)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                        }
                        .padding(.bottom)
                        
                            VStack(alignment: .leading,spacing: 12) {
                            Text("Vorname:")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            TextField("Last Name", text: $firebaseViewModel.lastname)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                        }
                        .padding(.bottom)
                        
                            VStack(alignment: .leading,spacing: 12) {
                            Text("Name:")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            TextField("Username", text: $firebaseViewModel.username)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                        }
                        .padding(.bottom)
                            VStack(alignment: .leading,spacing: 12) {
                            Text("Email:")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            TextField("Email", text: $firebaseViewModel.email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                        }
                        .padding(.bottom)
                        
                        Button(action: {
                            showingAlert = true
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
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
                            
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5,x: 0,y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5,x: 0,y: -5)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                        
                        Spacer()
                    }
                        }
                        
                        
                    
                    
                    
                    
                    CustomNavigationLink(title: "Edit Profile"){
                        
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("gray2")
                                .ignoresSafeArea())
                    }
                    
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
            
                Color("gray2")
                    .ignoresSafeArea()
            )
        }
        
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping()->Detail)->some View{
        
        NavigationLink{
            content()
        }label: {
            
            HStack{
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.white)
            .padding()
            .background(
            
                Color("gray2")
                    .cornerRadius(112)
            
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
        
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilPage()
    }
}
