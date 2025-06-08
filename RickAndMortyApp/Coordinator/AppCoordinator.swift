//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 5/6/25.
//

import Foundation
import Presentation
import SwiftUI

public final class AppCoordinator {
    private let dependencies = DependenciesContainer()
    
    public init() {}
    
    @MainActor
    public func start() -> some View {
        CharacterListFactory.make(dependencies: dependencies)
    }
}
