::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
::Apk 二次打包修改包名、配置 https://blog.csdn.net/LIQIANGEASTSUN/article/details/132321685

echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==开始打包APK==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
for %%i in (*.apk) do (
   echo 开始打包： java -jar apktool_2.8.1.jar b %%~ni -o %%~ni_new.apk
   java -jar apktool_2.8.1.jar b %%~ni -o %%~ni_new.apk
)
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==APK打包完成==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
pause