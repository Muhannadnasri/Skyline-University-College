import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyA9PojHV3ZWHsyaIiICe5DtKN6ijwhR6Ko',
        appId: '1:1068042711317:ios:79d9d5400bf8d81139f91c',
        messagingSenderId: '1068042711317',
        projectId: 'skylineuniversity-4acec',
        authDomain: 'https://skylineuniversity-4acec.firebaseio.com',
        iosBundleId: 'com.skylineuniversity.skyline',
        iosClientId:
            '1068042711317-ajt9r16bvnp89l389o2hepjvplaalfnk.apps.googleusercontent.com',
        databaseURL: 'https://skylineuniversity-4acec.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:1068042711317:android:67791b1f9011763f39f91c',
        apiKey: 'AIzaSyC4DyaJ0jJDIiEXEH3KZBBEMSOM6XTWoWo',
        projectId: 'skylineuniversity-4acec',
        messagingSenderId: '1068042711317',
        authDomain: 'https://skylineuniversity-4acec.firebaseio.com',
        androidClientId:
            '1068042711317-aq0ijq6dmo6i7j6kdubie50i04fjeeeu.apps.googleusercontent.com',
      );
    }
  }
}
