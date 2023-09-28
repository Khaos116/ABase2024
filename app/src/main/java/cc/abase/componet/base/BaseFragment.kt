package cc.abase.componet.base

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.viewbinding.ViewBinding
import com.dylanc.viewbinding.base.FragmentBinding
import com.dylanc.viewbinding.base.FragmentBindingDelegate

/**
 * https://dylancaicoding.github.io/ViewBindingKTX/#/zh/baseclass
 * Author:Khaos
 * Date:2023/9/25
 * Time:21:07
 */
abstract class BaseFragment<VB : ViewBinding> : Fragment(), FragmentBinding<VB> by FragmentBindingDelegate() {

  override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
    return createViewWithBinding(inflater, container)
  }

  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)
    //binding.root
  }
}