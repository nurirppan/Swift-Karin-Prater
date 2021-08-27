//
//  CoreDataTestProjectTests.swift
//  CoreDataTestProjectTests
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import XCTest
import CoreData
@testable import CoreDataTestProject

class CoreDataTestProjectTests: XCTestCase {

//    var controllers: PersistenceController!
//    var context: NSManagedObjectContext {
//        controllers.container.viewContext
//    }
    
    override class func setUp() {
        super.setUp()
//        self.controllers = PersistenceController.empty
    }
    
    override class func tearDown() {
        super.tearDown()
//        self.controllers = nil
    }
    
    func test_add_item() {
        let item = Item(context: PersistenceController.empty.container.viewContext)
        
        XCTAssertNotNil(item.name_, "should have name")
        XCTAssertNotNil(item.timestamp_, "should have timestamp")
    }
    
    func test_fetch() {
        let context = PersistenceController.empty.container.viewContext
        let item = Item(context: context)
        
        let request = Item.fetch()
        let items = try? context.fetch(request)
        
        XCTAssertTrue(items?.count ?? 0 > 0, "item was not fetched")
        
        
    }

}
