//
//  ContentView.swift
//  CoreDataTestProject
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Item.fetch(), animation: .default)
    
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink("Item at \(item.timestamp)", destination: ItemDetailView(item: item))
                    Text("Item at \(item.timestamp, formatter: itemFormatter)")
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    
                    #if os(iOS)
                    EditButton()
                    #endif
                    
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            _ = Item(name: "name", context: viewContext)
            
 
            PersistenceController.shared.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            Item.delete(at: offsets, for: Array(items))

            PersistenceController.shared.save()
        }
    }
} 

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
