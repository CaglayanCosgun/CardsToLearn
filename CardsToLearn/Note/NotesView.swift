//
//  NotesView.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI
import CoreData

//struct NotesView: View {
//    @StateObject var noteModel: NoteViewModel = .init()
//    @Namespace var animation
//    
//    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Note.deadline, ascending: false)],predicate: nil,animation: .easeInOut) var notes: FetchedResults<Note>
//    
//    @Environment(\.self) var env
//    
//    var body: some View {
//        ScrollView(.vertical,showsIndicators: false) {
//            VStack{
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Welcome Back")
//                        .font(.callout)
//                    
//                    Text("Heres Update Today")
//                        .font(.title2.bold())
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.vertical)
//                
//                CustomSegmentedBar()
//                    .padding(.top,5)
//            }
//            .padding()
//        }
//        .overlay(alignment: .bottom) {
//            
//            Button {
//                noteModel.openEditNote.toggle()
//            }label: {
//                Label {
//                    Text("Add Note")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                }icon: {
//                    Image(systemName: "plus.app.fill")
//                }
//                .foregroundColor(.white)
//                .padding(.vertical,12)
//                .padding(.horizontal)
//                .background(.black,in: Capsule())
//            }
//            .padding(.top,10)
//            .frame(maxWidth: .infinity)
//            .background{
//                LinearGradient(colors: [
//                    .white.opacity(0.05),
//                    .white.opacity(0.4),
//                    .white.opacity(0.7),
//                    .white
//                ], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//            }
//        }
//        .fullScreenCover(isPresented: $noteModel.openEditNote) {
//            noteModel.resetNote()
//        }content: {
//            AddNewNote()
//                .environmentObject(noteModel)
//        }
//    }
//    
//    @ViewBuilder
//    func NoteView() -> some View {
//        LazyVStack(spacing: 20) {
//            DynamicFilteredView(currentTab: noteModel.currentTab) { (note: Note) in NotesRowView(note: note)
//                
//            }
//        }
//        .padding(.top,20)
//    }
//    @ViewBuilder
//    func NotesRowView(note: Note) -> some View {
//        VStack(alignment: .leading,spacing: 10){
//            HStack{
//                Text(note.type ?? "")
//                    .font(.callout)
//                    .padding(.vertical,5)
//                    .padding(.horizontal)
//                    .background{
//                        Capsule()
//                            .fill(.white.opacity(0.3))
//                    }
//                
//                Spacer()
//                if !note.isCompleted && noteModel.currentTab != "Failed"{
//                    Button {
//                        noteModel.editNote = note
//                        noteModel.openEditNote = true
//                        noteModel.setUpNote()
//                    }label: {
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
//            Text(note.title ?? "")
//                .font(.title2.bold())
//                .foregroundColor(.black)
//                .padding(.vertical,10)
//            
//            HStack(alignment: .bottom,spacing: 0 ) {
//                VStack(alignment: .leading, spacing: 10) {
//                    Label {
//                        Text((note.deadline ?? Date()).formatted(date:.long,time:.omitted))
//                    }icon: {
//                        Image(systemName: "calendar")
//                    }
//                    .font(.caption)
//                    
//                    Label {
//                        Text((note.deadline ?? Date()).formatted(date:.omitted,time:.shortened))
//                    }icon: {
//                        Image(systemName: "clock")
//                    }
//                    .font(.caption)
//                }
//                .frame(maxWidth:.infinity,alignment: .leading)
//                
//                if !note.isCompleted && noteModel.currentTab != "Failed"{
//                    Button {
//                        note.isCompleted.toggle()
//                        try? env.managedObjectContext.save()
//                    }label: {
//                        Circle()
//                            .strokeBorder(.black,lineWidth: 1.5)
//                            .frame(width: 25,height: 25)
//                            .contentShape(Circle())
//                    }
//                }
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//        .background {
//            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                .fill(Color(note.color ?? "Green"))
//        }
//        
//        
//    }
//    
//    
//    @ViewBuilder
//    func CustomSegmentedBar() -> some View {
//        let tabs = ["Today","Upcoming","Done","Failed"]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self) { tab in
//                Text(tab)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .scaleEffect(0.9)
//                    .foregroundColor(noteModel.currentTab == tab ? .white : .black)
//                    .padding(.vertical,6)
//                    .frame(maxWidth: .infinity)
//                    .background{
//                        if noteModel.currentTab == tab {
//                            Capsule()
//                                .fill(.black)
//                                .matchedGeometryEffect(id: "TAB", in: animation)
//                        }
//                    }
//                    .contentShape(Capsule())
//                    .onTapGesture {
//                        withAnimation{noteModel.currentTab = tab}
//                    }
//            }
//        }
//        
//    }
//}
//
//struct NotesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesView()
//            .environmentObject(NoteViewModel())
//    }
//}
//
