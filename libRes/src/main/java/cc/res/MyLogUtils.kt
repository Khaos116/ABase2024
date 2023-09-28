package cc.res

import timber.log.Timber

/**
 * Author:Khaos
 * Date:2023/9/28
 * Time:20:45
 */
object MyLogUtils {
  fun logE(s: String?) {
    if (s.isNullOrBlank()) return
    Timber.e(s)
  }

  fun logW(s: String?) {
    if (s.isNullOrBlank()) return
    Timber.w(s)
  }

  fun logI(s: String?) {
    if (s.isNullOrBlank()) return
    Timber.i(s)
  }

  fun logD(s: String?) {
    if (s.isNullOrBlank()) return
    Timber.d(s)
  }

  fun logV(s: String?) {
    if (s.isNullOrBlank()) return
    Timber.v(s)
  }
}