::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=

::1.清理解压缩后的文件夹
::2.清理新生成的APK文件

::遍历当前文件夹的所有子文件夹并删除
for /d %%i in (*) do (
    set "filename=%%i"
    if "!filename!"=="!filename:channel=!" (
      echo 需要删除的文件夹名称：%%i
      rd /s /q %%i  
    ) else (
        echo 包含年channel的文件夹不删除：%%i 
    )
)
echo=
::变量当前文件夹所有apk文件
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        if "!filename!"=="!filename:_sign=!" (
            echo 原始APK不删除:%%i
        )
    ) else (
        echo 包含_new或_sign的APK，执行删除:%%i
        if exist %%i del %%i
    )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause