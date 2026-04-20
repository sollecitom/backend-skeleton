# Project Conventions and Decisions

## Project Overview

General-purpose Kotlin + Java backend skeleton using Gradle (Kotlin DSL). No framework — add one when needed.

## Architecture

### Build System
- **Gradle 9.3.1** with Kotlin DSL, version catalog (`gradle/libs.versions.toml`), and configuration cache enabled.
- Convention plugins are resolved from the sibling **`../gradle-plugins`** repo.
- Convention plugins are applied by ID: `sollecitom.kotlin-jvm-conventions`, `sollecitom.dependency-update-conventions`.

### Module Structure
- Use `module("path", "segments")` in `settings.gradle.kts` to add modules under `modules/`.
- Use `include("name")` for top-level modules like `app`.
- Each module applies `id("sollecitom.kotlin-jvm-conventions")` and declares its own dependencies from the version catalog.

### Library Dependencies
- **swissknife**, **pillar**, and **acme-schema-catalogue** are resolved from published versions in `mavenLocal()`.
- Internal artifacts use group pattern `sollecitom.*` — routed to mavenLocal. Everything else comes from mavenCentral.

### Toolchain
- **JDK 25** (Eclipse Adoptium / Temurin) via Gradle Java toolchain.
- Foojay resolver plugin auto-downloads the JDK if not installed locally.
- **Kotlin 2.3.10** with context parameters, progressive mode, and `-Xjsr305=strict`.

### Docker
- Multi-stage Dockerfile: `eclipse-temurin:25-alpine` builder, `eclipse-temurin:25-jre-alpine` runtime.
- Non-root user. No Jib — plain Dockerfile is the intentional choice.

### Testing
- JUnit 5 (Jupiter) + AssertK for assertions.
- Tests run in parallel (2x CPU cores locally, 1 fork in CI).
- Test reports centralized under `build/test-results/`.

### Justfile
- All recipes use **kebab-case** and **full names** (e.g., `update-dependencies`, not `updateDeps`).
- `update-all` updates dependencies, Gradle wrapper, and JDK.
- `publish` is intentionally a no-op because this project does not publish Maven artifacts.
- Workspace-level justfile at `../justfile` has entries for this project.

### Dependency Updates
- `just update-dependencies` runs `versionCatalogUpdate` (ben-manes + nl.littlerobots plugins).
- Unstable versions are rejected when the current version is stable.
- `just update-gradle` updates the wrapper to latest.
- `just update-java` upgrades Temurin via Homebrew and prints reminders for manual version bumps.

## Explicitly Undesired Practices

The following were evaluated and intentionally excluded from this project. Do not add them.

| Practice | Reason |
|----------|--------|
| `.editorconfig` | Not needed for this project |
| `allWarningsAsErrors` | Not desired |
| Kotlin Explicit API mode (`-Xexplicit-api`) | Not desired |
| Detekt / ktlint (static analysis, linting) | Not desired |
| Kover / JaCoCo (code coverage) | Not desired |
| Dependency analysis plugin (`com.autonomousapps`) | Not desired |
| Docker BuildKit cache mounts | Not desired |
| Build scans / Develocity | Not desired |
| SBOM generation (CycloneDX) | Not desired |
| Self-contained local convention plugins | Not desired; use shared `../gradle-plugins` |
| Jib for Docker images | Plain Dockerfile preferred |
| Aggregate test metrics (`BuildListener.buildFinished`) | Deprecated API |
