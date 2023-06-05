//
//  LearningTips.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI

struct Tips: Identifiable {
    var id = UUID().uuidString
    var tipName: String
    var tipImage: String
    var rating: Int
    var tipText: String
    var showDisk: Bool = false
    var diskOffset: CGFloat = 0
}

var sampleTips: [Tips] = [

    Tips(tipName: "Tip1", tipImage: "one",rating: 1,tipText: "Teilt euch den Lernstoff immer in kleine Portionen ein. So habt ihr öfter Erfolge, wenn ihr eine Stoff-Portion abgeschlossen habt."),
    Tips(tipName: "Tip2", tipImage: "two",rating: 2,tipText: "Macht regelmäßig Lernpausen: Man kann sich höchstens 45 Minuten konzentrieren, alles was ihr dann noch lernt, wird nicht mehr abgespeichert."),
    Tips(tipName: "Tip3", tipImage: "three",rating:3,tipText:"Versucht euch möglichst oft Eselsbrücken zu überlegen. Zum Beispiel um euch Jahreszahlen zu merken: 7 5 3, Rom schlüpft aus dem Ei. So könnt ihr das Gelernte leichter wieder abrufen."),
    Tips(tipName: "Tip4", tipImage: "four",rating:4,tipText:"Schreibt zum Beispiel Vokabeln oder Formeln ein paar Mal ab."),
    Tips(tipName: "Tip5", tipImage: "five",rating:5,tipText:"Haltet euren Arbeitsplatz möglichst ordentlich. Alles was euch vom Lernen ablenken könnte, hat nichts auf eurem Schreibtisch verloren."),
    Tips(tipName: "Tip6", tipImage: "six",rating:6,tipText:"Sagt euch das, was ihr lernen müsst, laut vor."),
    Tips(tipName: "Tip7", tipImage: "seven",rating:7,tipText:"Wenn ihr euch etwas gar nicht merken könnt, dann schreibt es auf einen Zettel und hängt es bei euch Zuhause auf. So lest ihr es euch unbewusst immer wieder durch und merkt es euch leichter.")
]


