//
//  KeywordSelectionView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import SwiftUI

struct KeywordSelectionView: View {
    
    @FetchRequest(fetchRequest: Keyword.fetch(.all)) var keywords
    @Binding var selectedKeys: Set<Keyword>
    
    
    let selectedColor = Color("Tertiary")
    let unselectedColor = Color("unselectedColor")
    
    var body: some View {
        DataCollectionView(keywords, spacing: 5) {  key in
            HStack {
                Text(key.name)
                Text("\(key.notes.count)").padding(5)
                    .background(Circle().fill(Color.white))
            }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 5).fill(selectedKeys.contains(key) ? selectedColor : unselectedColor))
                .onTapGesture {
                    if selectedKeys.contains(key) {
                        selectedKeys.remove(key)
                    }else {
                        selectedKeys.insert(key)
                    }
                }
            
        }
    }
}

struct KeywordSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordSelectionView(selectedKeys: .constant([]))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
