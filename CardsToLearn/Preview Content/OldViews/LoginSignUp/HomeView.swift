//
//  HomeView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 26.05.23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var vocabulary = [Date: String]() // Vokabeln für jeden ausgewählten Tag
    @EnvironmentObject var wordVM: ApiWordViewModel
    @EnvironmentObject var cardVM: CardViewModel // Ein CardViewModel-Objekt zur Verarbeitung der Karten
    @EnvironmentObject var quizVM: QuizViewModel // Ein QuizViewModel-Objekt zur Verarbeitung der Quizze
    @EnvironmentObject var quotesVM: ApiQuotesViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Relax()
                    .padding(.top, 20)
                
                Divider()
                
                NotesView()
                    .frame(height: 700)
                
                Divider()
                
                LearningTipsView().frame(height: 700)
                
                Divider()
                
//                if let lastPlayedQuiz = quizVM.quizzes.last {
//                    VStack(spacing: 10) {
//                        Text("Zuletzt gespieltes Quiz:")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                            .fontWeight(.bold)
//
//                        Text(lastPlayedQuiz.quizTitle ?? "")
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//                }
//
//                Divider()
//
//                if let lastCreatedCard = cardVM.cards.last {
//                    CardView(card: lastCreatedCard)
//                        .padding()
//                }
            }
            .padding() // Innenabstand für den gesamten Inhalt hinzufügen
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .onAppear {
            cardVM.loadCards() // Lade die Karten beim Erscheinen der Ansicht
            quizVM.fetchQuizzes() // Lade die Quizze beim Erscheinen der Ansicht
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CardView: View {
    let card: Card // Annahme: `Card` ist der Datentyp für eine einzelne Karte
    
    var body: some View {
        Text("Zuletzt erstellte Karte")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .fontWeight(.bold)
            .padding()
        VStack {
            Text(card.category ?? "") // Optionale `String` unwrappen und einen Standardwert verwenden
            Text(card.question ?? "")
            Text(card.answer ?? "")
            // Weitere Inhalte und Anpassungen der Kartenansicht hier hinzufügen
        }
        .frame( height: 100)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}



struct LearningTip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct LearningTipsView2: View {
    let learningTips: [LearningTip] = [
        LearningTip(title: "Tipp 1", description: "Teilt euch den Lernstoff immer in kleine Portionen ein. So habt ihr öfter Erfolge, wenn ihr eine Stoff-Portion abgeschlossen habt."),
        LearningTip(title: "Tipp 2", description: "Macht regelmäßig Lernpausen: Man kann sich höchstens 45 Minuten konzentrieren, alles was ihr dann noch lernt, wird nicht mehr abgespeichert."),
        LearningTip(title: "Tipp 3", description: "Versucht euch möglichst oft Eselsbrücken zu überlegen. Zum Beispiel um euch Jahreszahlen zu merken: 7 5 3, Rom schlüpft aus dem Ei. So könnt ihr das Gelernte leichter wieder abrufen."),
        LearningTip(title: "Tipp 4", description: "Schreibt zum Beispiel Vokabeln oder Formeln ein paar Mal ab."),
        LearningTip(title: "Tipp 5", description: "Haltet euren Arbeitsplatz möglichst ordentlich. Alles was euch vom Lernen ablenken könnte, hat nichts auf eurem Schreibtisch verloren."),
        LearningTip(title: "Tipp 6", description: "Sagt euch das, was ihr lernen müsst, laut vor."),
        LearningTip(title: "Tipp 7", description: "Wenn ihr euch etwas gar nicht merken könnt, dann schreibt es auf einen Zettel und hängt es bei euch Zuhause auf. So lest ihr es euch unbewusst immer wieder durch und merkt es euch leichter."),
    ]

    var body: some View {
        VStack {
            Text("Lerntipps")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .fontWeight(.bold)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(learningTips) { tip in
                        LearningTipCard(tip: tip)
                    }
                }
                .padding()
            }
        }
    }
}

struct LearningTipCard: View {
    let tip: LearningTip

    var body: some View {
        VStack {
            Text(tip.title)
                .font(.headline)
                .padding(.bottom, 8)
            ScrollView {
                Text(tip.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 150, height: 100)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
