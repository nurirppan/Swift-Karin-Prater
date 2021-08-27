//
//  ItemDetailView.swift
//  CoreDataTestProject
//
//  Created by Nur Irfan Pangestu on 27/08/21.
//

import SwiftUI
import CoreData

struct ItemDetailView: View {
    
    @ObservedObject var item: Item
    
    var body: some View {
        VStack {
            
            if #available(iOS 15.0, *) {
                TextField("name", text: $item.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 200)
                
                Text(item.name)
                Text(item.timestamp.formatted(date: .long, time: .standard))
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item:
                        Item.example(context: PersistenceController.preview.container.viewContext))
    }
}
