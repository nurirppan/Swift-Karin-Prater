//
//  NoteListView.swift
//  SlipboxApp
//
//  Created by Karin Prater on 26.12.20.
//
import MobileCoreServices

import SwiftUI

struct NoteListView: View {
    init(folder: Folder?, selectedNote: Binding<Note?>) {
        self._selectedNote = selectedNote
        
        var predicate = NSPredicate.none
        if let folder = folder {
            predicate = NSPredicate(format: "%K == %@ ",NoteProperties.folder, folder)
        }
        self._notes = FetchRequest(fetchRequest: Note.fetch(predicate))
        self.folder = folder
    }
    
    let folder: Folder?
    
    @Binding var selectedNote: Note?
    
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var context
    @State private var shouldDeleteNote: Note? = nil
    
    var body: some View {
        List {
            
            ForEach(notes) { note in
                
                NoteRow(note: note, selectedNote: $selectedNote)
                    
                    .onTapGesture {
                        selectedNote = note
                    }
                    .itemProvider({
                        NSItemProvider(object: DataTypeDragItem(id: note.uuid.uuidString, type: DataType.note.rawValue))
                    })
                
            }
            .onInsert(of: [kUTTypeData as String], perform: { index, items in
              _ = notes[index].handleMove(providers: items)
                
            })
            .onDelete(perform: { indexSet in
                if let index = indexSet.first {
                   shouldDeleteNote = notes[index]
                }
            })
            
            .listRowInsets(.init(top: 1, leading: 0, bottom: 3, trailing: 0))
            
            if selectedNote != nil {
                NavigationLink("", destination: SmallNoteView(note: selectedNote!), tag: selectedNote!, selection: $selectedNote)
            }
            
        }.padding(.top)
        
        .alert(item: $shouldDeleteNote) { noteToDelete in
            deleteAlert(note: noteToDelete)
        }
       
        .navigationBarTitle(Text(folder?.name ?? "Notes"), displayMode: .inline)
        .toolbar(content: {
                                
                                Menu(content: {
                                    Button(action: {
                                        //TODO
                                    }, label: {
                                        Text("Rename Folder")
                                    })
                                    Button(action: {
                                        //TODO
                                    }, label: {
                                        Text("Delete Folder")
                                    })
                                    Divider()
                                    
                                    Button(action: {
                                        createNewNote()
                                    }, label: {
                                        Text("Add new Note")
                                    })
                                }, label: {
                                    Image(systemName: "ellipsis.circle")
                                }).disabled(folder == nil)
        }
    )
        
    }
    
    func deleteAlert(note: Note) -> Alert {
        Alert(title: Text("Are you sure to delete this note?"),
              message: nil,
              primaryButton: Alert.Button.cancel(),
              secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                if selectedNote == note {
                    selectedNote = nil
                }
                Note.delete(note: note)
              }))
    }
    
    func createNewNote() {
        let note = Note(title: "new note", context: context)
        
        folder?.add(note: note, at: selectedNote?.order)
        selectedNote = note
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(NSPredicate.all)
        let fechtedNotes = try? context.fetch(request)
        let folder = Folder(name: "my Folder", context: context)
        for note in fechtedNotes! {
            folder.add(note: note)
        }
        
        return
            NavigationView {
            NoteListView(folder: folder, selectedNote: .constant(fechtedNotes?.last))
            }
            .previewLayout(.fixed(width: 400, height: 600))
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.managedObjectContext, context)
            .environmentObject(NavigationStateManager())
    }
}
