# backend-skeleton

## Overview
General-purpose Kotlin + Java backend skeleton using the shared `../gradle-plugins` convention plugins, JDK 25, and internal library resolution from `mavenLocal()`.

## Scorecard

| Dimension | Rating | Notes |
|-----------|--------|-------|
| Build system | A+ | shared gradle-plugins conventions, foojay resolver, configuration cache enabled |
| Code quality | N/A | Skeleton — minimal application code |
| Test coverage | B | Sanity check test present |
| Documentation | A | README, CONTEXT.md with architecture decisions and undesired practices |
| Dependency freshness | A | Current workspace-managed toolchain and dependency automation are in place |
| Modularity | A | Clean module() helper, ready to scale |
| Maintainability | A | Shared conventions reduce drift across the workspace |

## Structure
- 1 module: `app/` (placeholder application)
- convention plugins resolved from sibling `../gradle-plugins`
- swissknife, pillar, and acme-schema-catalogue resolved from published versions in `mavenLocal()`
- Multi-stage Dockerfile, justfile with full operations

## Issues
- backend-skeleton does not publish Maven artifacts; repo-local `publish` is intentionally a no-op
- local docs can drift when workspace conventions change and should be kept aligned with the workspace root docs
- project-specific verification is still light because this repo is a skeleton rather than a feature-complete service

## Potential Improvements
1. Keep backend-skeleton aligned with the shared gradle-plugins conventions and workspace command model
2. Add project-specific examples for the common module layouts this skeleton is meant to support
3. Add more module examples (domain, adapters) to demonstrate the intended structure
