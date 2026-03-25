#!/usr/bin/env just --justfile

push:
    git add -A && (git diff --quiet HEAD || git commit -am "WIP" && git push origin main)

pull:
    git pull

build:
    ./gradlew build

rebuild:
    ./gradlew clean build --refresh-dependencies --rerun-tasks

test:
    ./gradlew test

clean:
    ./gradlew clean

publish:
    ./gradlew publishToMavenLocal

update-dependencies:
    ./gradlew versionCatalogUpdate

update-gradle:
    ./gradlew wrapper --gradle-version latest --distribution-type all

update-java:
    @echo "Updating Temurin JDK via Homebrew..."
    brew upgrade --cask temurin || brew install --cask temurin
    @echo "Installed JDK version:"
    @/usr/libexec/java_home -V 2>&1
    @echo ""
    @echo "If the version changed, update the toolchain in:"
    @echo "  build-logic/src/main/kotlin/sollecitom.kotlin-jvm-conventions.gradle.kts"
    @echo "  gradle.properties (dockerBaseImageParam)"
    @echo "  Dockerfile (FROM eclipse-temurin:<version>-alpine)"

update-all:
    just update-dependencies
    just update-gradle
    just update-java

docker-build:
    docker build -t backend-skeleton .

docker-run:
    docker run --rm backend-skeleton
