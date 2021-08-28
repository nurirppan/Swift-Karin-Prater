//
//  SmallNoteView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI

struct SmallNoteView: View {
    let note: Note
    
    @Environment(\.managedObjectContext) var context
    @State private var showKeySelection: Bool = false
    
    var body: some View {
       NoteView(note: note)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar(content: {
            Menu {
                
                Button(action: {
                    showKeySelection.toggle()
                }, label: {
                    Text("Add keywords")
                })
                Button(action: {
                    //TODO
                }, label: {
                    Text("Add note links")
                })
                
                
                Button(action: {
                //TODO delete alert
                }, label: {
                    Text("Delete Note")
                })
            } label: {
                Image(systemName: "ellipsis.circle")
            }

        })
        
        .sheet(isPresented: $showKeySelection, content: {
            AddKeywordsToNoteView(note: note)
                .environment(\.managedObjectContext, context)
        })
    }
}

struct SmallNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        SmallNoteView(note: Note.defaultNote(context:  PersistenceController.preview.container.viewContext))
        }
            .previewDevice("iPhone 11")
            .environmentObject(NavigationStateManager())
    }
}


   
