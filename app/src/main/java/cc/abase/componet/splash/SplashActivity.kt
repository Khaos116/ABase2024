package cc.abase.componet.splash

import android.os.Bundle
import cc.abase.componet.base.BaseActivity
import cc.abase.databinding.ActivitySplashBinding

/**
 * Author:Khaos
 * Date:2023/9/25
 * Time:19:32
 */
class SplashActivity : BaseActivity<ActivitySplashBinding>() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    binding.tv.text = getString(cc.abase.R.string.buildTime)
  }
}