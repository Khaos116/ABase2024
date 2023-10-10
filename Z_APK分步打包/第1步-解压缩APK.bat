::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=

for %%i in (*.apk) do (
  ::~ni 表示无后缀文件名
  if exist %~dp0%%~ni (
     echo %date%_%time%  %%~ni文件夹已存在,执行清空
     echo=
     del /q /s %~dp0%%~ni
     echo=
  ) else (
     echo %date%_%time%  %%~ni文件夹不存在,执行创建
     echo=
     md %~dp0%%~ni
     echo=
  )
)
::找到当前目录下所有apk文件
for %%i in (*.apk) do (
   echo 开始解压：java -jar apktool_2.8.1.jar d -f %%~fi -o %%~ni
   java -jar apktool_2.8.1.jar d -f %%~fi -o %%~ni
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause