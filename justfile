#!/usr/bin/env just --justfile

set quiet

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

@update-gradle:
    #!/usr/bin/env bash
    set -euo pipefail
    ./gradlew wrapper --gradle-version latest --distribution-type all
    DIST_URL=$(grep distributionUrl gradle/wrapper/gradle-wrapper.properties | cut -d= -f2 | sed 's/\\//g')
    CHECKSUM=$(curl -sL "${DIST_URL}.sha256")
    sed -i '' "s/distributionSha256Sum=.*/distributionSha256Sum=${CHECKSUM}/" gradle/wrapper/gradle-wrapper.properties
    echo "Updated wrapper checksum: ${CHECKSUM}"

update-java:
    @echo "Updating Temurin JDK via Homebrew..."
    brew upgrade --cask temurin || brew install --cask temurin
    @echo "Installed JDK version:"
    @/usr/libexec/java_home -V 2>&1
    @echo ""
    @echo "If the version changed, update the toolchain in:"
    @echo "  ../gradle-plugins/components/base/src/main/kotlin/sollecitom/plugins/Plugins.kt"
    @echo "  ../gradle-plugins/components/kotlin-jvm/src/main/kotlin/sollecitom/plugins/conventions/task/kotlin/KotlinTaskConventions.kt"
    @echo "  gradle.properties (dockerBaseImageParam)"
    @echo "  Dockerfile (FROM eclipse-temurin:<version>-alpine)"

update-all:
    just update-dependencies
    just update-gradle
    just update-java

docker-build:
    docker build -f Dockerfile -t backend-skeleton ..

docker-run:
    docker run --rm backend-skeleton
