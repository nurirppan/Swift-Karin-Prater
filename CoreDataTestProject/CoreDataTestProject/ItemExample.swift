//
//  ItemExample.swift
//  CoreDataTestProject
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import Foundation
import CoreData

struct ItemExample: Identifiable {
    let timestamp: Date
    let id: UUID
    
    init() {
        timestamp = Date()
        id = UUID()
    }
}


class ViewModel: ObservableObject {
    
    @Published var items: [Item] = []
    
    {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            items = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func add() {
        let item = Item(context: PersistenceController.shared.container.viewContext)
        items.append(item)
    }
    
    func update() {
        if let first = items.first {
            first.timestamp = Date()
        }
        items[0].timestamp = Date()
    }
    
    
}
