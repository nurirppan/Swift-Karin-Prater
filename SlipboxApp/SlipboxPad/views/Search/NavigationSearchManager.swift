//
//  NavigationSearchManager.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import Foundation
import Combine
import CoreData

class NavigationSearchManager: ObservableObject, NavigationSearchProtocol {
    
    @Published var selectedNote: Note? = nil
    
    @Published var selectedKewords: Set<Keyword> = []
    @Published var searchText: String = ""
    
    @Published var searchStatus: Status? = nil
    
    @Published var fullStatus: FullSatus = .all //use for Swfitui picker
    
    var subsriptions = Set<AnyCancellable>()
    
    init() {
        $fullStatus.sink { [unowned self] value in
            switch value {
            case .all: self.searchStatus = nil
            case .archived: self.searchStatus = .archived
            case .draft: self.searchStatus = .draft
            case .review: self.searchStatus = .review
            }
        }.store(in: &subsriptions)
    }
    
    func undoAll() {
        selectedKewords = []
        searchText = ""
        searchStatus = nil
        fullStatus = .all
        selectedNote = nil
    }
}

enum FullSatus: String, CaseIterable {
    case draft = "draft"
    case review = "review"
    case archived = "archived"
    case all = "all"
}
