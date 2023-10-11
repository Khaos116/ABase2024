::https://github.com/Petterpx/walle
::设置编码方式(65001 UTF-8;936 GBK;437 英语)
chcp 65001

::双冒号表示注释(setlocal enabledelayedexpansion是延迟变量赋值使用)
@echo off&setlocal enabledelayedexpansion
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==Start==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
echo=
echo=
set startTime=%date:~3% %time%
set myDir=%cd%\
set tDirRes=%cd%\config_res\
set tDirThird=%cd%\config_third\
set tConfigApkSigner=%tDirThird%apksigner.jar
set tConfigApkTool=%tDirThird%apktool.jar
set tConfigSign=%tDirThird%sign.jks
set tConfigAalle=%tDirThird%walle.jar
set tConfigZipalign=%tDirThird%zipalign.exe
set tConfigTxt=%tDirRes%config.txt
echo **********************************************************************************
echo 1.电脑需要配置Java环境：https://www.runoob.com/java/java-comments.html
echo=
echo 2.需要的基础文件(放到config_third里面,文件名不能改)
echo       apktool.jar--^>^>APK解压和压缩  
echo       zipalign.exe--^>^>APK对齐  
echo       apksigner.jar--^>^>APK签名  
echo       walle.jar--^>^>PK渠道写入  
echo       sign.jks--^>^>APK签名文件  
echo=
echo 3.配置文件(放到config_res里面,文件名不能改)     
echo       config.txt--^>^>打包的配置信息(主要包含签名、包名、版本、三方相关key等)
echo=
echo 4.资源文件(放到config_res里面,和配置文件里面对应) 
echo=
echo 5.需要修改的原始APK文件(包名不能包含_new和_sign)
echo=
echo 6.原始项目用到极光，manifestPlaceholders需要这样配置
echo        manifestPlaceholders = [
echo            JPUSH_PKGNAME    : "{JPUSH_PKGNAME}",
echo            JPUSH_APPKEY     : "{JPUSH_APPKEY}",
echo            JPUSH_CHANNEL    : "{JPUSH_CHANNEL}",
echo        ]
echo=
echo 7.原始项目用到Sharetrace，manifestPlaceholders需要这样配置
echo        manifestPlaceholders = [
echo            SHARETRACE_APPKEY: "{SHARETRACE_APPKEY}",
echo        ]
echo=
echo 注：APK需要和exe文件放到同一目录
echo **********************************************************************************
echo=
echo=
echo -------------------------------------第1步---清理缓存-------------------------------------
call :clearCache
echo=
echo -------------------------------------第2步---读取配置-------------------------------------
call :readConfig %tConfigTxt%
set configSignKeyalias=%result1%
set configSignStorepassword=%result2%
set configSignKeypassword=%result3%
set configAppName=%result4%
set configPackageName=%result5%
set configVersionName=%result6%
set configVersionCode=%result7%
set configDir=%tDirRes%%result8%
set configOpenLog=%result9%
set configChannel=%result10%
set configJpushKey=%result11%
set configShareTraceKey=%result12%
      echo keyalias=%configSignKeyalias%
      echo storepassword=%configSignStorepassword%
      echo keypassword=%configSignKeypassword%
      echo appName=%configAppName%
      echo package=%configPackageName%
      echo versionName=%configVersionName%
      echo versionCode=%configVersionCode%
      echo resFileName=%configDir%
      echo openLog=%configOpenLog%
      echo channel=%configChannel%
      echo JPUSH_APPKEY=%configJpushKey%
      echo SHARETRACE_APPKEY=%configShareTraceKey%
echo=  
echo -------------------------------------第3步---解压APK-------------------------------------
call :unzipApk  
echo=   
echo -------------------------------------第4步---读取旧包名-------------------------------------
call :readOldPackageName
set configOldPackageName=%result10%
      echo configOldPackageName=%configOldPackageName%
echo=  
echo -------------------------------------第5步---替换APK包名-------------------------------------
call :replaceManifest %configOldPackageName% %configPackageName%
echo=
echo -------------------------------------第6步---替换极光相关-------------------------------------
call :replaceManifest {JPUSH_APPKEY} %configJpushKey%
echo=
call :replaceManifest {JPUSH_CHANNEL} %configJpushKey%
echo=
call :replaceManifest {JPUSH_PKGNAME} %configPackageName%
echo=
echo -------------------------------------第7步---替换统计Key-------------------------------------
call :replaceManifest {SHARETRACE_APPKEY} %configShareTraceKey%
echo=
echo -------------------------------------第8步---替换APP名称-------------------------------------
call :changeAppName %configAppName%
echo=
echo -------------------------------------第9步---替换APP版本-------------------------------------
call :changeAppVersion %configPackageName% %configVersionCode% %configVersionName%
echo=
echo -------------------------------------第10步---替换APP资源-------------------------------------
call :changeAppResouce %configDir%
echo=
echo -------------------------------------第11步---重新打包APK-------------------------------------
call :reZipApk
echo=
echo -------------------------------------第12步---重新签名APK-------------------------------------
call :signApk %tConfigSign% %configSignKeyalias% %configSignStorepassword% %configSignKeypassword%
echo=
echo -------------------------------------第13步---渠道写入APK-------------------------------------
call :writeChannel %configChannel% %configOpenLog%
echo=

echo=
echo ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆==End==☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
set endTime=%date:~3% %time%
echo=
echo 开始时间：%startTime%
echo 结束时间：%endTime%
echo=
endlocal
pause
exit

REM====================================================================1清理缓存文件====================================================================
::1.清理解压缩后的文件夹
::2.清理新生成的APK文件
::3.杀掉java是否内存
::删除非config的文件夹
:clearCache
for /d %%i in (*) do (
    set "filename=%%i"
    if "!filename!"=="!filename:config=!" (
      echo 删除非config的文件夹：%%i
      rd /s /q %%i  
    ) else (
      echo off
    )
)
::删除包含_new或_sign的APK
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        if "!filename!"=="!filename:_sign=!" (
            echo off
        )
    ) else (
        echo 删除包含_new或_sign的APK：%%i
        if exist %%i del %%i
    )
)
::杀掉java是否内存
echo 杀掉java,释放内存
taskkill /f /t /im java.exe
exit /b


REM====================================================================2读取配置文件====================================================================
:readConfig
::需要读取的配置文件
set configFile=%1
::=======================
::读取每个渠道的内容
set cSignKeyalias=
set cSignStorepassword=
set cSignKeypassword=
set cAppName=
set cPackageName=
set cVersionName=
set cVersionCode=
set cDir=
set cOpenLog=
set cChannel=
set cJpushKey=
set cShareTraceKey=
::=======================
for /f "delims=" %%i in (%configFile%) do (
	::每行的内容
    set line=%%i
    ::读取第一列的位置
    set position=0
    ::重置位置,以便读取key和value的值
    set position=0
    ::循环读取key和value
    set key=
    set value=
    for %%x in (%%i) do (
      set /a position+=1
      if !position! equ 1 (
      	set key=%%x
      ) else if !position! equ 2 (
		set value=%%x
      )
    )
    ::根据key来判断赋值给每个渠道的变量
    if !key!==SIGN_KEYALIAS set cSignKeyalias=!value!
    if !key!==SIGN_STOREPASSWORD set cSignStorepassword=!value!
    if !key!==SIGN_KEYPASSWORD set cSignKeypassword=!value!
    if !key!==appName set cAppName=!value!
    if !key!==package set cPackageName=!value!
    if !key!==versionName set cVersionName=!value!
    if !key!==versionCode set cVersionCode=!value!
    if !key!==resFileName set cDir=!value!
    if !key!==openLog set cOpenLog=!value!
    if !key!==channel set cChannel=!value!
    if !key!==JPUSH_APPKEY set cJpushKey=!value!
    if !key!==SHARETRACE_APPKEY set cShareTraceKey=!value!    
)
set result1=!cSignKeyalias!
set result2=!cSignStorepassword!
set result3=!cSignKeypassword!
set result4=!cAppName!
set result5=!cPackageName!
set result6=!cVersionName!
set result7=!cVersionCode!
set result8=!cDir!
set result9=!cOpenLog!
set result10=!cChannel!
set result11=!cJpushKey!
set result12=!cShareTraceKey!
exit /b

REM====================================================================3解压APK====================================================================
::找到当前目录下所有apk文件
:unzipApk
for %%i in (*.apk) do (
   echo 解压APK：java -jar %tConfigApkTool% d -f %%~fi -o %%~ni
   java -jar %tConfigApkTool% d -f %%~fi -o %%~ni
)
exit /b

REM====================================================================4读取旧包名====================================================================
::找到当前目录下所有apk文件
:readOldPackageName
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        echo 需要读取包名的文件夹：%%~ni
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
    ) else (
        echo off
    )
)
set result10=!resultPackage!
exit /b

REM====================================================================5替换AndroidManifest内容====================================================================
:replaceManifest
set oldStr=%1
set newStr=%2
::找到当前目录下所有apk文件
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        echo 找到需要替换的文件：%%~ni
        echo 旧字符串：!oldStr!
        echo 新字符串：!newStr!
        set manifestFile=%%~ni\AndroidManifest.xml
        :: 使用 PowerShell 来替换文本
        powershell -Command "(Get-Content !manifestFile!) | Foreach-Object { $_ -replace '!oldStr!', '!newStr!' } | Set-Content !manifestFile!"
    ) else (
        echo off
    )
)
exit /b

REM====================================================================6修改APP名称====================================================================
::找到当前目录下所有apk文件
:changeAppName
set newAppName=%1
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        echo 替换APP名称的文件夹：%%~ni  
        set outputFile=%%~ni\res\values\updated_strings.xml
        set xmlString=%%~ni\res\values\strings.xml
        for /f "delims=" %%i in ('type "!xmlString!"') do (
            set "line=%%i"
            if "!line!"=="!line:"app_name"=!" (
                echo !line! >> !outputFile!
            ) else (
                echo 原：!line!
                echo 改：    ^<string name="app_name"^>!newAppName!^</string^>
                echo     ^<string name="app_name"^>!newAppName!^</string^> >> !outputFile!
            )
        )
        move /y !outputFile! !xmlString!
    ) else (
        echo off
    )
)
exit /b

REM====================================================================7修改APP版本====================================================================
:changeAppVersion
set newPackageName=%1
set newVerionCode=%2
set newVerionName=%3
::找到当前目录下所有apk文件
::找到当前目录下所有apk文件
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_new=!" (
        echo 替换版本信息的文件夹：%%~ni
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
exit /b

REM====================================================================8修改APP资源====================================================================
:changeAppResouce
set resDir=%1
::资源拷贝
if exist %resDir% (
  for /d %%x in (%resDir%\*) do (
    set resChildDir=%%x
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
                     set sourceFile=%%y
                     set targetFile=%myDir%%%~ni\res\%%~nx\%%~nxy
                     echo 将文件：!sourceFile!
                     echo 拷贝到：!targetFile!
                     echo=
                     copy /y "!sourceFile!" "!targetFile!"
                   )
              )
          )
      )
    ) 
  )
)
exit /b

REM====================================================================9重新打包APK====================================================================
:reZipApk
for %%i in (*.apk) do (
   echo 开始打包： java -jar %tConfigApkTool% b %%~ni -o %%~ni_new.apk
   java -jar %tConfigApkTool% b %%~ni -o %%~ni_new.apk
)
exit /b

REM====================================================================10重新签名APK====================================================================
:signApk
set jksFile=%1
set keyAlias=%2
set storePassword=%3
set keyPassword=%4
set suffix=_align
set suffix2=_sign
::找到当前目录(%~dp0)下所有apk文件
for %%i in (*.apk) do (
    set "filename=%%i"
    if "!filename!"=="!filename:_align=!" (
        if "!filename!"=="!filename:_new=!" (
          echo off
        ) else (
          echo APK要先对齐再签名,否则会导致V2和V3丢失^(^> NUL不输出过程^)
          echo %tConfigZipalign% -v 4  %%~fi %myDir%%%~ni%suffix%.apk
          %tConfigZipalign% -v 4  %%~fi %myDir%%%~ni%suffix%.apk > NUL
          echo=
          echo 写入签名^(V1+V2+V3^)
          echo java -jar %tConfigApkSigner% sign --ks %jksFile% --ks-key-alias %keyAlias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %myDir%%%~ni%suffix%%suffix2%.apk %myDir%%%~ni%suffix%.apk
          java -jar %tConfigApkSigner% sign --ks %jksFile% --ks-key-alias %keyAlias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %myDir%%%~ni%suffix%%suffix2%.apk %myDir%%%~ni%suffix%.apk
          echo=
          echo 删除签名后生成的临时文件
          if exist %myDir%%%~ni%suffix%%suffix2%.apk.idsig del %myDir%%%~ni%suffix%%suffix2%.apk.idsig
          if exist %myDir%%%~ni%suffix%.apk del %myDir%%%~ni%suffix%.apk
          if exist %myDir%%%~ni.apk del %myDir%%%~ni.apk
          echo=
        )              
    ) else (
        echo off
    )
)
exit /b

REM====================================================================11渠道写入APK====================================================================
:writeChannel
set channel=%1
set openLog=%2
::找到当前目录下所有apk文件
for %%i in (*.apk) do (
   set "filename=%%i"
   if "!filename!"=="!filename:_align=!" (
      echo off
   ) else (
      echo 写入渠道文件：java -jar %tConfigAalle% put -c !channel! -e openLog=!openLog! %%~fi %myDir%outFileApk\%%~ni_!channel!.apk
      ::~fi表示文件全路径
      set myDate=%date:~3,4%%date:~8,2%%date:~11,2%
      set myTime=%time:~0,2%%time:~3,2%
      java -jar %tConfigAalle% put -c !channel! -e openLog=!openLog! %%~fi %myDir%out_apk_!myDate!\%%~ni_!channel!_!myTime!.apk
      if exist %%~fi del %%~fi
   )
)
exit /b