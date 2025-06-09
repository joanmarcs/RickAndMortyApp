# RickAndMortyApp

iOS App built with SwiftUI that allows exploring characters and episodes from the [Rick & Morty API](https://rickandmortyapi.com/).

## Features

- Character list with pagination and infinite scrolling.
- Character search with debounce.
- Filters by status and gender.
- Persistent filters and list/grid view mode.
- Character detail view with full info and episodes list.
- Episode list with expandable detail.
- Share character feature.
- Full localization support.
- Remote image loading with caching.
- Pull-to-refresh support.
- Optimized UX for both iPhone and iPad.

## Architecture

- **Clean Architecture** with 4 layers:
  - `Domain`: domain models + use cases + repository protocols.
  - `Data`: repository implementations + DTOs + mappers.
  - `Networking`: generic HTTP client + network services.
  - `Presentation`: UI + ViewModels + Coordinators.

- **Modularization** with Swift Package Manager:
  - Each layer is a separate Swift Package.
  - High testability and scalability.

- **Decoupled navigation** using Coordinators.

- **Dependency injection** via `DependenciesContainer`.

## Tests

- **Unit tests**:
  - Data layer
  - Domain layer
  - Networking layer
  - ViewModels in Presentation layer

- **UI tests**:
  - Character list screen
  - Filters screen
  - Character detail screen
  - Episodes list screen

## Project structure

RickAndMortyApp.xcodeproj
├── Packages
│   ├── Domain
│   ├── Data
│   ├── Networking
│   └── Presentation
├── RickAndMortyApp (App target)
├── RickAndMortyAppUITests
└── README.md

## Dependencies

- [Rick & Morty API](https://rickandmortyapi.com/)
- Swift 5.9+
- iOS 15.0+

