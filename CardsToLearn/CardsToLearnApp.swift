//
//  CardsToLearnApp.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import FirebaseCore


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
    //@StateObject var firebaseVM = FireBaseViewModel()
    @StateObject var cardVM = CardViewModel()
    @StateObject var registerVM = RegisterViewModel()
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizVM)
                //.environmentObject(firebaseVM)
                .environmentObject(cardVM)
                .environmentObject(registerVM)
        }
    }
}
