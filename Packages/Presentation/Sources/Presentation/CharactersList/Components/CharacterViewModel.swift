//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 4/6/25.
//

import Foundation
import SwiftUI

@MainActor
final class CharacterViewModel: ObservableObject {
  let id: Int
  let name: String
  let imageURL: String

  public init(id: Int, name: String, image: String) {
    self.id = id
    self.name = name
    self.imageURL = image
  }
}

