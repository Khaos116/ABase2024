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
        set newPackageName=com.abase.newa
        set newVerionCode=101
        set newVerionName=1.0.1
        set outputFile=%%~ni\updated_apktool.yml
        set xmlString=%%~ni\apktool.yml
        (for /f "usebackq delims=" %%a in ("!xmlString!") do (
            set "line=%%a"

            REM 修改替换!!消失问题
            echo !line! | findstr /r "brut.androlib.apk.ApkInfo" > nul
            if !errorlevel! equ 0 (
                set "line=^!^!brut.androlib.apk.ApkInfo"
            )

            REM 查找并替换包名
            echo !line! | findstr /r "  renameManifestPackage:" > nul
            if !errorlevel! equ 0 (
                set "line=  renameManifestPackage: !newPackageName!"
            )

            REM 查找并替换versionCode的值
            echo !line! | findstr /r "  versionCode:" > nul
            if !errorlevel! equ 0 (
                set "line=  versionCode: !newVerionCode!"
            )
            
            REM 查找并替换versionName的值
            echo !line! | findstr /r "  versionName:" > nul
            if !errorlevel! equ 0 (
                set "line=  versionName: !newVerionName!"
            )   
            echo !line! 
        )) > !outputFile!

        REM 将修改后的结果重命名为原文件名
        move /y !outputFile! !xmlString!
    ) else (
        echo off
    )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause