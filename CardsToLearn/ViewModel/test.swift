//
//  test.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 03.06.23.
//

import SwiftUI
import CoreData

class NoteViewModel: ObservableObject {
    let persistentContainer: NSPersistentContainer
    @Published var notes = [Note]()
    
    @Published var currentTab: String = "Today"
    
    @Published var openEditNote: Bool = false
    
    @Published var showDatePicker: Bool = false
    
    @Published var editNote: Note?
    
    @Published var noteTitle: String = ""
    @Published var noteColor: String = "Blue"
    @Published var noteDeadline: Date = Date()
    @Published var noteType: String = "Basic"
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Notes")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error.localizedDescription)")
            }
            print("loadPersistentStores was successful")
            self.loadNotes()
        }
    }
    
    func loadNotes() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            notes = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Loading the data failed: \(error)")
        }
    }
    
    func addNote(title: String, color: String, deadline: Date, type: String, isCompleted: Bool) -> Bool {
        var note: Note!

        if let editNote = editNote {
            note = editNote
        } else {
            note = Note(context: persistentContainer.viewContext)
        }

        note.title = title
        note.color = color
        note.deadline = deadline
        note.type = type
        note.isCompleted = false

        do {
            try persistentContainer.viewContext.save()
            // Füge die neue Notiz manuell zur `notes`-Sammlung hinzu
            // Die `notes`-Sammlung wird automatisch aktualisiert
            return true // Note added successfully
        } catch let error {
            print("Error saving new note: \(error.localizedDescription)")
            return false // Failed to add note
        }
    }


    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Fehler beim Löschen einer Notiz")
            return
        }
        
        let noteToDelete = notes[index]
        persistentContainer.viewContext.delete(noteToDelete)
        
        do {
            try persistentContainer.viewContext.save()
            notes.remove(at: index)
        } catch {
            print("Error while deleting a note: \(error)")
        }
    }
    
    func saveNote(_ note: Note) {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error saving note: \(error.localizedDescription)")
        }
    }
    
    func setupNote() {
        guard let editNote = editNote else {
            return
        }
        
        noteTitle = editNote.title ?? ""
        noteColor = editNote.color ?? "Blue"
        noteDeadline = editNote.deadline ?? Date()
        noteType = editNote.type ?? "Basic"
    }
    
    func resetNote() {
        noteTitle = ""
        noteColor = "Blue"
        noteDeadline = Date()
        noteType = "Basic"
    }
}


struct NotesView: View {
    @StateObject var noteModel: NoteViewModel = .init()
    @Namespace var animation
    
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Note.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var notes: FetchedResults<Note>

    
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack{
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back")
                        .font(.callout)
                    
                    Text("Heres Update Today")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                CustomSegmentedBar()
                    .padding(.top,5)
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            
            Button {
                noteModel.openEditNote.toggle()
            }label: {
                Label {
                    Text("Add Note")
                        .font(.callout)
                        .fontWeight(.semibold)
                }icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(.black,in: Capsule())
            }
            .padding(.top,10)
            .frame(maxWidth: .infinity)
            .background{
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: $noteModel.openEditNote) {
            noteModel.resetNote()
        }content: {
            AddNewNote()
                .environmentObject(noteModel)
        }
    }
    
    @ViewBuilder
    func NoteView() -> some View {
        LazyVStack(spacing: 20) {
            DynamicFilteredView(currentTab: noteModel.currentTab) { (note: Note) in NotesRowView(note: note)
                
            }
        }
        .padding(.top,20)
    }
    @ViewBuilder
    func NotesRowView(note: Note) -> some View {
        VStack(alignment: .leading,spacing: 10){
            HStack{
                Text(note.type ?? "")
                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                if !note.isCompleted && noteModel.currentTab != "Failed"{
                    Button {
                        noteModel.editNote = note
                        noteModel.openEditNote = true
                        noteModel.setupNote()
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            Text(note.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical,10)
            
            HStack(alignment: .bottom,spacing: 0 ) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((note.deadline ?? Date()).formatted(date:.long,time:.omitted))
                    }icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        Text((note.deadline ?? Date()).formatted(date:.omitted,time:.shortened))
                    }icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                if !note.isCompleted && noteModel.currentTab != "Failed"{
                    Button {
                        note.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    }label: {
                        Circle()
                            .strokeBorder(.black,lineWidth: 1.5)
                            .frame(width: 25,height: 25)
                            .contentShape(Circle())
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(note.color ?? "Green"))
        }
        
        
    }
    
    
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today","Upcoming","Done","Failed"]
        HStack(spacing: 10){
            ForEach(tabs,id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(noteModel.currentTab == tab ? .white : .black)
                    .padding(.vertical,6)
                    .frame(maxWidth: .infinity)
                    .background{
                        if noteModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{noteModel.currentTab = tab}
                    }
            }
        }
        
    }
}


struct AddNewNote: View {
    @EnvironmentObject var noteModel : NoteViewModel
    
    @Environment(\.self) var env
    @Namespace var animation
    
    
    var body: some View {
        VStack(spacing: 12){
            Text("Edit Note")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .trailing) {
                    
                    Button {
                        if let editNote = noteModel.editNote {
                            env.managedObjectContext.delete(editNote)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                        
                        env.dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .opacity(noteModel.editNote == nil ? 0 : 1)
                }
            VStack(alignment: .leading, spacing: 12) {
                Text("Note Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let colors: [String] =  ["Yellow","Orange","Blue","Red","Green","Purple"]
                
                HStack(spacing: 15){
                    ForEach(colors,id:\.self) {color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25,height: 25)
                            .background{
                                if noteModel.noteColor == color{
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture{
                                noteModel.noteColor = color
                            }
                    }
                }
                .padding(.top,10)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,30)
            
            Divider()
                .padding(.vertical,10)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Note Deadline")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(noteModel.noteDeadline.formatted(date: .abbreviated,time:.omitted) + ", " + noteModel.noteDeadline.formatted(date: .omitted,time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                .padding(.top,8)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    
                    noteModel.showDatePicker.toggle()
                    
                }label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Note Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("",text: $noteModel.noteTitle)
                    .frame(maxWidth: .infinity)
                .padding(.top,10)
                
            }
            
            .padding(.top,10)
            Divider()
            let noteTypes: [String] = ["Basic","Urgent","Important"]
            VStack(alignment: .leading, spacing: 12) {
                Text("Note Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    ForEach(noteTypes,id:\.self){type in
                        Text(type)
                            .font(.callout)
                            .padding(.vertical,8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(noteModel.noteType == type ? .white : .black)
                            .background {
                                if noteModel.noteType == type {
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                }else {
                                    Capsule()
                                        .strokeBorder(.black)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{noteModel.noteType = type}
                            }
                    }
                }
                .padding(.top,10)
            }
            .padding(.vertical,10)
            Divider()
            
            Button {
                if noteModel.addNote(title: "MyNote", color: "Blue", deadline: Date(), type: "Basic", isCompleted: true) {
                    env.dismiss()
                }
            }label: {
                Text("Save Note")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,12)
                    .foregroundColor(.white)
                    .background{
                        Capsule()
                            .fill(.black)
                    }
            }
            .frame(maxHeight:.infinity, alignment: .bottom)
            .padding(.bottom,10)
            .disabled(noteModel.noteTitle == "")
            .opacity(noteModel.noteTitle == "" ? 0.6 : 1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay{
            ZStack{
                if noteModel.showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture{
                            noteModel.showDatePicker = false
                        }
                    
                    DatePicker.init("", selection: $noteModel.noteDeadline,in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white,in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                    
                }
            }
            .animation(.easeInOut, value: noteModel.showDatePicker)
        }
    }
}
