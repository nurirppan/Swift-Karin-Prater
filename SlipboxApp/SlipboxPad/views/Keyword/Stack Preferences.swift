//
//  Stack Preferences.swift
//  assocy
//
//  Created by Karin Prater on 20.10.19.
//  Copyright © 2019 Karin Prater. All rights reserved.
//
import SwiftUI

struct MyAnchorPreferenceData: Equatable {
    static func == (lhs: MyAnchorPreferenceData, rhs: MyAnchorPreferenceData) -> Bool {
        return lhs.viewIdx == rhs.viewIdx
    }
    let viewIdx: String
    let bounds: Anchor<CGRect>
}


struct MyAnchorPreferenceKey: PreferenceKey {
    typealias Value = [MyAnchorPreferenceData]
    
    static var defaultValue: [MyAnchorPreferenceData] = []
    
    static func reduce(value: inout [MyAnchorPreferenceData], nextValue: () -> [MyAnchorPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

