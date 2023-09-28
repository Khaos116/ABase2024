buildscript {
  dependencies {
    classpath(Deps.apk_parser)
  }
}

plugins {
  id("com.android.library") version Version.gradle apply false
  id("com.android.application") version Version.gradle apply false
  id("org.jetbrains.kotlin.android") version Version.kotlin apply false
}