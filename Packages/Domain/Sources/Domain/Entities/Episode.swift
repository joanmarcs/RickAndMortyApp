//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation

public struct Episode: Identifiable, Equatable, Sendable {
    public let id: Int
    public let name: String
    public let airDate: String
    public let code: String

    public init(id: Int, name: String, airDate: String, code: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.code = code
    }
}

