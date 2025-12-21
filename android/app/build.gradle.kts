plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.assignmentbtf.assignment_btf"
    // Updated to 36 to match newer AndroidX library requirements
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Enable core library desugaring for libraries that require newer Java APIs on older devices
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.assignmentbtf.assignment_btf"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // Use Kotlin DSL property name 'minSdk' instead of Groovy 'minSdkVersion'
        minSdk = flutter.minSdkVersion
        // Updated targetSdk to 36 to align with compileSdk and dependency requirements
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Add core-library-desugaring dependency required when isCoreLibraryDesugaringEnabled = true
dependencies {
    add("coreLibraryDesugaring", "com.android.tools:desugar_jdk_libs:2.0.3")
}

flutter {
    source = "../.."
}
