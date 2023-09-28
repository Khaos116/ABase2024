package cc.res

import android.content.Context
import com.rousetime.android_startup.AndroidStartup
import timber.log.Timber

/**
 * Author:Khaos
 * Date:2023/9/28
 * Time:20:37
 */
class FirstStartup : AndroidStartup<String>() {
  override fun callCreateOnMainThread(): Boolean = false//用来控制create()方法调时所在的线程，返回true代表在主线程执行
  override fun waitOnMainThread(): Boolean = false//用来控制当前初始化的组件是否需要在主线程进行等待其完成。如果返回true，将在主线程等待，并且阻塞主线程。

  override fun create(context: Context): String? {//组件初始化方法，执行需要处理的初始化逻辑，支持返回一个T类型的实例。
    if (AppConfig.isDebug) Timber.plant(Timber.DebugTree())
    "初始化完成".logE()
    return this.javaClass.simpleName
  }

  override fun dependenciesByName(): List<String>? {//List<String>?返回String类型的list集合。用来表示当前组件在执行之前需要依赖的组件。
    return super.dependenciesByName()
  }
}