//
//  AddNewNote.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 02.06.23.
//

import SwiftUI
import CoreData

//struct AddNewNote: View {
//    @EnvironmentObject var noteModel : NoteViewModel
//    
//    @Environment(\.self) var env
//    @Namespace var animation
//    
//    
//    var body: some View {
//        VStack(spacing: 12){
//            Text("Edit Note")
//                .font(.title3.bold())
//                .frame(maxWidth: .infinity)
//                .overlay(alignment: .leading) {
//                    
//                    Button {
//                        env.dismiss()
//                    } label: {
//                        Image(systemName: "arrow.left")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                    }
//                }
//                .overlay(alignment: .trailing) {
//                    
//                    Button {
//                        if let editNote = noteModel.editNote {
//                            env.managedObjectContext.delete(editNote)
//                            try? env.managedObjectContext.save()
//                            env.dismiss()
//                        }
//                        
//                        env.dismiss()
//                    } label: {
//                        Image(systemName: "trash")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                    }
//                    .opacity(noteModel.editNote == nil ? 0 : 1)
//                }
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Note Color")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                let colors: [String] =  ["Yellow","Orange","Blue","Red","Green","Purple"]
//                
//                HStack(spacing: 15){
//                    ForEach(colors,id:\.self) {color in
//                        Circle()
//                            .fill(Color(color))
//                            .frame(width: 25,height: 25)
//                            .background{
//                                if noteModel.noteColor == color{
//                                    Circle()
//                                        .strokeBorder(.gray)
//                                        .padding(-3)
//                                }
//                            }
//                            .contentShape(Circle())
//                            .onTapGesture{
//                                noteModel.noteColor = color
//                            }
//                    }
//                }
//                .padding(.top,10)
//                
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.top,30)
//            
//            Divider()
//                .padding(.vertical,10)
//            
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Note Deadline")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                Text(noteModel.noteDeadline.formatted(date: .abbreviated,time:.omitted) + ", " + noteModel.noteDeadline.formatted(date: .omitted,time: .shortened))
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                .padding(.top,8)
//                
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .overlay(alignment: .bottomTrailing) {
//                Button {
//                    
//                    noteModel.showDatePicker.toggle()
//                    
//                }label: {
//                    Image(systemName: "calendar")
//                        .foregroundColor(.black)
//                }
//            }
//            
//            Divider()
//            
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Note Title")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                TextField("",text: $noteModel.noteTitle)
//                    .frame(maxWidth: .infinity)
//                .padding(.top,10)
//                
//            }
//            
//            .padding(.top,10)
//            Divider()
//            let noteTypes: [String] = ["Basic","Urgent","Important"]
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Note Type")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                HStack(spacing: 12){
//                    ForEach(noteTypes,id:\.self){type in
//                        Text(type)
//                            .font(.callout)
//                            .padding(.vertical,8)
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(noteModel.noteType == type ? .white : .black)
//                            .background {
//                                if noteModel.noteType == type {
//                                    Capsule()
//                                        .fill(.black)
//                                        .matchedGeometryEffect(id: "TYPE", in: animation)
//                                }else {
//                                    Capsule()
//                                        .strokeBorder(.black)
//                                }
//                            }
//                            .contentShape(Capsule())
//                            .onTapGesture {
//                                withAnimation{noteModel.noteType = type}
//                            }
//                    }
//                }
//                .padding(.top,10)
//            }
//            .padding(.vertical,10)
//            Divider()
//            
//            Button {
//                if noteModel.addNote(context: env.managedObjectContext) {
//                    env.dismiss()
//                }
//            }label: {
//                Text("Save Note")
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical,12)
//                    .foregroundColor(.white)
//                    .background{
//                        Capsule()
//                            .fill(.black)
//                    }
//            }
//            .frame(maxHeight:.infinity, alignment: .bottom)
//            .padding(.bottom,10)
//            .disabled(noteModel.noteTitle == "")
//            .opacity(noteModel.noteTitle == "" ? 0.6 : 1)
//        }
//        .frame(maxHeight: .infinity, alignment: .top)
//        .padding()
//        .overlay{
//            ZStack{
//                if noteModel.showDatePicker {
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .ignoresSafeArea()
//                        .onTapGesture{
//                            noteModel.showDatePicker = false
//                        }
//                    
//                    DatePicker.init("", selection: $noteModel.noteDeadline,in: Date.now...Date.distantFuture)
//                        .datePickerStyle(.graphical)
//                        .labelsHidden()
//                        .padding()
//                        .background(.white,in: RoundedRectangle(cornerRadius: 12, style: .continuous))
//                        .padding()
//                    
//                }
//            }
//            .animation(.easeInOut, value: noteModel.showDatePicker)
//        }
//    }
//}
//
//struct AddNewNote_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewNote()
//            .environmentObject(NoteViewModel())
//    }
//}
