//
//  NavigationStateManager.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import Foundation
import Combine
import CoreData

class NavigationStateManager: ObservableObject {
    @Published var selectedNote: Note? = nil
    @Published var selectedFolder: Folder? = nil
    
    func setupFolderAndNoteAtLaunch(viewContext: NSManagedObjectContext) {
        //TODO: use last folder created
        let request = Folder.topFolderFetch()
        let folders = try? viewContext.fetch(request)
        selectedFolder = folders?.first
        selectedNote = selectedFolder?.notes.first
    }
}
