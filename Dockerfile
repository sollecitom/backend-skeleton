FROM eclipse-temurin:25-alpine@sha256:416bd6ae24de242440633e6e449c533df9e902b3f0da8f9049227c06ccb254a4 AS builder

WORKDIR /build/backend-skeleton
COPY backend-skeleton/gradle/ gradle/
COPY backend-skeleton/gradlew .
COPY backend-skeleton/build.gradle.kts backend-skeleton/settings.gradle.kts backend-skeleton/gradle.properties ./
COPY backend-skeleton/app/ app/
COPY gradle-plugins/ ../gradle-plugins/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:25-jre-alpine@sha256:0611ca158a2497b7ed6c2594a06fe88aa234401af0a43495f084ba1e986eba50

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
