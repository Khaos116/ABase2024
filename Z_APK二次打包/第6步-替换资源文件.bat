::https://github.com/Petterpx/walle
::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=

set resDir=channel_C1_Debug
::资源拷贝
if exist %resDir% (
  for /d %%x in (%resDir%\*) do (
    set resChildDir=%%x
    echo=
    echo *****************************
    echo 遍历子文件夹:!resChildDir!
    echo=
    for %%y in (!resChildDir!\*) do (    
      ::变量当前文件夹所有apk文件
      for %%i in (*.apk) do (
          set "filename=%%i"
          if "!filename!"=="!filename:_new=!" (
              if "!filename!"=="!filename:_sign=!" (
                   if exist !filename! (
                     ::%%~ni：从路径中提取不带扩展名的文件名
                     ::%%~nxi：从路径中提取带扩展名的文件名
                     set sourceFile=%~dp0%%y
                     set targetFile=%~dp0%%~ni\res\%%~nx\%%~nxy
                     echo 将文件：%~dp0!sourceFile!
                     echo 拷贝到：%~dp0!targetFile!
                     copy /y "!sourceFile!" "!targetFile!"
                   )
              )
          )
      )
    )
    echo *****************************  
  )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause