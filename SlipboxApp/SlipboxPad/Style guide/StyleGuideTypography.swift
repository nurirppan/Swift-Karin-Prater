//
//  StyleGuideTypography.swift
//  DesignProject
//
//  Created by Karin Prater on 13.07.20.
//  Copyright © 2020 Karin Prater. All rights reserved.
//

import SwiftUI

//h1, h2, h3, body, detail, error


struct Header1: ViewModifier {
    func body(content: Content) -> some View {
        Group {
        #if os(iOS)
        content
            .font(.system(.title, design: .rounded))
            .padding()
        
        #else
        content.font(.headline)
        #endif
        }
    }
}

struct Header2: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(.title2, design: .rounded))
    }
}
struct Header3: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(.subheadline, design: .rounded))
    }
}

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(.body, design: .rounded))
    }
}

struct Detail: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
            .foregroundColor(Color(.lightGray))
    }
}

struct ErrorMessage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
            .foregroundColor(Color("Error"))
    }
}

extension Text {
    public func header1() -> some View {
        return modifier(Header1())
    }
    
    public func header2() -> some View {
        return modifier(Header2())
    }
    
    public func header3() -> some View {
        return modifier(Header3())
    }
    public func bodyText() -> some View {
        return modifier(BodyText())
    }
    
    public func detailText() -> some View {
        return modifier(Detail())
    }
    
    public func errorText() -> some View {
        return modifier(ErrorMessage())
    }
}


struct StyleGuideTypography: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text("header1 ")
                .header1()
            Text("header2")
                .header2()
            Text("header3")
                .header3()
            Text("Body")
                .bodyText()
            Text("Description")
                .detailText()
            Text("Error")
            .errorText()
        }
        
    }
}

struct StyleGuideTypography_Previews: PreviewProvider {
    static var previews: some View {
        StyleGuideTypography()
    }
}
