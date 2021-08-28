//
//  SearchView.swift
//  SlipboxPad
//
//  Created by Karin Prater on 27.12.20.
//

import SwiftUI

struct SearchView: View {
   
    @EnvironmentObject var searchManager: NavigationSearchManager
    
    @Environment(\.horizontalSizeClass) var horizontalClass
    
    @State private var showKeysCollection: Bool = true
    
    @Binding var showSearch: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                TextField("search term", text: $searchManager.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300)
                Spacer()
                Button(action: {
                    searchManager.undoAll()
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .rotationEffect(.init(degrees: 45))
                })
                
            }
            
            Picker(selection: $searchManager.fullStatus, label: Text("Note Status"), content: {
                ForEach(FullSatus.allCases, id: \.self) { status in
                    Text(status.rawValue)
                }
                
            }).pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 400)
            .padding(.vertical)
            
            HStack {
                Text("Your keywords")
                Spacer()
                Button(action: {
                    showKeysCollection.toggle()
                }, label: {
                    Text(showKeysCollection ? "Hide" : "Show keywords")
                })
            }.padding(.top)
            
            if showKeysCollection {
            KeywordSelectionView(selectedKeys: $searchManager.selectedKewords)
                //.padding().border(Color.gray)
            }
                Divider()
            if horizontalClass == .compact && searchManager.predicate() != nil {
                NoteSearchView(pred: searchManager.predicate()!)
                    .listStyle(PlainListStyle())
                
            }
            

        }.padding()
        .navigationTitle("Search")
            .toolbar(content: {
                Button(action: {
                    showSearch.toggle()
                }, label: {
                    Image(systemName: "folder")
                })
            })
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
            SearchView(showSearch: .constant(true))
            }
            .environmentObject(NavigationSearchManager())
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            NavigationView {
                SearchView(showSearch: .constant(true))
            }
            .previewDevice("iPhone 11")
            .environmentObject(NavigationSearchManager())
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}


//    @EnvironmentObject var searchManager: NavigationSearchManager

////      Picker(selection: $searchManager.searchStatus, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
//ForEach(Status.allCases, id: \.self) { status in
//    Text(status.rawValue)
//}
//})
