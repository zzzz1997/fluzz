package com.zzapp.fluzz

import android.os.Bundle
import com.zzapp.fluzz.plugin.CommonPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(CommonPlugin())
    }
}
