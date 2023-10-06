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
        set newVerionCode=102
        set newVerionName=1.0.2
        set outputFile=%%~ni\updated_apktool.yml
        set xmlString=%%~ni\apktool.yml
        for /f "delims=" %%i in ('type "!xmlString!"') do (
            set "line=%%i"
            if "!line!"=="!line:renameManifestPackage=!" (
                if "!line!"=="!line:versionCode=!" (
                        if "!line!"=="!line:versionName=!" (
                            echo !line! >> !outputFile!
                        ) else (
                            ::versionName 
                            echo 需要替换的内容:!line!
                            echo   versionName: !newVerionName! >> !outputFile!
                        )
                ) else (
                    ::versionCode
                    echo 需要替换的内容:!line!
                    echo  versionCode: '!newVerionCode!' >> !outputFile!
                )
            ) else (
                ::包名
                echo 需要替换的内容:!line!
                echo   renameManifestPackage: !newPackageName! >> !outputFile!
            )
        )
        move /y !outputFile! !xmlString!
    ) else (
        echo off
    )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause