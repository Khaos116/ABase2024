package cc.abase.componet.base

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.viewbinding.ViewBinding
import com.dylanc.viewbinding.base.ActivityBinding
import com.dylanc.viewbinding.base.ActivityBindingDelegate

/**
 * https://dylancaicoding.github.io/ViewBindingKTX/#/zh/baseclass
 * Author:Khaos
 * Date:2023/9/25
 * Time:19:32
 */
abstract class BaseActivity<VB : ViewBinding> : AppCompatActivity(), ActivityBinding<VB> by ActivityBindingDelegate() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentViewWithBinding()
  }

  override fun onResume() {
    super.onResume()
    //binding.root
  }
}