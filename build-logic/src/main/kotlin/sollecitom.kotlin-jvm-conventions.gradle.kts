import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    `java-library`
    kotlin("jvm")
    idea
}

val projectGroup: String by project
val currentVersion: String by project

group = projectGroup
version = currentVersion

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(25))
        vendor.set(JvmVendorSpec.ADOPTIUM)
    }
    withJavadocJar()
    withSourcesJar()
}

tasks.withType<KotlinCompile>().configureEach {
    compilerOptions {
        javaParameters.set(true)
        progressiveMode.set(true)
        freeCompilerArgs.addAll(
            "-Xjsr305=strict",
            "-Xcontext-parameters",
        )
    }
}

idea {
    module {
        inheritOutputDirs = true
    }
}

val internalGroupPattern = "sollecitom.*"

repositories {
    mavenCentral {
        content {
            excludeGroupByRegex(internalGroupPattern)
        }
    }
    mavenLocal {
        content {
            includeGroupByRegex(internalGroupPattern)
        }
    }
}

configurations.all {
    resolutionStrategy.eachDependency {
        // Force minimum versions of known vulnerable transitive dependencies
        if (requested.group == "org.apache.commons" && requested.name == "commons-compress") {
            useVersion("1.26.0")
            because("CVE fix: versions before 1.26.0 have known vulnerabilities")
        }
    }
}

tasks.withType<Test>().configureEach {
    useJUnitPlatform()
    maxParallelForks = if (System.getenv("CI") != null) 1 else (Runtime.getRuntime().availableProcessors() * 2)
    if (System.getenv("CI") != null) maxHeapSize = "1g"
    testLogging {
        showStandardStreams = false
        exceptionFormat = org.gradle.api.tasks.testing.logging.TestExceptionFormat.FULL
        events("passed", "skipped", "failed")
    }
    reports {
        junitXml.outputLocation.set(project.file("${rootProject.layout.buildDirectory.get()}/test-results/test/${project.name}"))
        html.outputLocation.set(project.file("${rootProject.layout.buildDirectory.get()}/test-results/reports/test/${project.name}"))
    }
}

tasks.withType<AbstractArchiveTask>().configureEach {
    isPreserveFileTimestamps = false
    isReproducibleFileOrder = true
}
