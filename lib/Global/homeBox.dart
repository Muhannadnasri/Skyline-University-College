import 'package:flutter/material.dart';

import 'global.dart';

Widget homeBox(BuildContext context, darkModeImage, whiteModeImage, to,
    darkModeColor, whiteModeColor, title, darkModeTitle, whiteModeTitle) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, to);
    },
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white30,

              blurRadius: 50.0, // has the effect of softening the shadow
              spreadRadius: 1, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
          color:
              isDark(context) ? whiteModeColor : darkModeColor.withOpacity(0.1),
          border: Border.all(
              width: 1.0,
              color: isDark(context) ? Colors.white60 : Colors.black),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //         <--- border radius here
              ),
        ),
        width: 120,
        height: 110,
        child: Container(
          width: 80,
          height: 80,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  isDark(context) ? darkModeImage : whiteModeImage,
                  height: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: isDark(context) ? darkModeTitle : whiteModeTitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
