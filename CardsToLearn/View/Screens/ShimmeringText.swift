//
//  ShimmeringText.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 04.05.23.
//

import SwiftUI

struct ShimmeringText: View {
    let text: String // der anzuzeigende Text
    @State private var isAnimating = false // ein Zustand, um den Animationsstatus zu speichern
    
    var body: some View {
        ZStack { // ZStack für die Schichten von Ansichten
            LinearGradient(gradient: Gradient(colors: [.clear, .white, .clear]), startPoint: .leading, endPoint: .trailing) // ein Verlauf mit klaren, weißen und klaren Farben
                .frame(width: 200, height: 50) // Breite und Höhe des Verlaufs
                .rotationEffect(.degrees(70)) // um 70 Grad drehen
                .offset(x: isAnimating ? 150 : -50, y: 0) // abhängig vom Animationsstatus nach rechts oder links verschieben
                .opacity(isAnimating ? 1.0 : 0.2) // abhängig vom Animationsstatus die Opazität ändern
            Text(text) // der Text, der über dem Verlauf angezeigt wird
                .font(.headline) // Schriftgröße
                .foregroundColor(.black) // Schriftfarbe
                .opacity(isAnimating ? 0.2 : 1.0) // abhängig vom Animationsstatus die Opazität ändern
        }
        .onAppear() { // aufgerufen, wenn die Ansicht angezeigt wird
            withAnimation(Animation.linear(duration: 2.0)) { // eine lineare Animation mit einer Dauer von 2 Sekunden starten
                self.isAnimating = true // den Animationsstatus auf "true" setzen
            }
        }
        .onDisappear() { // aufgerufen, wenn die Ansicht aus dem Bildschirm verschwindet
            self.isAnimating = false // den Animationsstatus auf "false" setzen
        }
    }
}
