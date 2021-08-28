//
//  NavigationStateManager.swift
//  SlipboxApp
//
//  Created by Karin Prater on 07.12.20.
//

import Foundation
import Combine
import CoreData

class NavigationStateManager: ObservableObject, NavigationSearchProtocol {
    
    @Published var selectedNote: Note? = nil
    @Published var selectedFolder: Folder? = nil
    
    @Published var isKey: Bool = false
    
    @Published var showKeyColumn: Bool = true
    @Published var showFolderColumn: Bool = true
    @Published var showNotesColumn: Bool = true
    
    //MARK: - advanced search
    @Published var selectedKewords: Set<Keyword> = []
    @Published var searchText: String = ""
    @Published var searchStatus: Status? = nil
    
}
