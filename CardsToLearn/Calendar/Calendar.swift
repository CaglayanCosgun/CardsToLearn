//
//  Calendar.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI

struct Calendars: View {
    @State var animatedStates: [Bool] = Array(repeating: false, count: 3)
    @Namespace var animation
    @State var selectedDate = Date() // Hinzugefügt, um das ausgewählte Datum zu verfolgen
    
    var body: some View {
        ZStack {
            if animatedStates[0] {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color("black"))
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    .frame(height: 460)
                
                CalendarView(selectedDate: $selectedDate) // Hier wird der CalendarView eingefügt
            }
            
            if !animatedStates[1] {
                RoundedRectangle(cornerRadius: animatedStates[0] ? 30 : 0 , style: .continuous)
                    .fill(Color("black"))
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    .ignoresSafeArea()
            }
        }
        .onAppear(perform: startAnimations)
    }
    
    func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                animatedStates[0] = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                animatedStates[1] = true
            }
        }
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Text("Kalender")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top,70)
                .fontWeight(.heavy)
            
            DatePicker(
                selection: $selectedDate,
                displayedComponents: [.date],
                label: { Text("") }
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .colorScheme(.dark) // Setzt den Dunkelmodus, um die Textfarbe auf Weiß zu ändern
            .accentColor(.white) // Setzt die Akzentfarbe auf Weiß für die ausgewählte Zahl oder den ausgewählten Tag
            .padding(16)
        }
    }
}

struct Calendars_Previews: PreviewProvider {
    static var previews: some View {
        Calendars()
    }
}
