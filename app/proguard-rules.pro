#https://blog.csdn.net/DeMonliuhui/article/details/128295336
# ------------------------------基本指令区---------------------------------
-optimizationpasses 5 #指定压缩级别
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/* #混淆时采用的算法
-verbose #打印混淆的详细信息
-dontoptimize #关闭优化
-keepattributes *Annotation* #保留注解中的参数
-keepattributes *Annotation*,InnerClasses # 保持注解
-keepattributes Signature  # 避免混淆泛型, 这在JSON实体映射时非常重要
-ignorewarnings # 屏蔽警告
-keepattributes SourceFile,LineNumberTable # 抛出异常时保留代码行号
#混淆时不使用大小写混合，混淆后的类名为小写(大小写混淆容易导致class文件相互覆盖）
-dontusemixedcaseclassnames

#未混淆的类和成员
-printseeds proguardbuild/print_seeds.txt
#列出从 apk 中删除的代码
-printusage proguardbuild/print_unused.txt
#混淆前后的映射，生成映射文件
-printmapping proguardbuild/print_mapping.txt
# -------------------------------基本指令区--------------------------------


#---------------------------------默认保留区---------------------------------
#继承activity,application,service,broadcastReceiver,contentprovider....不进行混淆
-keep public class * extends android.app.Activity
-keep public class * extends androidx.fragment.app.Fragment
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep class android.support.** {*;}

# androidx 混淆
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-keep class * implements androidx.** {
    *;
}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**
-printconfiguration
-keep,allowobfuscation interface androidx.annotation.Keep
-keep @androidx.annotation.Keep class *
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

#不混淆View中的set***() 和 get***()方法 以保证属性动画正常工作  某个类中的某个方法不混淆
#自定义View的set get方法 和 构造方法不混淆
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
#这个主要是在layout 中写的onclick方法android:onclick="onClick"，不进行混淆
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

#保持 Serializable 不被混淆
-keepnames class * implements java.io.Serializable
#实现Serializable接口的类重写父类方法保留
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
# 保留R文件中所有静态字段，以保证正确找到每个资源的ID
-keepclassmembers class **.R$* {
    public static <fields>;
}


-keepclassmembers class * {
    void *(*Event);
}

#保留枚举类中的values和valueOf方法
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
#保留Parcelable实现类中的Creator字段，以保证Parcelable机制正常工作
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

#保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

#不混淆包含native方法的类的类名以及native方法名
-keepclasseswithmembernames class * {
  native<methods>;
}

#避免log打印输出
-assumenosideeffects class android.util.Log {
 public static *** v(...);
 public static *** d(...);
 public static *** i(...);
 public static *** w(...);
}
#对含有反射类的处理
#--------------------------------默认保留区--------------------------------------------



#----------------------------- WebView(项目中没有可以忽略) -----------------------------
#webView需要进行特殊处理
# WebView
-dontwarn android.webkit.WebView
-dontwarn android.net.http.SslError
-dontwarn android.webkit.WebViewClient
-keep public class android.webkit.WebView
-keep public class android.net.http.SslError
-keep public class android.webkit.WebViewClient
#----------------------------- WebView(项目中没有可以忽略) -----------------------------


#----------------------------- 实体类不可混淆 ------------------------------------------
#添加实体类混淆规则
# Application classes that will be serialized/deserialized over Gson
-keep class **.entity.** { *; }
-keep class **.bean.** { *; }
#----------------------------- 实体类不可混淆 ------------------------------------------
#############################################
#----------------丧心病狂的混淆----------------#
# 指定外部模糊字典 proguard-chinese.txt 改为混淆文件名，下同
-obfuscationdictionary proguard.txt
## 指定class模糊字典
-classobfuscationdictionary proguard.txt
## 指定package模糊字典
-packageobfuscationdictionary proguard.txt
#############################################
#############################################
#----------------------------- 第三方类库 ------------------------------------------
#添加第三方类库的混淆规则
-keep public class com.android.installreferrer.**{ *; }
# OkHttp3 去掉缺失类警告
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.javax.net.ssl.**
-dontwarn org.openjsse.net.ssl.**
#https://github.com/getActivity/XXPermissions
-keep class com.hjq.permissions.** {*;}
#############################################