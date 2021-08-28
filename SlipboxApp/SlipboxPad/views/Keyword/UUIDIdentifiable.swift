//
//  UUIDIdentifiable.swift
//  SlipboxPad
//
//  Created by Karin Prater on 21.12.20.
//

import Foundation
protocol UUIDIdentifiable: Identifiable, Equatable {
    var uuid: UUID { get set }
}
