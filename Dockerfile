FROM eclipse-temurin:26-alpine@sha256:048e4cfc893da1d2f7424dd510bd2ebf34b91391916f25a57f6facf42d7a3add AS builder

WORKDIR /build/backend-skeleton
COPY backend-skeleton/gradle/ gradle/
COPY backend-skeleton/gradlew .
COPY backend-skeleton/build.gradle.kts backend-skeleton/settings.gradle.kts backend-skeleton/gradle.properties ./
COPY backend-skeleton/app/ app/
COPY gradle-plugins/ ../gradle-plugins/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:26-jre-alpine@sha256:76868ba39e145de9f157b5e58a4e2f8568d9cb066c66eca0c4372ec95bc486b3

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
