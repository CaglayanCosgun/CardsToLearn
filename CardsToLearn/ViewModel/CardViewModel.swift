//
//  CardViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 05.04.23.
//

import SwiftUI
import CoreData

class CardViewModel: ObservableObject {
    let persistentContainer: NSPersistentContainer
    @Published var cards = [Card]()
    @Published var editCard: Card?
    private var categoriesSet = [String]()
    var categories: [String] {
        categoriesSet
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "FlashCard")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error.localizedDescription)")
            }
            print("loadPersistenStores was successful")
            self.loadCards()
        }
    }
    
    func loadCards() {
        let request = NSFetchRequest<Card>(entityName: "Card")
        
        do {
            cards = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("loading the data failed: \(error)")
        }
    }
    
    func addCard(category: String, question: String, answer: String) {
        let newCard = Card(context: persistentContainer.viewContext)
        newCard.category = category
        newCard.question = question
        newCard.answer = answer
        
        do {
            try persistentContainer.viewContext.save()
            // Füge die neue Karte manuell zur `cards`-Sammlung hinzu
            cards.append(newCard)
            // Rufe `loadCards()` auf, um die `cards`-Sammlung neu zu laden
            loadCards()
        } catch let error {
            print("Error saving new card: \(error.localizedDescription)")
        }
    }
    
    func deleteCard(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Fehler beim Löschen einer KarteiKarte")
            return
        }
        
        let cardToDelete = cards[index]
        persistentContainer.viewContext.delete(cardToDelete)
        
        do {
            try persistentContainer.viewContext.save()
            cards.remove(at: index)
        } catch {
            print("Error while deleting a card: \(error)")
        }
    }



    
    func saveCard(_ card: Card) {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error saving card: \(error.localizedDescription)")
        }
    }
    
    func filteredCards(forCategory category: String?) {
        if let category = category {
        cards = cards.filter { $0.category == category }
        } 
    }
}
