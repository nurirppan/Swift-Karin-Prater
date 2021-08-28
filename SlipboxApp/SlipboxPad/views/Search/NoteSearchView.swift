//
//  NoteSearchView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import SwiftUI

struct NoteSearchView: View {
    
    @EnvironmentObject var nav: NavigationSearchManager
    
    init(pred: NSPredicate) {
        let request = Note.fetch(pred)
        self._notes = FetchRequest(fetchRequest: request)
    }

    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>
    
    var body: some View {
        VStack {
            
            List {
                ForEach(notes) { note in
                    NavigationLink(
                        destination: SmallNoteView(note: note),
                        label: {
                            NoteRow(note: note, selectedNote: $nav.selectedNote)
                        })
                }
            }
            
            if notes.count == 0 {
                Text("Sorry, could not find note for search.")
            }
        }.navigationTitle("Search results")
    }
}

struct NoteSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NoteSearchView(pred: .all)
            .environmentObject(NavigationSearchManager())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
