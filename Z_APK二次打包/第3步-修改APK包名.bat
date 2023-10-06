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
        echo 需要修改包名的文件夹：%%~ni
        set oldPackage=zz.xx.cc
        set newPackage=com.abase.newa
        set manifestFile=%%~ni\AndroidManifest.xml
        :: 使用 PowerShell 来替换文本
        powershell -Command "(Get-Content !manifestFile!) | Foreach-Object { $_ -replace '!oldPackage!', '!newPackage!' } | Set-Content !manifestFile!"
    ) else (
        echo 文件名称包含_new，不执行修改APP名称，继续下一个文件：%%~nxi
    )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause