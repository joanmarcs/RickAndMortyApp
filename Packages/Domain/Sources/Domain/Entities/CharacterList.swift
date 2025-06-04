//
//  File.swift
//  Domain
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation

public struct CharacterList: Sendable {
  public let results: [Character]
  public let pages: Int

  public init(results: [Character], pages: Int) {
    self.results = results
    self.pages = pages
  }
}
