//
//  CoreDataTestProjectApp.swift
//  CoreDataTestProject
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import SwiftUI

@main
struct CoreDataTestProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        // save content with scenePhase going into background
        .onChange(of: scenePhase) { phase in
            print(phase)
            
            if phase == .background {
                persistenceController.save()
            }
        }
    }
}
