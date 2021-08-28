//
//  NavigationSearchProtocol.swift
//  SlipboxApp
//
//  Created by Karin Prater on 27.12.20.
//

import Foundation
import CoreData

protocol NavigationSearchProtocol {
    
    var selectedKewords: Set<Keyword>  { get set }
    var searchText: String { get set }
    var searchStatus: Status? { get set}
    
    func predicate() -> NSPredicate?
}


extension NavigationSearchProtocol {
    func predicate() -> NSPredicate? {
        
        var predicates = [NSPredicate]()
        
        if selectedKewords.count > 0 {
            let p = NSPredicate(format: "ANY %K in %@ ", NoteProperties.keywords, selectedKewords)
            predicates.append(p)
        }
        if searchText.count > 0 {
           
            let p1 = NSPredicate(format: "%K CONTAINS[c] %@", NoteProperties.bodyText, searchText as CVarArg)
            let p2 = NSPredicate(format: "%K CONTAINS[c] %@", NoteProperties.title, searchText as CVarArg)
            let p = NSCompoundPredicate(orPredicateWithSubpredicates: [p1, p2])
            predicates.append(p)
        }
        if let status = searchStatus {
            let p = NSPredicate(format: "%K = %@", NoteProperties.status, status.rawValue as! CVarArg)
            predicates.append(p)
        }
        
        if predicates.count == 0 {
            return nil
        }else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
    
    
}
