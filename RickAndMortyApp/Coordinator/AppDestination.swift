//
//  AppDestination.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 12/6/25.
//

import Foundation
import Domain

public enum AppDestination: Hashable {
    case characterDetail(Character)
    case episodes([String])
}
