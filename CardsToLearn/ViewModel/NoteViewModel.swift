//
//  NoteViewModel.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI
import CoreData

//class NoteViewModel: ObservableObject {
//    @Published var currentTab: String = "Today"
//    
//    @Published var openEditNote: Bool = false
//    @Published var noteTitle: String = ""
//    @Published var noteColor: String = "Blue"
//    @Published var noteDeadline: Date = Date()
//    @Published var noteType: String = "Basic"
//    
//    @Published var showDatePicker: Bool = false
//    
//    @Published var editNote: Note?
//    
//    func addNote(context: NSManagedObjectContext) -> Bool{
//        
//        var note: Note!
//        if let editNote = editNote{
//            note = editNote
//        }else {
//            let note = Note(context: context)
//        }
//        
//        
//        note.title = noteTitle
//        note.color = noteColor
//        note.deadline = noteDeadline
//        note.type = noteType
//        note.isCompleted = false
//        
//        if let _ = try? context.save() {
//            return true
//        }
//        return false
//    }
//    
//    func resetNote(){
//        noteType = "Basic"
//        noteColor = "Green"
//        noteTitle = ""
//        noteDeadline = Date()
//    }
//    
//    func setUpNote(){
//        if let editNote = editNote {
//            noteType = editNote.type ?? "Basic"
//            noteColor = editNote.color ?? "Green"
//            noteTitle = editNote.title ?? ""
//            noteDeadline = editNote.deadline ?? Date()
//        }
//    }
//}
