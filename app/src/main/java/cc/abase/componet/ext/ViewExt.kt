package cc.abase.componet.ext

import android.view.View

/**
 * Author:Khaos
 * Date:2023/9/26
 * Time:15:45
 */
inline fun View.click(crossinline function: (view: View) -> Unit) {
  //this.setOnClickListener {
  //  val tag = this.getTag(R.id.id_tag_click)
  //  if (tag == null || System.currentTimeMillis() - tag.toString().toLong() > 600) {
  //    this.setTag(R.id.id_tag_click, System.currentTimeMillis())
  //    function.invoke(it)
  //  }
  //}
}