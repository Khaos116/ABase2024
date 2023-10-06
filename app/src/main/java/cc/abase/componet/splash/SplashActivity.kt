package cc.abase.componet.splash

import android.annotation.SuppressLint
import android.os.Bundle
import cc.abase.componet.base.BaseActivity
import cc.abase.databinding.ActivitySplashBinding
import com.blankj.utilcode.util.AppUtils
import com.blankj.utilcode.util.GsonUtils
import com.meituan.android.walle.WalleChannelReader


/**
 * Author:Khaos
 * Date:2023/9/25
 * Time:19:32
 */
@SuppressLint("CustomSplashScreen")
class SplashActivity : BaseActivity<ActivitySplashBinding>() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    binding.tv.text = getString(cc.abase.R.string.buildTime)
    binding.tv.append("\n${AppUtils.getAppName()}")
    binding.tv.append("\n${AppUtils.getAppPackageName()}")
    binding.tv.append("\n${AppUtils.getAppVersionName()}")
    binding.tv.append("\n${AppUtils.getAppVersionCode()}")
    WalleChannelReader.getChannelInfo(this)?.let {
      binding.tv.append("\n${GsonUtils.toJson(it)}")
    }
  }
}