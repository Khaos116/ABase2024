package cc.abase.componet.base

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding
import com.drakeet.multitype.ItemViewBinder
import com.dylanc.viewbinding.base.ViewBindingUtil

/**
 * Author:Khaos
 * Date:2023/9/26
 * Time:15:32
 */
abstract class BaseItemView<T, V : ViewBinding>(var onItemClick: ((item: T) -> Unit)? = null) : ItemViewBinder<T, BaseViewHolder<V>>() {
  override fun onCreateViewHolder(inflater: LayoutInflater, parent: ViewGroup): BaseViewHolder<V> {
    return BaseViewHolder(ViewBindingUtil.inflateWithGeneric(this, inflater, parent, false))
  }

  override fun onBindViewHolder(holder: BaseViewHolder<V>, item: T) {
    //if(onItemClick==null)holder.itemView.setOnClickListener(null) else holder.itemView.click
    fillData(holder = holder, item = item)
  }

  abstract fun fillData(holder: BaseViewHolder<V>, item: T)
}