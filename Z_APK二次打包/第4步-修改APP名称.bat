::https://github.com/Petterpx/walle
::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=

::找到当前目录下所有apk文件
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        echo 需要修改APP名称的文件夹：%%~ni
        set newAppName=新APPa
        set outputFile=%%~ni\res\values\updated_strings.xml
        set xmlString=%%~ni\res\values\strings.xml
        echo newAppName=!newAppName!
        echo outputFile=!outputFile!
        echo xmlString=!xmlString!
        for /f "delims=" %%i in ('type "!xmlString!"') do (
            set "line=%%i"
            echo  !line!
            if "!line!"=="!line:"app_name"=!" (
                echo !line! >> !outputFile!
            ) else (
                ::echo     ^<string name="app_name"^>!newAppName!^</string^>
                echo     ^<string name="app_name"^>!newAppName!^</string^> >> !outputFile!
            )
        )
        move /y !outputFile! !xmlString!
    ) else (
        echo 文件名称包含_new，不执行修改APP名称，继续下一个文件：%%~nxi
    )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause