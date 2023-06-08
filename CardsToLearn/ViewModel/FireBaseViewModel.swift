//
//  FireBaseViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 15.05.23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class FireBaseViewModel: ObservableObject{
    
    // Referenz auf die Firebase Datenbank
    let db = Firestore.firestore()
    
    // Login  Variablen
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    @Published var username = ""
    @Published var surname = ""
    @Published var lastname = ""
    @Published var gender = ""
    @Published var birthdate = Date()
    @Published var loggedIn = false
    @Published var newPassword = ""
    @Published var confirmNewPassword = ""
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    // der aktuell eingeloggte User
    @Published var currentUser: User? = nil
    
    func login(){
        
        if checkLoginFields(){
            
            Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
                
                guard let strongSelf = self else {return}
                
                if error == nil && authResult != nil{
                    //Todo: statt navPath self ?? FirebaseViewModel
                    self!.currentUser = authResult?.user
                    (self ?? FireBaseViewModel()).loggedIn = true
                }else {
                    print (error?.localizedDescription)
                }
            }
        }else {
            print ("Please check the fields.")
        }
    }
    
    //
    func signUp(){
        if checkSignUpFields(){
            
            Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
                
                guard let strongSelf = self else {return}
            }
        }else {
            print("Please check the fields")
        }
    }
    
    func checkUser(){
        if let user = Auth.auth().currentUser{
            currentUser = user
        }else {
            print ("User is not logged in")
        }
    }
    
    func logout(){
        
        do{
            try  Auth.auth().signOut()
            currentUser = nil
            loggedIn = false
        }catch let signError as NSError{
            print ("Error: \(signError)")
        }
    }
    
    func clearAllLoginField(){
        
        email = ""
        password = ""
        rePassword = ""
        username = ""
        surname = ""
        lastname = ""
        gender = ""
        birthdate = Date()
        
    }
    
    func checkLoginFields() -> Bool{
        if (!email.isEmpty && !password.isEmpty){
            return true
        }
        else {
            return false
        }
    }
    
    func checkSignUpFields() -> Bool {
        
        if (!email.isEmpty && !password.isEmpty){
            
            if (password != password){
                return false
            }
            else {
                return true
            }
        }
        else {
            return false
        }
    }
    
    func saveUser() {
        guard let currentUser = currentUser else {
            print("User is not logged in")
            return
        }
        
        let userDocument = db.collection("Users").document(currentUser.uid)
        let userData: [String: Any] = [
            "email": email,
            "username": username,
            "surname": surname,
            "lastname": lastname,
            "gender": gender,
            "birthdate": birthdate
        ]
        
        userDocument.setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully")
            }
        }
    }
    
    func savePassword() {
        guard let currentUser = currentUser else {
            print("User is not logged in")
            return
        }
        
        if newPassword == confirmNewPassword {
            currentUser.updatePassword(to: newPassword) { [weak self] error in
                guard let strongSelf = self else { return }
                
                if let error = error {
                    strongSelf.showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    strongSelf.showAlert(title: "Success", message: "Password updated successfully")
                    strongSelf.clearPasswordFields()
                }
            }
        } else {
            showAlert(title: "Error", message: "Passwords do not match")
        }
    }
    
    func clearPasswordFields() {
        password = newPassword
        confirmNewPassword = ""
        newPassword = ""
        
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
