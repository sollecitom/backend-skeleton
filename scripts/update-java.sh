#!/usr/bin/env bash
set -euo pipefail
echo "Updating Temurin JDK via Homebrew..."
brew upgrade --cask temurin || brew install --cask temurin
echo "Installed JDK version:"
/usr/libexec/java_home -V 2>&1
echo ""
echo "If the version changed, update the toolchain in:"
echo "  ../gradle-plugins/components/base/src/main/kotlin/sollecitom/plugins/Plugins.kt"
echo "  ../gradle-plugins/components/kotlin-jvm/src/main/kotlin/sollecitom/plugins/conventions/task/kotlin/KotlinTaskConventions.kt"
echo "  gradle.properties (dockerBaseImageParam)"
echo "  Dockerfile (FROM eclipse-temurin:<version>-alpine)"
