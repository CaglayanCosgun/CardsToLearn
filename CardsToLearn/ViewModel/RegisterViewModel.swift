//
//  RegisterViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 11.05.23.
//

import SwiftUI
import CoreData

class RegisterViewModel: ObservableObject {
    
    var container: NSPersistentContainer
    @Published var users: [Users] = []
    
    @Published var username = ""
    @Published var surname = ""
    @Published var lastname = ""
    @Published var password = ""
    @Published var email = ""
    @Published var birthdate = Date()
    @Published var gender = ""
    //@Published var navPath = NavigationPath()
    
    init() {
        container = NSPersistentContainer(name: "Register")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
        
        fetchUsers()
        
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<Users>(entityName: "Users")
        
        do {
            users = try container.viewContext.fetch(request)
        } catch {
            print("Loading the data failed: \(error)")
        }
    }
    
    func saveUsers(birthdate:Date,username:String,lastname:String,surname:String,password:String,gender:String,email:String) {
        
        let newUser = Users(context: container.viewContext)
        newUser.birthdate = birthdate
        newUser.username = username
        newUser.lastname = lastname
        newUser.surname = surname
        newUser.password = password
        newUser.gender = gender
        newUser.email = email
        
        do {
            try container.viewContext.save()
            fetchUsers()
            
        } catch {
            print("Saving User failed: \(error)")
        }
    }
    
    func addUser(birthdate: Date, username: String, lastname: String, surname: String, password: String, gender: String, email: String) -> NSManagedObjectContext {
        let newUser = Users(context: container.viewContext)
        newUser.birthdate = birthdate
        newUser.username = username
        newUser.lastname = lastname
        newUser.surname = surname
        newUser.password = password
        newUser.gender = gender
        newUser.email = email
        
        do {
            try container.viewContext.save()
            // Füge die neue Karte manuell zur `cards`-Sammlung hinzu
            users.append(newUser)
            // Rufe `loadCards()` auf, um die `cards`-Sammlung neu zu laden
            fetchUsers()
            return container.viewContext
        } catch let error {
            print("Error saving new user: \(error.localizedDescription)")
        }
        
        return container.viewContext
    }
    
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Fehler beim Löschen des Users")
            return
        }
        let userToDelete = users[index]
        container.viewContext.delete(userToDelete)
        do {
            try container.viewContext.save()
            
            users.remove(at: index)
            
            fetchUsers()
        } catch {
            print("Error while deleting a User \(error)")
        }
    }
    
    func clearAllLoginFields() {
        users.forEach { user in
            user.username = ""
            user.surname = ""
            user.lastname = ""
            user.birthdate = Date()
            user.password = ""
            user.gender = ""
            user.email = ""
        }
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error clearing login fields: \(error)")
        }
    }
    
    func checkLoginFields() -> Bool {
        guard let firstUser = users.first else {
            return false
        }
        
        return !(firstUser.username?.isEmpty ?? true) && !(firstUser.email?.isEmpty ?? true)
    }
    
    func login() -> Bool {
        do {
            let filteredUsers = try container.viewContext.fetch(Users.fetchRequest()) as? [Users] ?? []
            let matchingUsers = filteredUsers.filter { $0.email == email }
            return !matchingUsers.isEmpty
        } catch {
            print("Error fetching registers: \(error)")
            return false
        }
    }
}
