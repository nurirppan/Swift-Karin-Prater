//
//  SlipboxAppApp.swift
//  SlipboxApp
//
//  Created by Nur Irfan Pangestu on 28/08/21.
//

import SwiftUI

@main
struct SlipboxAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
