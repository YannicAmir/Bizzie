# Bizzie Architecture Instructions

This document outlines the architectural standards and guidelines for the Bizzie Flutter application. All developers must adhere to these rules to maintain a scalable, maintainable, and testable codebase.

## Prerequisites

Before contributing to the architecture or implementing features, ensure you have read and completed the setup guides:

-   [Project Setup Guide](setup_guide.md)
-   [Android Setup](android_setup.md)
-   [iOS Setup](ios_setup.md)

## Architecture Overview

Bizzie uses **Clean Architecture** combined with **Feature-Driven Architecture**. This ensures separation of concerns, independency of frameworks, and testability.

### Core Principles

1.  **Separation of Concerns:** The code is divided into distinct layers (Data, Domain, Presentation) with specific responsibilities.
2.  **Dependency Rule:** Source code dependencies only point inwards. Inner layers (Domain) know nothing about outer layers (Data, Presentation).
3.  **Feature Autonomy:** Each feature is self-contained in `lib/features/[feature_name]`.

## Folder Structure

The project follows a strict directory structure.

### Feature Structure (`lib/features/`)

Each feature typically contains the following structure:

```plaintext
lib/features/[feature_name]/
├── data/
│   ├── dtos/          # Data Transfer Objects (JSON parsing, from/to Map)
│   ├── datasources/   # Remote (API clients) & Local (Database DAOs) sources
│   └── repositories/  # Implementation of Domain Repositories (implements interfaces)
├── domain/
│   ├── models/        # Pure Dart classes (Business Entities)
│   ├── interfaces/    # Abstract Repositories (Contracts)
│   └── usecases/      # Single-responsibility business logic classes (Interactors)
├── presentation/
│   ├── bloc/          # State Management (Blocs/Cubits)
│   ├── views/         # Screens (Pages)
│   └── widgets/       # Feature-specific, reusable widgets
└── [feature].dart     # Barrel file / Export
```

### Core Structure (`lib/core/`)

Shared logic and utilities that are used across multiple features reside here.

-   `error/`: Failure definitions and exception handling.
-   `usecases/`: Base UseCase interface.
-   `utils/`: General utility functions.
-   `constants/`: App-wide constants.

## Boundaries & Rules

1.  **Domain Purity:** The `domain` layer must **NOT** depend on `data` or `presentation` layers. It should contain only pure Dart code and no Flutter dependencies (except for basic types if absolutely necessary and abstract).
2.  **Data Flow:** `presentation` talks to `domain`, which talks to `data` (via interfaces). `presentation` **NEVER** talks to `data` directly.
3.  **Interface Implementation:** The `data` layer implements the interfaces defined in the `domain` layer. This allows for easy swapping of data sources and mocking for tests.
4.  **State Management:** Business logic should reside in UseCases, and UI logic in BLoCs/Cubits. Widgets should be dumb and only display state.

## Scaffolding New Features

To ensure consistency, use the **Architect Agent** instructions located in [docs/agents/architect.agent.md](agents/architect.agent.md) or ask the Architect Agent to scaffold the feature for you.

## Code Reviews

All code changes involving structural modifications must be reviewed against these architectural guidelines.
