//
//  FolderListView.swift
//  SlipboxApp
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI
import CoreData

struct FolderListView: View {
    
    @Binding var showSearch: Bool
    
    @EnvironmentObject var nav: NavigationStateManager
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @State private var makeNewFolderStatus: FolderEditorStatus? = nil
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if nav.selectedFolder != nil {
            NavigationLink("",
                           destination: NoteListView(folder: nav.selectedFolder, selectedNote: $nav.selectedNote),
                           tag: nav.selectedFolder!,
                           selection: $nav.selectedFolder)
            }
            
            FolderListBodyView()
            .listStyle(PlainListStyle())
            .padding(.horizontal)
            
                .navigationTitle(Text("Folders"))
                
                .toolbar(content: {
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        
                        Button(action: {
                            showSearch.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        Menu {
                            Button(action: {
                                makeNewFolderStatus = FolderEditorStatus.addFolder
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add new folder")
                            })
                            Button(action: {
                                makeNewFolderStatus = FolderEditorStatus.addAsSubFolder
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add new subfolder")
                            })
                            
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                    
                })
                
                .sheet(item: $makeNewFolderStatus) { status in
                    FolderEditorView(editorStatus: status, contextFolder: nav.selectedFolder)
                        .environment(\.managedObjectContext, context)
                        .environmentObject(nav)
                    
        }
        }
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FolderListView(showSearch: .constant(false))
        }
            .previewLayout(.fixed(width: 300, height: 600))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(NavigationStateManager())
    }
}
