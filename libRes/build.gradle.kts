plugins {
  id("com.android.library")
  id("org.jetbrains.kotlin.android")
}

android {
  namespace = "cc.res"
  compileSdk = ConfigBuild.compileSdk
  defaultConfig { minSdk = ConfigBuild.minSdk }
  buildFeatures {
    buildConfig = true
    viewBinding = true
    dataBinding = false
  }
  buildTypes {
    debug {
      isMinifyEnabled = false
    }
    release {
      isMinifyEnabled = false
      proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }
  }
  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
  }
  kotlinOptions { jvmTarget = "17" }
}

dependencies {
  implementation(Deps.androidx_appcompat)
  implementation(Deps.android_startup)
  implementation(Deps.timber)
}