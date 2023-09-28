package cc.abase.componet.base

import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding

/**
 * Author:Khaos
 * Date:2023/9/26
 * Time:15:21
 */
class BaseViewHolder<T : ViewBinding>(protected val binding: T) : RecyclerView.ViewHolder(binding.root)