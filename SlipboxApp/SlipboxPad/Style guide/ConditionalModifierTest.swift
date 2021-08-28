//
//  ConditionalModifierTest.swift
//  SlipboxPad
//
//  Created by Karin Prater on 26.12.20.
//

import SwiftUI

//struct ConditionalModifierTest: View  {
//    
//    @State private var tapped = false
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            // This line alternates between two modifiers
//            Text("Hello World")
//                .conditionalModifier(tapped,
//                                     EShadow(elevation: .high), Header3())
//                .onTapGesture {
//                    tapped.toggle()
//                }
//            
//            Spacer()
//            
//            // This line alternates between a modifier, or none at all
//            Text("Hello World")
//                .conditionalModifier(tapped, EShadow(elevation: .high))
//            
//            TextField("text", text: .constant("text"))
//                .iosModifier(Header1())
//               
//            
//            Spacer()
//            Button("Tap Me!") { self.tapped.toggle() }
//                .padding(.bottom, 40)
//            
//            
//        }.frame(width: 200, height: 200, alignment: .center)
//    }
//}
//
//struct ConditionalModifierTest_Previews: PreviewProvider {
//    static var previews: some View {
//        ConditionalModifierTest()
//            //.previewLayout(.fixed(width: 100, height: 200))
//    }
//}

//MARK: - view extension
extension View {
    // If condition is met, apply modifier, otherwise, leave the view untouched
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    // Apply trueModifier if condition is met, or falseModifier if not.
    public func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier)
            } else {
                self.modifier(falseModifier)
            }
        }
    }
    
    public func iosModifier<T>(_ modifier: T) -> some View where T: ViewModifier {
        Group {
            #if os(iOS)
                self.modifier(modifier)
            #else
                self
            #endif
        }
    }
    public func macModifier<T>(_ modifier: T) -> some View where T: ViewModifier {
        Group {
            #if os(macOS)
                self.modifier(modifier)
            #else
                self
            #endif
        }
    }
    
    
    
}

