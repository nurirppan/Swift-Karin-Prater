//
//  FolderListBodyView.swift
//  SlipboxApp
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI


struct FolderListBodyView: View {
    
    @FetchRequest(fetchRequest: Folder.topFolderFetch()) var folders: FetchedResults<Folder>
    
    var body: some View {
        List {
            ForEach(folders) { folder in
                
                RecursiveFolderView(folder: folder)
                
            }.listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            
        }
    }
}

struct FolderListBodyView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListBodyView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(NavigationStateManager())
    }
}
