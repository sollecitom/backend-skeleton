FROM eclipse-temurin:26-alpine@sha256:761fae3b08a96c1a3421c18620317787f90d36c78b53de3a4da19ddc8874a814 AS builder

WORKDIR /build/backend-skeleton
COPY backend-skeleton/gradle/ gradle/
COPY backend-skeleton/gradlew .
COPY backend-skeleton/build.gradle.kts backend-skeleton/settings.gradle.kts backend-skeleton/gradle.properties ./
COPY backend-skeleton/app/ app/
COPY gradle-plugins/ ../gradle-plugins/

RUN chmod +x gradlew && ./gradlew :app:installDist --no-daemon

FROM eclipse-temurin:26-jre-alpine@sha256:f1330062e83fbc1a7fb7d0ce5a4296616d2d974e8348a74a4f222116a32b54e1

RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=builder /build/app/build/install/app/ .

ENTRYPOINT ["./bin/app"]
