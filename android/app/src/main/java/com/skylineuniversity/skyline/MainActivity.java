package com.skylineuniversity.skyline;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    //  switch (getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK) {
    //         case Configuration.UI_MODE_NIGHT_YES:
    //             setTheme(R.style.DarkTheme);

    //             break;
    //         case Configuration.UI_MODE_NIGHT_NO:
    //             setTheme(R.style.LightTheme);
    //             break;
    //         default:
    //             setTheme(R.style.LightTheme);
    //     }

    //     SplashScreen.show(this, true);
    //     super.onCreate(savedInstanceState);
  }
}
