package cc.res

import com.rousetime.android_startup.StartupListener
import com.rousetime.android_startup.model.*
import com.rousetime.android_startup.provider.StartupProviderConfig

/**
 * Author:Khaos
 * Date:2023/9/28
 * Time:20:44
 */
class AppStartupConfig : StartupProviderConfig {
  override fun getConfig(): StartupConfig {
    return StartupConfig.Builder()
      .setLoggerLevel(LoggerLevel.ERROR)
      .setAwaitTimeout(3000L)
      .setListener(object : StartupListener {
        override fun onCompleted(totalMainThreadCostTime: Long, costTimesModels: List<CostTimesModel>) {
          costTimesModels.forEach { "${it.name}->初始化耗时=${it.endTime - it.startTime}ms".logE() }
          "初始化总耗时=${totalMainThreadCostTime / (1000 * 1000L)}ms".logE() //1纳秒=0.000001 毫秒
        }
      })
      .build()
  }
}