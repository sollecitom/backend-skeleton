# backend-skeleton

## Overview
General-purpose Kotlin + Java backend skeleton. Newest project — uses modern `build-logic/` includeBuild pattern instead of the legacy gradle-plugins repo. Self-contained convention plugins, JDK 25, and library dependency substitution via includeBuild.

## Scorecard

| Dimension | Rating | Notes |
|-----------|--------|-------|
| Build system | A+ | build-logic includeBuild, foojay resolver, configuration cache enabled |
| Code quality | N/A | Skeleton — minimal application code |
| Test coverage | B | Sanity check test present |
| Documentation | A | README, CONTEXT.md with architecture decisions and undesired practices |
| Dependency freshness | A | Latest everything (JDK 25, Kotlin 2.3.10, Gradle 9.3.1) |
| Modularity | A | Clean module() helper, ready to scale |
| Maintainability | A | Self-contained, no external build plugin dependency |

## Structure
- 1 module: `app/` (placeholder application)
- `build-logic/` with 3 precompiled script plugins: `kotlin-jvm-conventions`, `maven-publish-conventions`, `dependency-update-conventions`
- `includeBuild` for swissknife, pillar, acme-schema-catalogue (with fallback to mavenLocal)
- Multi-stage Dockerfile, justfile with full operations

## Issues
- Gradle wrapper is 9.3.1 while other projects are on 9.4.0 — should update
- Configuration cache has 3 warnings from included builds (AggregateTestMetricsConventions in sibling projects)
- foojay-resolver 0.10.0 may have compatibility issues (IBM_SEMERU error with some Gradle versions)

## Potential Improvements
1. Update Gradle wrapper to 9.4.0 to match other projects
2. Consider extracting build-logic conventions to replace gradle-plugins repo workspace-wide
3. Add more module examples (domain, adapters) to demonstrate the intended structure
