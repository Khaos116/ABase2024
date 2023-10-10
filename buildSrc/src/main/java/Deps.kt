//Gradle版本对照 https://developer.android.google.cn/studio/releases/gradle-plugin?hl=zh-cn#groovy
//插件版本	所需的最低Gradle版本(https\://services.gradle.org/distributions/gradle-7.5-bin.zip)
//8.1	    8.0
//8.0	    8.0
//7.4	    7.5
//7.3	    7.4
//7.2	    7.3.3
//7.1	    7.2
//7.0	    7.0

//Android Studio 版本	所需插件版本(com.android.tools.build:gradle:7.2.0)
//Hedgehog | 2023.1.1	3.2-8.2
//Giraffe | 2022.3.1	3.2-8.1
//Flamingo | 2022.2.1	3.2-8.0
//Electric Eel | 2022.1.1	3.2-7.4
//Dolphin | 2021.3.1	3.2-7.3
//Chipmunk | 2021.2.1	3.2-7.2
//Bumblebee | 2021.1.1	3.2-7.1
//Arctic Fox | 2020.3.1	3.1-7.0
object Version {
  const val kotlin = "1.9.0"
  const val gradle = "8.1.1"
  const val coroutines = "1.7.3"
  const val okhttp = "4.11.0"
  const val coil = "2.4.0"
  const val rxHttp = "3.2.0"
  const val picSel = "3.11.1"
}

object Deps {
  //Androidx
  const val androidx_core_ktx = "androidx.core:core-ktx:1.10.1"
  const val androidx_fragment = "androidx.fragment:fragment:1.5.7"
  const val androidx_appcompat = "androidx.appcompat:appcompat:1.6.1"
  const val androidx_activity_ktx = "androidx.activity:activity-ktx:1.7.2"
  const val androidx_recyclerview = "androidx.recyclerview:recyclerview:1.3.0"
  const val androidx_lifecycle_runtime = "androidx.lifecycle:lifecycle-runtime:2.6.2"
  const val androidx_constraintlayout = "androidx.constraintlayout:constraintlayout:2.1.4"
  const val androidx_lifecycle_viewmodel = "androidx.lifecycle:lifecycle-viewmodel-ktx:2.6.2"

  //官方Lib
  const val coroutines_android = "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Version.coroutines}"//https://github.com/Kotlin/kotlinx.coroutines
  const val okhttp = "com.squareup.okhttp3:okhttp:${Version.okhttp}"//https://github.com/square/okhttp
  const val gson = "com.google.code.gson:gson:2.10.1"//https://github.com/google/gson
  const val rxjava = "io.reactivex.rxjava3:rxjava:3.1.7"//https://github.com/ReactiveX/RxJava
  const val rxandroid = "io.reactivex.rxjava3:rxandroid:3.0.2"//https://github.com/ReactiveX/RxAndroid

  //三方基础Lib
  const val coil = "io.coil-kt:coil:${Version.coil}"//https://github.com/coil-kt/coil
  const val coilBase = "io.coil-kt:coil-base:${Version.coil}"
  const val coil_gif = "io.coil-kt:coil-gif:${Version.coil}"
  const val coil_svg = "io.coil-kt:coil-svg:${Version.coil}"
  const val coil_video = "io.coil-kt:coil-video:${Version.coil}"
  const val viewbinding_ktx = "com.github.DylanCaiCoding.ViewBindingKTX:viewbinding-ktx:2.1.0"//https://github.com/DylanCaiCoding/ViewBindingKTX
  const val viewbinding_base = "com.github.DylanCaiCoding.ViewBindingKTX:viewbinding-base:2.1.0"
  const val android_startup = "io.github.idisfkj:android-startup:1.1.0"//https://github.com/idisfkj/android-startup/blob/master/README-ch.md【由于在三星手机上，AndroidX自带的startup存在不初始化的问题，所以改用这个】
  const val multitype = "com.drakeet.multitype:multitype:4.3.0"//https://github.com/drakeet/MultiType
  const val autosize = "com.github.JessYanCoding:AndroidAutoSize:v1.2.1"//https://github.com/JessYanCoding/AndroidAutoSize
  const val immersionbar = "com.geyifeng.immersionbar:immersionbar:3.2.2"//https://github.com/gyf-dev/ImmersionBar
  const val immersionbar_ktx = "com.geyifeng.immersionbar:immersionbar-ktx:3.2.2"
  const val mmkv = "com.tencent:mmkv:1.3.1"//https://github.com/Tencent/MMKV
  const val utilcodex = "com.blankj:utilcodex:1.31.1"//https://github.com/Blankj/AndroidUtilCode/blob/master/lib/utilcode/README-CN.md
  const val timber = "com.jakewharton.timber:timber:5.0.1"//https://github.com/JakeWharton/timber
  const val okhttploginterceptor = "io.github.ayvytr:okhttploginterceptor:3.0.8"//https://github.com/Ayvytr/OKHttpLogInterceptor
  const val rxhttp = "com.github.liujingxing.rxhttp:rxhttp:${Version.rxHttp}"//https://github.com/liujingxing/rxhttp
  const val rxhttp_kapt = "com.github.liujingxing.rxhttp:rxhttp-compiler:${Version.rxHttp}"
  const val rxlife_rxjava = "com.github.liujingxing.rxlife:rxlife-rxjava3:2.2.2"
  const val xxPermissions = "com.github.getActivity:XXPermissions:18.3"//https://github.com/getActivity/XXPermissions
  const val smart_refresh = "io.github.scwang90:refresh-layout-kernel:2.0.6"//https://github.com/scwang90/SmartRefreshLayout
  const val smart_header = "io.github.scwang90:refresh-header-classics:2.0.6"
  const val smart_footer = "io.github.scwang90:refresh-footer-classics:2.0.6"

  //三方常用Lib
  const val apk_parser = "net.dongliu:apk-parser:2.6.10"//打包完成后读取APK信息 https://github.com/hsiafan/apk-parser
  const val libphonenumber = "com.googlecode.libphonenumber:libphonenumber:8.13.22"//https://github.com/google/libphonenumber/wiki/Android-Studio-setup
  const val pictureselector = "io.github.lucksiege:pictureselector:v${Version.picSel}"//https://github.com/LuckSiege/PictureSelector
  const val walle_plugin = "com.github.Petterpx.walle:plugin:1.0.5"//https://github.com/Petterpx/walle
  const val walle_library = "com.github.Petterpx.walle:library:1.0.5"//https://github.com/Petterpx/walle
  const val jpush = "cn.jiguang.sdk:jpush:5.0.3"//http://docs.jiguang.cn/jpush/quickstart/Android_quick
  const val sharetrace = "com.sharetrace:sharetrace-android-sdk:2.1.9"//https://www.sharetrace.com/docs/guide/android.html
}