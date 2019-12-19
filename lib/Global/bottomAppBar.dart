import 'package:flutter/material.dart';

import 'global.dart';

Widget bottomappBar(BuildContext context, onTap) {
  return BottomAppBar(
      child: GestureDetector(
    onTap: onTap,
    child: Material(
      elevation: 3,
      shadowColor: Colors.black,
      color: isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
  ));
}
