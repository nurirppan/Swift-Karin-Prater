//
//  Core_Data_MVVMApp.swift
//  Core Data MVVM
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import SwiftUI

@main
struct Core_Data_MVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
