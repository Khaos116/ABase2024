::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=

::APK加固后需要重新写入V2签名，采用免费的"易固V1.0"进行加固(https://bbs.125.la/thread-14620441-1-1.html)
::apksigner.jar文件在SDK目录下，如D:\SDK\build-tools\33.0.2\lib\apksigner.jar
::zipalign.exe文件在SDK目录下，如D:\SDK\build-tools\33.0.2\zipalign.exe
::签名文件信息，参考https://blog.csdn.net/u014692069/article/details/130325680
set jksFile=com_ab.jks

set keyAlias=com_cc

set storePassword=com_cc

set keyPassword=com_cc

set suffix=_align

set suffix2=_sign

::找到当前目录(%~dp0)下所有apk文件
for %%i in (*.apk) do (
       set "filename=%%i"
       if "!filename!"=="!filename:_align=!" (
       	if "!filename!"=="!filename:_new=!" (
			echo 文件名称不包含_align,也不包含_new,不需要对齐和签名：%%~nxi
       	) else (
			echo 文件名称不包含_align,但包含_new,需要直接对齐和签名：%%~nxi
			::打印签名信息
			echo %date%_%time%  签名文件路径=%~dp0%jksFile%
			echo=
			echo %date%_%time%  签名Alias=%keyAlias%
			echo %date%_%time%  KeyStore密码=%storePassword%
			echo %date%_%time%  Alias对应密码=%keyPassword%
			echo=
			echo %date%_%time%  原APK=%%~fi
			echo %date%_%time%  新APK=%~dp0%%~ni%suffix%%suffix2%.apk
			echo=
			echo %date%_%time% APK要先对齐再签名,否则会导致V2和V3丢失^(^> NUL不输出过程^)
		  	zipalign -v 4  %%~fi %~dp0%%~ni%suffix%.apk > NUL
			echo=
			echo %date%_%time% 写入签名^(V1+V2+V3^)
			java -jar apksigner.jar sign --ks %jksFile% --ks-key-alias %keyAlias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %~dp0%%~ni%suffix%%suffix2%.apk %~dp0%%~ni%suffix%.apk
			echo=
			echo 删除签名后生成的临时文件
			if exist %~dp0%%~ni%suffix%%suffix2%.apk.idsig del %~dp0%%~ni%suffix%%suffix2%.apk.idsig
			if exist %~dp0%%~ni%suffix%.apk del %~dp0%%~ni%suffix%.apk
			if exist %~dp0%%~ni.apk del %~dp0%%~ni.apk
			echo=
       	)
              
       ) else (
    		echo 文件名称包含_align,不执行签名,继续下一个文件：%%~nxi
       )
)

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
endlocal
pause