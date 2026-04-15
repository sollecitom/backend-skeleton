#!/usr/bin/env just --justfile

set quiet

push:
    git add -A && (git diff --quiet HEAD || git commit -am "WIP" && git push origin main)

pull:
    git pull

build:
    ./gradlew updateInternalCatalogVersions && ./gradlew build

update-internal-dependencies:
    ./gradlew updateInternalCatalogVersions

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

@update-gradle:
    ./scripts/update-gradle.sh

update-java:
    ./scripts/update-java.sh

update-all:
    just update-internal-dependencies
    just update-dependencies
    just update-gradle
    just update-java

docker-build:
    docker build -f Dockerfile -t backend-skeleton ..

docker-run:
    docker run --rm backend-skeleton
