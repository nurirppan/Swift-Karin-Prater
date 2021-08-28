//
//  TextViewWrapper.swift
//  SlipboxApp
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI

struct TextViewWrapper: UIViewRepresentable {

    let note: Note
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, note: note)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        
        view.allowsEditingTextAttributes = true
        view.isEditable = true
        view.isSelectable = true
        view.font = UIFont.systemFont(ofSize: 18)
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        
        view.textStorage.setAttributedString(note.formattedText)
        view.delegate = context.coordinator
        return view
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textStorage.setAttributedString(note.formattedText)
        context.coordinator.note = note
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: TextViewWrapper
        var note: Note
        
        init(_ parent: TextViewWrapper, note: Note) {
            self.parent = parent
            self.note = note
        }
        
        func textViewDidChange(_ textView: UITextView) {
            note.formattedText = textView.attributedText
        }
        
    }
}

//struct TextViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        TextViewWrapper()
//    }
//}
