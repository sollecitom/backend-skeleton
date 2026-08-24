FROM eclipse-temurin:26-alpine@sha256:31c7e87c27d5dad4a4a1db0f90d269d1864b7838eb24ebc10417c2a8161caf13 AS builder

WORKDIR /build/backend-skeleton
COPY backend-skeleton/gradle/ gradle/
COPY backend-skeleton/gradlew .
COPY backend-skeleton/build.gradle.kts backend-skeleton/settings.gradle.kts backend-skeleton/gradle.properties ./
COPY backend-skeleton/app/ app/
COPY gradle-plugins/ ../gradle-plugins/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:26-jre-alpine@sha256:1940b62cc310d703353bf1bb0ba064c9fd99357d746ef33e5493b4bb50d1a672

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
