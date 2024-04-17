buildscript {
  dependencies {
    classpath(Deps.apk_parser)
    classpath(Deps.walle_plugin)
  }
}

plugins {
  id("com.android.library") version Version.gradle apply false
  id("com.android.application") version Version.gradle apply false
  id("org.jetbrains.kotlin.android") version Version.kotlin apply false
}

gradle.taskGraph.whenReady {
  val debugTasks = allTasks.filter { task -> task.name.contains("debug", true) }
  val isDebug = debugTasks.isNotEmpty()
  if (isDebug) {
    debugTasks.forEach { task ->//测试版跳过Lint和Test相关的task,以加速编译
      val name = task.name.lowercase()
      if (name.contains("test") || name.contains("lint") || name.contains("upload")) task.enabled = false
    }
  }
  val names = mutableListOf<String>()
  val tasks = allTasks.filter { task ->
    val add = task.name.startsWith("assemble")
    if (add) System.err.println("开始Gradle任务：${task.name}")
    if (add && !names.contains(task.name)) names.add(task.name)
    add
  }
  tasks.forEach { task ->
    task.doLast {
      System.err.println("已完成Gradle任务：${task.name}")
      names.remove(task.name)
      if (names.isEmpty()) killJavaAfterFinish()
    }
  }
}

fun killJavaAfterFinish() {
  System.err.println("Gradle任务已全部完成，20秒后释放java进程")
  kotlin.concurrent.thread {
    Thread.sleep(20 * 1000)
    System.err.println("开始执行释放java占用任务")
    ProcessBuilder()
      .command("taskkill", "/f", "/im", "java.exe")
      .start()
  }
}
