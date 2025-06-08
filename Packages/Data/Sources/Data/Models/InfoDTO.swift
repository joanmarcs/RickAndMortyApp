//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation

public struct InfoDTO: Decodable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let pre: String?
}
