//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public struct Character: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let imageURL: String

    public init(id: Int, name: String, imageURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
