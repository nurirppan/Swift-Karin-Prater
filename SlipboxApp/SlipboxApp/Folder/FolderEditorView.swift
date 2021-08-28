//
//  FolderEditorView.swift
//  SlipboxApp
//
//  Created by Karin Prater on 06.12.20.
//

import SwiftUI
import CoreData

struct FolderEditorView: View {
    
    @State private var folderName: String = ""
    
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @EnvironmentObject var nav: NavigationStateManager
    
    //NEW parent folder
    let editorStatus: FolderEditorStatus
    let contextFolder: Folder?
    
    var body: some View {
        VStack {
            
            if editorStatus == FolderEditorStatus.addAsSubFolder {
                Text("Add subfolder for \(contextFolder?.name ?? "")")
//                    .iosModifier(Header1())
//                    .font(.title)
                    .header1()
                   
            }else {
                Text("Create new Folder")
                    .iosModifier(Header1())
                    .font(.title)
            }
            
            //else editorStatus == FolderEditorStatus.add
            
            TextField("name", text: $folderName) { _ in
            } onCommit: {
                addFolder()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: 300)
            
           
            #if os(iOS)
            HStack(spacing: 20) {
                cancelButton
                    .buttonStyle(AdvancedButtonStyle(color: Color("Accent"), isDisabled: false))
                addButton
                    .buttonStyle(SimpleButtonStyle(isDisabled: folderName.count == 0))
            }.padding(.vertical).padding(.top)
            
            #else
            HStack {
                cancelButton
                addButton
            }
            #endif
                
         
            
        }.padding()
//        .onAppear {
//            if editorStatus == .editContextFolder {
//                folderName = contextFolder?.name ?? ""
//            }
//        }
    }
    
    var cancelButton: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }
    
    var addButton: some View {
        return
            Button(action: {
              addFolder()
            }, label: {
                Text("Create")
            })
    }
    
    func addFolder() {
        let folder = Folder(name: folderName, context: context)
        if editorStatus == .addAsSubFolder {
            contextFolder?.add(subfolder: folder)
        } else if let beforeFolder = self.contextFolder,
                 let parent = beforeFolder.parent {
            //NEW add the right index
            parent.add(subfolder: folder, at: beforeFolder.order + 1)
        }
        
        nav.selectedFolder = folder
        presentation.wrappedValue.dismiss()
    }
}

struct FolderEditorView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        
        return Group {
           FolderEditorView(editorStatus: .addFolder, contextFolder: Folder(name: "parent", context: context))
            
            FolderEditorView(editorStatus: .addAsSubFolder, contextFolder: Folder(name: "parent", context: context))
                .previewDevice("iPhone 11")
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/))
            
        }
        .environment(\.managedObjectContext, context)
    }
}

//MARK: - status helper
enum FolderEditorStatus: String, Identifiable {
    
    case editContextFolder = "editContextFolder"
    case addFolder = "addFolder"
    case addAsSubFolder = "addAsSubFolder"
    
    var id: String {
        self.rawValue
    }
    
    func newFolder() -> Bool {
        switch self {
        case .addAsSubFolder, .addFolder:
            return true
        case .editContextFolder:
            return false
        }
    }
}
