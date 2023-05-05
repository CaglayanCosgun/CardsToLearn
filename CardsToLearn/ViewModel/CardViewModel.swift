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
    
    private func loadCards() {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        let sort = NSSortDescriptor(key: "question", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            cards = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
    }

    
    func addCard(category: String, question: String, answer: String) {
        let newCard = Card(context: persistentContainer.viewContext)
        newCard.category = category
        newCard.question = question
        newCard.answer = answer
        
        do {
            try persistentContainer.viewContext.save()
            cards.append(newCard)
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
            loadCards()
        } catch {
            print("Error while deleting a todo \(error)")
        }
    }


    
    func saveCard(_ card: Card) {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error saving card: \(error.localizedDescription)")
        }
    }
    func filteredCards(forCategory category: String?) -> [Card] {
            if let category = category {
                return cards.filter { $0.category == category }
            } else {
                return cards
            }
        }
}
