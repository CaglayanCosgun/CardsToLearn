//
//  CardsToLearnApp.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import FirebaseCore
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CardsToLearnApp: App {
    @StateObject var quizVM = QuizViewModel()
    @StateObject var cardVM = CardViewModel()
    @StateObject var registerVM = RegisterViewModel()
    @StateObject var firebaseVM = FireBaseViewModel()
    @StateObject var apiVM = ApiCallViewModel()
    @StateObject var wordsApiVM = ApiWordViewModel()
    @StateObject var quotesApiVM = ApiQuotesViewModel()
    @StateObject var noteVM = NoteViewModel()
  

    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizVM)
                .environmentObject(cardVM)
                .environmentObject(registerVM)
                .environmentObject(firebaseVM)
                .environmentObject(apiVM)
                .environmentObject(wordsApiVM)
                .environmentObject(quotesApiVM)
                .environmentObject(noteVM)
                
        }
    }
}
