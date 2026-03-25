plugins {
    idea
    alias(libs.plugins.ben.manes.versions)
    alias(libs.plugins.version.catalog.update)
}

idea {
    module {
        inheritOutputDirs = true
    }
}

versionCatalogUpdate {
    sortByKey.set(true)
    keep {
        keepUnusedVersions.set(true)
        keepUnusedLibraries.set(true)
        keepUnusedPlugins.set(true)
    }
}
