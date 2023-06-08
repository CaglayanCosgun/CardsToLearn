//
//  ContentView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import CoreData


//TODO Filter bei den Cards und Quiz ,für jeden Nutzer eine ID anlegen

struct ContentView: View {
    
    @EnvironmentObject var viewModel: CardViewModel
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @EnvironmentObject var quizViewModel: QuizViewModel
    @EnvironmentObject var quotesViewModel: ApiQuotesViewModel
    
    @State var isPresentingCardCreateView = false
    @State var selectedCard: Card?
    @State var selectedCategory: String?
    @State var showSplashScreen = true
    @State var showWelcomeScreen = true
    
    @State var animate = false
    @State var endSplash = false

    var body: some View {
        ZStack {
            if showSplashScreen {
                Logo()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            withAnimation {
                                showSplashScreen = false
                                showWelcomeScreen = false
                            }
                        }
                    }
            } else if firebaseViewModel.loggedIn {
                if showWelcomeScreen {
                    Splash()
                        .onTapGesture {
                            showWelcomeScreen = true
                        }
                } else {
                    ZStack{
                        AnimateSplash()
                        
                        ZStack{
                            Color("black")
                            
                            Image("cards")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: animate ? .fill : .fit)
                                .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                                .scaleEffect(animate ? 3 : 1)
                                .frame(width: UIScreen.main.bounds.width)
                        }
                        .ignoresSafeArea(.all, edges: .all)
                        .onAppear(perform: animateSplash)
                        .opacity(endSplash ? 0 : 1)
                        
                        if !endSplash {
                            Text("Loading...")
                        } else {
                            
                               BaseView()
                            
 
                        }
                    }
                }
            } else {
                LoginSignUpView()
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true )
            }
        }
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.easeOut(duration: 0.55)) {
                animate.toggle()
            }
            
            withAnimation(Animation.linear(duration: 0.45)) {
                endSplash.toggle()
            }
        }
    }
}



//NavigationView {
//    ZStack {
//        if showSplashScreen {
//            Logo()
//                .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                        withAnimation {
//                            showSplashScreen = false
//                            showWelcomeScreen = false
//                        }
//                    }
//                }
//        } else if firebaseViewModel.loggedIn {
//            if showWelcomeScreen {
//                Splash()
//                    .onTapGesture {
//                        showWelcomeScreen = true
//                    }
//            } else {
//               Home()
//
//            }
//        } else {
//            LoginSignUp()
//        }
//    }
//}
