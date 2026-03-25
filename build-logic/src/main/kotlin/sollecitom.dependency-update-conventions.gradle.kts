import com.github.benmanes.gradle.versions.updates.DependencyUpdatesTask

plugins {
    id("com.github.ben-manes.versions")
    id("nl.littlerobots.version-catalog-update")
}

fun isStable(version: String): Boolean {
    val stableKeyword = listOf("RELEASE", "FINAL", "GA").any { version.uppercase().contains(it) }
    val regex = "^[0-9,.v-]+(-r)?$".toRegex()
    return stableKeyword || regex.matches(version)
}

tasks.withType<DependencyUpdatesTask>().configureEach {
    checkConstraints = true
    checkForGradleUpdate = true
    rejectVersionIf {
        !isStable(candidate.version) && isStable(currentVersion)
    }
}

versionCatalogUpdate {
    sortByKey.set(true)
    keep {
        keepUnusedVersions.set(true)
    }
}
