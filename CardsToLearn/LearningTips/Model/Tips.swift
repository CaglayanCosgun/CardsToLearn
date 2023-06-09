//
//  LearningTips.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct Tips: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var imageText: String
    var tipNr: String
    
}

var sampleTips: [Tips] = [

    .init(text: "Teilt euch den Lernstoff immer in kleine Portionen ein. So habt ihr öfter Erfolge, wenn ihr eine Stoff-Portion abgeschlossen habt.", imageText: "one",tipNr: "Tip1"),
    .init(text: "Macht regelmäßig Lernpausen: Man kann sich höchstens 45 Minuten konzentrieren, alles was ihr dann noch lernt, wird nicht mehr abgespeichert.", imageText: "two",tipNr: "Tip2"),
    .init(text:"Versucht euch möglichst oft Eselsbrücken zu überlegen. Zum Beispiel um euch Jahreszahlen zu merken: 7 5 3, Rom schlüpft aus dem Ei. So könnt ihr das Gelernte leichter wieder abrufen.", imageText: "three",tipNr: "Tip3"),
    .init(text:"Schreibt zum Beispiel Vokabeln oder Formeln ein paar Mal ab.", imageText: "four",tipNr: "Tip4"),
    .init(text:"Haltet euren Arbeitsplatz möglichst ordentlich. Alles was euch vom Lernen ablenken könnte, hat nichts auf eurem Schreibtisch verloren.", imageText: "five",tipNr: "Tip5"),
    .init(text:"Sagt euch das, was ihr lernen müsst, laut vor.", imageText: "six",tipNr: "Tip6"),
    .init(text:"Wenn ihr euch etwas gar nicht merken könnt, dann schreibt es auf einen Zettel und hängt es bei euch Zuhause auf. So lest ihr es euch unbewusst immer wieder durch und merkt es euch leichter.",imageText: "seven",tipNr: "Tip7"),
    
]


