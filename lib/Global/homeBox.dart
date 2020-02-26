import 'package:flutter/material.dart';

import 'global.dart';

Widget homeBox(BuildContext context, darkModeImage, whiteModeImage, to,
    darkModeColor, whiteModeColor, title, darkModeTitle, whiteModeTitle) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, to);
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isDark(context) ? Color(0xFF121212) : Colors.grey[500],

                  blurRadius: 5.0, // has the effect of softening the shadow
                  spreadRadius: 2, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: isDark(context) ? whiteModeColor : darkModeColor,
              border: Border.all(
                  width: 1.0,
                  color: isDark(context) ? Colors.white60 : Colors.white),
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
                      height: 45,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark(context) ? darkModeTitle : whiteModeTitle,
            ),
          ),
        ],
      ),
    ),
  );
}
