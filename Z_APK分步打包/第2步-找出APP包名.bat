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
        echo 找到需要查找包名的文件夹：%%~ni
        set manifestFile=%%~ni\AndroidManifest.xml
        ::查找当前APP的包名
        set keyWord=package=
        set result=
        for /f "delims=" %%a in ('type "!manifestFile!"') do (
            set "line=%%a"
            if "!line!"=="!line:%keyWord%=!" (
                echo off
            ) else (
                set result= %%a
                goto next1
            )
        )
        :next1
        ::找到APP包名所在行
        echo=
        ::去掉双引号
        set newStr=!result:"=!
        ::找出包名
        set resultPackage=
        set lastStr=xxx
        for %%x in (!newStr!) do (
            if "!lastStr!"=="!lastStr:package=!" (
                echo off
            ) else (
               set resultPackage=%%x
               rem goto endAll
            )
           set lastStr=%%x
        )

        rem :endAll
        echo=
        echo APP的包名为:%resultPackage%
        echo=
    ) else (
        echo off
    )
)


echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause