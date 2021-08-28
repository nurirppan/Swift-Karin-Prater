//
//  NoteRow.swift
//  SlipboxApp
//
//  Created by Karin Prater on 05.12.20.
//
#if os(iOS)
import MobileCoreServices
#endif

import SwiftUI

struct NoteRow: View {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalClass
    #endif
    
    @Environment(\.managedObjectContext) var context
    @State private var isDropTargeted: Bool = false
    
    @ObservedObject var note: Note
    @Binding var selectedNote: Note?
    
    let selectedColor: Color = Color("selectedColor")
    let unSelectedColor: Color = Color("unselectedColor")
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            HStack {

                Text(note.title)//.bold()
                Spacer()
                Text(note.creationDate , formatter: itemFormatter)
                    .font(.footnote)
                
            }
            #if os(iOS)
            if horizontalClass == .regular {
                Text(note.bodyText)
                    .lineLimit(3)
                    .font(.caption)
            }
            #else
            Text(note.bodyText)
                .lineLimit(3)
                .font(.caption)
            #endif
            
        }
        .padding(5)
        
        .background(RoundedRectangle(cornerRadius: 5).fill(selectedNote == note ? selectedColor : unSelectedColor))
        
        .animation(nil)
        .padding(.top, isDropTargeted ? 50 : 0)
        .animation(.easeInOut)

        .onDrag({ NSItemProvider(object: DataTypeDragItem(id: note.uuid.uuidString, type: DataType.note.rawValue)) })

        .onDrop(of: [dragTypeID, kUTTypeData as String], isTargeted: $isDropTargeted, perform: { providers in
            note.handleMove(providers: providers)
        })
        
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let note = Note.defaultNote(context: PersistenceController.preview.container.viewContext)
        let nav = NavigationStateManager()
        nav.selectedNote = note
        
        return  VStack(spacing: 5) {
            NoteRow(note: note, selectedNote: .constant(nil))
            NoteRow(note: Note.defaultNote(context: PersistenceController.preview.container.viewContext), selectedNote: .constant(nil))

        }.padding()
        .frame(width: 250)
        
        .environmentObject(NavigationStateManager())
        
    }
}
