//
//  KeywordCollectionView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import SwiftUI

struct AddKeywordsToNoteView: View {
    
    let note: Note
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var context
    @State private var selectedKeys: Set<Keyword> = []
    

    @State private var newKey: String = ""
    
    var body: some View {
        
        
        VStack {
            
            Text("Add keywords to note \(note.title)")
                .header2().padding().padding(.top)
            
            HStack {
                TextField("add new keyword", text: $newKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    _ = Keyword(name: newKey, context: context)
                    newKey = ""
                }, label: {
                    Text("Add keyword")
                })
            }.buttonStyle(AdvancedButtonStyle(color: Color("AccentColor"), isDisabled: newKey.count == 0))
            .padding()
            
            KeywordSelectionView(selectedKeys: $selectedKeys)
                .padding()
                .border(Color.gray)
            
            HStack {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                }).buttonStyle(AdvancedButtonStyle(color: Color("AccentColor"), isDisabled: false))
                
                Button(action: {
                    for key in selectedKeys {
                        note.keywords.insert(key)
                    }
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Add keywords")
                }).buttonStyle(SimpleButtonStyle(isDisabled: selectedKeys.count == 0))
                
            }.padding()
        }.padding()

    }
}

struct KeywordCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        
        return AddKeywordsToNoteView(note: Note(title: "my name", context:  context))
            .previewDevice("iPhone SE (2nd generation)")
           
            .environment(\.managedObjectContext, context)
    }
}


