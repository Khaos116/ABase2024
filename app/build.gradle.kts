import java.text.SimpleDateFormat

plugins {
  id("com.android.application")
  id("org.jetbrains.kotlin.android")
  id("walle")
}

//<editor-fold defaultstate="collapsed" desc="基础配置">
android {
  namespace = "cc.abase"//旧版本manifest中的包名
  compileSdk = ConfigBuild.compileSdk
  startCheckDuplicateResources()//检测重复文件
  defaultConfig {
    applicationId = "cc.abase"
    minSdk = ConfigBuild.minSdk
    targetSdk = ConfigBuild.targetSdk
    versionCode = 1
    versionName = "1.0.0"
    resourceConfigurations.addAll(listOf("zh", "zh-rCN"))//可能三方会使用zh-rCN，所以需要保留(如果随便写一种没有的语言，则只会打默认的文字资源到APK)
    ndk { abiFilters.addAll(setOf("armeabi-v7a")) }//"x86", "x86_64", "armeabi-v7a", "arm64-v8a"
    resValue("string", "buildTime", SimpleDateFormat("yyyyMMdd_HHmm").format(System.currentTimeMillis()))
    resValue("string", "buildVersion", SimpleDateFormat("MMddHHmm").format(System.currentTimeMillis()))
  }

  //https://github.com/owntracks/android/blob/43db0ad8428fa30e3edb1e27c9c08143e3e81693/project/app/build.gradle.kts
  signingConfigs {
    register("release") {
      storeFile = File("${rootDir}/com_ab.jks")
      storePassword = "com_cc"
      keyAlias = "com_cc"
      keyPassword = "com_cc"
      enableV1Signing = true
      enableV2Signing = true
      enableV3Signing = true
      enableV4Signing = true
    }
  }

  buildFeatures {
    buildConfig = true
    viewBinding = true
    dataBinding = false
  }

  buildTypes {
    debug {
      signingConfig = signingConfigs.findByName("release")
      isShrinkResources = ConfigBuild.openDebugMinify//是否移除无用资源
      isMinifyEnabled = ConfigBuild.openDebugMinify//是否开启混淆
      applicationIdSuffix = ".debug"
      proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }
    release {
      signingConfig = signingConfigs.findByName("release")
      isShrinkResources = ConfigBuild.openReleaseMinify//是否移除无用资源
      isMinifyEnabled = ConfigBuild.openReleaseMinify//是否开启混淆
      proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }
  }

  //https://github.com/owntracks/android/blob/43db0ad8428fa30e3edb1e27c9c08143e3e81693/project/app/build.gradle.kts
  flavorDimensions.add("default")
  productFlavors {
    create("c1") {
      dimension = "default"
      applicationIdSuffix = ".c1"
      versionCode = ConfigBuild.versionCodeC1
      versionName = ConfigBuild.versionNameC1
      resValue("string", "app_name", "C1渠道")
    }
    create("c2") {
      dimension = "default"
      applicationIdSuffix = ".c1"
      versionCode = ConfigBuild.versionCodeC2
      versionName = ConfigBuild.versionNameC2
      resValue("string", "app_name", "@string/APP名称")
    }
  }

  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
  }
  kotlinOptions { jvmTarget = "17" }
}
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="依赖配置">
dependencies {
  //本地lib
  implementation(project(mapOf("path" to ":libRes")))
  //androidx
  implementation(Deps.androidx_core_ktx)
  implementation(Deps.androidx_fragment)
  implementation(Deps.androidx_appcompat)
  implementation(Deps.androidx_activity_ktx)
  implementation(Deps.androidx_recyclerview)
  implementation(Deps.androidx_constraintlayout)
  implementation(Deps.androidx_lifecycle_runtime)
  implementation(Deps.androidx_lifecycle_viewmodel)
  //协程
  implementation(Deps.coroutines_android)
  //常用三方
  implementation(Deps.viewbinding_ktx)
  implementation(Deps.viewbinding_base)
  implementation(Deps.okhttp)
  implementation(Deps.multitype)
  implementation(Deps.utilcodex)
  implementation(Deps.walle_library)
}
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="打包处理">
//打包处理 https://github.com/Xposed-Modules-Repo/mufanc.tools.applock/blob/5507e105cb4fc30667f5b9d78c0eecf5348fd732/app/build.gradle.kts#L79
android.applicationVariants.all {//这里会走"渠道数"x2(Debug+Release)的次数
  outputs.all {
    //正式版还是测试版
    val apkBuildType = buildType.name.replaceFirstChar { it.uppercase() }
    //渠道名称
    val apkFlavorsName = productFlavors[0].name.replaceFirstChar { it.uppercase() }
    //打包完成后执行APK复制到指定位置
    assembleProvider.get().doLast {
      //使用ApkParser库解析APK文件的清单信息
      val apkParser = net.dongliu.apk.parser.ApkFile(outputFile)
      val apkName = apkParser.apkMeta.label
      val apkVersion = apkParser.apkMeta.versionName
      val buildEndTime = SimpleDateFormat("yyyyMMdd_HHmm").format(System.currentTimeMillis())
      val apkFileName = "${apkName}_${if (apkBuildType == "Debug") "测试版" else "正式版"}_${apkVersion}_${buildEndTime}.apk"
      val destDir = if ("Debug" == apkBuildType) {
        File(rootDir, "APK/${apkBuildType}").also {
          if (!it.exists()) it.mkdirs()
          com.android.utils.FileUtils.deleteDirectoryContents(it)
        }
      } else {
        File(rootDir, "APK/${apkFlavorsName}/${apkBuildType}").also { if (!it.exists()) it.mkdirs() }
      }
      outputFile.copyTo(File(destDir, apkFileName), true)
    }
  }
}
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="检测重复文件">
fun startCheckDuplicateResources() {
  val filePaths = mutableListOf<String>()
  findAllName(File("$rootDir"), filePaths)//找出全部文件名称
  checkRepeatFile(filePaths, "layout", ".xml")//打印重复的XML文件名
  checkRepeatFile(filePaths, "drawable-xhdpi", ".png")//打印重复的png文件名
  checkRepeatFile(filePaths, "drawable-xxhdpi", ".png")//打印重复的png文件名
  checkRepeatFile(filePaths, "drawable-xxxhdpi", ".png")//打印重复的png文件名
  checkRepeatFile(filePaths, "drawable-zh-xxxhdpi", ".png")//打印重复的png文件名
  checkRepeatFile(filePaths, "drawable-xhdpi", ".jpg")//打印重复的jpg文件名
  checkRepeatFile(filePaths, "drawable-xxhdpi", ".jpg")//打印重复的jpg文件名
  checkRepeatFile(filePaths, "drawable-xxxhdpi", ".jpg")//打印重复的jpg文件名
  checkRepeatFile(filePaths, "drawable-zh-xxxhdpi", ".jpg")//打印重复的jpg文件名
}

//检测病打印重复的文件
fun checkRepeatFile(filePaths: List<String>, pathKey: String, suffix: String) {
  //过滤出需要等文件名称
  val filterListPath = filePaths.filter { path -> path.endsWith(suffix) }
  val filterListName = mutableListOf<String>()
  for (path in filterListPath) {
    if (path.contains("\\build\\")) continue
    if (!path.contains(pathKey)) continue
    val name = File(path).name
    if (filterListName.contains(name)) {
      System.err.println("重复文件：${path}")
    } else {
      filterListName.add(name)
    }
  }
}

//找出全部文件
fun findAllName(dir: File, filePaths: MutableList<String>) {
  val files = dir.listFiles()
  for (file in files) {
    if (file.isDirectory) {
      findAllName(file, filePaths)
    } else if (file.isFile) {
      filePaths.add(file.absolutePath)
    }
  }
}
//</editor-fold>