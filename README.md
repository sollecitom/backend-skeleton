# backend-skeleton

General-purpose Kotlin + Java backend skeleton using Gradle (Kotlin DSL).

## Prerequisites

- **JDK 25** (Eclipse Adoptium / Temurin) — install via `brew install --cask temurin@25`
- **just** — install via `brew install just`

## Quick Start

```bash
just build
```

## Available Commands

| Command | Description |
|---------|-------------|
| `just build` | Build the project |
| `just rebuild` | Clean build with refreshed dependencies |
| `just test` | Run tests |
| `just clean` | Clean build outputs |
| `just publish` | Publish to mavenLocal |
| `just update-dependencies` | Update version catalog entries |
| `just update-gradle` | Update Gradle wrapper to latest |
| `just update-java` | Upgrade Temurin JDK via Homebrew |
| `just update-all` | Run all updates |
| `just docker-build` | Build Docker image |
| `just docker-run` | Run Docker image |

## Project Structure

```
backend-skeleton/
├── app/                  # Application module
├── gradle/
│   └── libs.versions.toml   # Centralized dependency versions
├── justfile              # Task automation
├── Dockerfile            # Multi-stage, cloud-agnostic
└── CONTEXT.md            # Architecture decisions and conventions
```

## Adding a Module

In `settings.gradle.kts`:

```kotlin
module("my-feature", "domain")       // creates modules/my-feature/domain/
module("my-feature", "adapters")     // creates modules/my-feature/adapters/
```

Each module applies the shared conventions:

```kotlin
plugins {
    id("sollecitom.kotlin-jvm-conventions")
}
```

This project resolves convention plugins from the sibling `../gradle-plugins` repo.

## Library Dependencies

This project consumes [swissknife](https://github.com/sollecitom/swissknife), [pillar](https://github.com/sollecitom/pillar), and [acme-schema-catalogue](https://github.com/sollecitom/acme-schema-catalogue) via `includeBuild` when checked out alongside, falling back to mavenLocal otherwise.
