FROM eclipse-temurin:25-alpine AS builder

WORKDIR /build
COPY gradle/ gradle/
COPY gradlew .
COPY build.gradle.kts settings.gradle.kts gradle.properties ./
COPY build-logic/ build-logic/
COPY app/ app/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:25-jre-alpine

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
