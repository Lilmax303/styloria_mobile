// android/app/src/main/kotlin/com/example/styloria_mobile/MainActivity.kt

package com.styloria.app

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // ✅ FIX: Use new edge-to-edge API instead of deprecated
        // setStatusBarColor / setNavigationBarColor
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
    }
}