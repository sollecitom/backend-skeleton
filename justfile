#!/usr/bin/env just --justfile

set quiet

push:
    git add -A && (git diff --quiet HEAD || git commit -am "WIP" && git push origin main)

pull:
    git pull

build:
    ./gradlew updateInternalCatalogVersions && ./gradlew build

license-audit:
    bash ../scripts/run-license-audit.sh backend-skeleton

generate-sbom:
    bash ../scripts/run-generate-sbom.sh backend-skeleton

cleanup:
    bash ../scripts/cleanup-maven-local.sh --repo-root . --keep 2 --max-age-days 14
    bash ../scripts/cleanup-docker-images.sh --keep 2 backend-skeleton

update-internal-dependencies:
    ./gradlew updateInternalCatalogVersions

rebuild:
    ./gradlew clean build --refresh-dependencies --rerun-tasks

test:
    ./gradlew test

clean:
    ./gradlew clean

publish:
    @echo "backend-skeleton does not publish Maven artifacts; skipping publish."

update-dependencies:
    ./gradlew versionCatalogUpdate

@update-gradle:
    ./scripts/update-gradle.sh

update-java:
    just -f ../justfile update-java-workspace

update-all:
    just update-internal-dependencies
    just update-dependencies
    just update-gradle

docker-build:
    docker build -f Dockerfile -t backend-skeleton ..

docker-run:
    docker run --rm backend-skeleton

workflow +steps:
    bash ../scripts/run-just-workflow.sh {{steps}}
