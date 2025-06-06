//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import Foundation
import Domain
import SwiftUI

@MainActor
public protocol CharacterListCoordinatorProtocol {
    func makeCharacterDetail(for character: Character) -> AnyView
}

