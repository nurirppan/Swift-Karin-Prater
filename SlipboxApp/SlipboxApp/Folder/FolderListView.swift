//
//  FolderListView.swift
//  SlipboxApp
//
//  Created by Karin Prater on 06.12.20.
//

import SwiftUI
import CoreData

struct FolderListView: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    var body: some View {
        VStack {
            HStack {
                Text("Folder").font(.title)
                
                Spacer()
                
                AddFolderButton()
         
            }.padding([.horizontal, .top])

            FolderListBodyView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        
    FolderListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(NavigationStateManager())
        .frame(width: 200)
    }
   
}



