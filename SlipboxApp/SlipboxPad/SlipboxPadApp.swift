//
//  SlipboxPadApp.swift
//  SlipboxPad
//
//  Created by Nur Irfan Pangestu on 28/08/21.
//

import SwiftUI

@main
struct SlipboxPadApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
