package com.zzapp.fluzz.plugin

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.io.File

/**
 * 公共插件
 *
 * @author zhouqin
 * @created_time 20210317
 */
class CommonPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    // 通道
    private lateinit var channel: MethodChannel

    // 插件绑定
    private lateinit var pluginBinding: FlutterPlugin.FlutterPluginBinding

    // 活动
    private lateinit var activity: Activity

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val plugin = CommonPlugin()
            plugin.init(registrar.messenger(), registrar.activity())
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = flutterPluginBinding
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
            "installApk" -> {
                installApk(call.argument("path")!!)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        init(pluginBinding.binaryMessenger, binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        channel.setMethodCallHandler(null)
    }

    /**
     * 初始化
     *
     * @param messenger 信使
     * @param activity 上下文
     */
    private fun init(messenger: BinaryMessenger, activity: Activity) {
        this.activity = activity
        channel = MethodChannel(messenger, "flutter_common")
        channel.setMethodCallHandler(this)
    }

    /**
     * 安装apk文件
     *
     * @param path apk文件地址
     */
    private fun installApk(path: String) {
        val apkFile = File(path)
        if (!apkFile.exists()) {
            throw RuntimeException("安装文件不存在!")
        }

        val intent = Intent(Intent.ACTION_VIEW)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //7.0和7.0以上手机按照这样执行
            val apkUri = FileProvider.getUriForFile(
                activity, activity.packageName + ".fileprovider",
                apkFile
            )
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            intent.setDataAndType(apkUri, "application/vnd.android.package-archive")
        } else {
            //7.0以下的手机
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive")
        }

        activity.startActivity(intent)
    }
}