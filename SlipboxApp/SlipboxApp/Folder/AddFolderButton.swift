//
//  AddFolderButton.swift
//  SlipboxApp
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI
import CoreData

struct AddFolderButton: View {
    @EnvironmentObject var nav: NavigationStateManager
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State private var makeNewFolderStatus: FolderEditorStatus? = nil
    
    var body: some View {
        Button(action: {
            makeNewFolderStatus = FolderEditorStatus.addFolder
        }, label: {
            Image(systemName: "plus")
            #if os(iOS)
            Text("Add new folder")
            #endif
        })
        .sheet(item: $makeNewFolderStatus) { status in
            FolderEditorView(editorStatus: status, contextFolder: nav.selectedFolder)
                .environment(\.managedObjectContext, context)
                .environmentObject(nav)
            
        }
    }
}

struct AddFolderButton_Previews: PreviewProvider {
    static var previews: some View {
        AddFolderButton()
    }
}
