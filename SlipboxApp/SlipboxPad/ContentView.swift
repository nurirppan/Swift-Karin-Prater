//
//  ContentView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 02.12.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var nav: NavigationStateManager = NavigationStateManager()
    @StateObject var searchManager = NavigationSearchManager()
    
    @State private var showSearch: Bool = false
    
    
    var body: some View {
    
        Group {
        if showSearch {
            NavigationView {
                SearchView(showSearch: $showSearch)
                
                if searchManager.predicate() != nil {
                    NoteSearchView(pred: searchManager.predicate()!)
                }
                
            }.environmentObject(searchManager)
            
        }else {
            
            NavigationView {
                FolderListView(showSearch: $showSearch)
                
                
                NoteListView(folder: nav.selectedFolder, selectedNote: $nav.selectedNote)
                
                if nav.selectedNote != nil {
                    SmallNoteView(note: nav.selectedNote!)
                }
                
            }
            .environmentObject(nav)
            
            
            
        }
        } .onAppear {
            nav.setupFolderAndNoteAtLaunch(viewContext: viewContext)
        }
    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
         ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(NavigationStateManager())
        
            .navigationViewStyle(StackNavigationViewStyle())
    }
}


//                if searchManager.predicate() != nil {
//NoteSearchView(pred: searchManager.predicate()!)
// }
