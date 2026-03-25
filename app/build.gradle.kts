plugins {
    id("sollecitom.kotlin-jvm-conventions")
    application
}

dependencies {
    implementation(platform(libs.kotlinx.coroutines.bom))
    implementation(libs.kotlinx.coroutines.core)

    testImplementation(libs.assertk)
    testImplementation(libs.kotlinx.coroutines.test)
}

application {
    mainClass.set("sollecitom.skeleton.AppKt")
}
