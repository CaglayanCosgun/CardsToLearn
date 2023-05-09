//
//  CategoryHeaderView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct CategoryHeaderView: View {
    let category: String   // Die Kategorie, die in der Überschrift angezeigt wird

    var body: some View {
        HStack {   // Eine horizontale Anordnung von Ansichten
            Text(category)   // Eine Textansicht mit dem Kategorienamen
                .font(.headline)   // Die Schriftart und -größe des Textes
            Spacer()   // Füllt den verfügbaren Platz mit Leerzeichen
            Image(systemName: "chevron.down")   // Ein Symbol für eine Pfeil nach unten
                .foregroundColor(.gray)   // Die Farbe des Symbols
        }
        .padding(.vertical, 8)   // Der vertikale Abstand der Ansicht
        .onTapGesture {   // Eine Geste, die ausgeführt wird, wenn auf die Ansicht getippt wird
            // TODO: Alle Karten der gewählten Kategorie anzeigen
        }
    }
}


struct CategoryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHeaderView(category: "Test")
    }
}
