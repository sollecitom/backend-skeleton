FROM eclipse-temurin:26-alpine@sha256:e4f908886c1c50eaf59c18dab95ee75be7bf065808c931196eff9858adbe0a41 AS builder

WORKDIR /build/backend-skeleton
COPY backend-skeleton/gradle/ gradle/
COPY backend-skeleton/gradlew .
COPY backend-skeleton/build.gradle.kts backend-skeleton/settings.gradle.kts backend-skeleton/gradle.properties ./
COPY backend-skeleton/app/ app/
COPY gradle-plugins/ ../gradle-plugins/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:26-jre-alpine@sha256:ff7c7f2b396864bebe42b0e29b41f4b8023d044179d021a14e9a711a1eb6a6e7

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
