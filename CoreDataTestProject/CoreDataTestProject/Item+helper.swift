//
//  Item+helper.swift
//  CoreDataTestProject
//
//  Created by Nur Irfan Pangestu on 27/08/21.
//

import Foundation
import CoreData

extension Item {
    
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
//        self.timestamp = Date() not use anymore cause awake from insert
        self.name_ = name
    }
    
    var timestamp: Date {
        get {
            timestamp_ ?? Date()
        }
        set {
            timestamp_ = newValue
        }
    }
    
    var name: String {
        get {
            name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    public override func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: ItemProperties.timestamp)
        setPrimitiveValue("", forKey: ItemProperties.name)
    }
    
    static func delete(at offset: IndexSet, for items: [Item]) {
        
        if let first = items.first, let viewContext = first.managedObjectContext {
            offset.map { items[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return request
    }
    
    static func example(context: NSManagedObjectContext) -> Item {
        Item(name: "example", context: context)
    }
    
    
    
}




struct ItemProperties {
    static let timestamp = "timestamp_"
    static let name = "name_"
}
