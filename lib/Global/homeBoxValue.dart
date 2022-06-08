import 'package:flutter/material.dart';

import '../Login/E-Reques/StudentForm/onlineRequest.dart';
import 'global.dart';

Widget homeBoxValue(
  BuildContext context,
  darkModeImage,
  whiteModeImage,
  // to,
  title,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnlineRequest(
            name: title,
          ),
        ),
      );
      // Navigator.pushNamed(context, to);
    },
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isDark(context) ? Color(0xFF121212) : Colors.grey[500],

                  blurRadius: 6.0, // has the effect of softening the shadow
                  spreadRadius: 1, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                ),
              ],
              color: isDark(context) ? Colors.black : Colors.white,
              border: Border.all(
                  width: 1.0,
                  color: isDark(context) ? Colors.white60 : Colors.white),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0) //         <--- border radius here
                  ),
            ),
            width: 100,
            height: 90,
            child: Container(
              width: 90,
              height: 90,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      isDark(context) ? darkModeImage : whiteModeImage,
                      height: 30,
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: isDark(context) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
