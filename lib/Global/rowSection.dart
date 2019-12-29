import 'package:flutter/material.dart';

import 'global.dart';

Widget rowSection(BuildContext context, image, imageWhite, text, location) {
  return Column(
    children: <Widget>[
      FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, location);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8.0),
                child: Container(
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        isDark(context) ? Color(0xFF1F1F1F) : Colors.grey[100],
                    border: Border.all(
                      width: 1.0,
                      color: isDark(context) ? Colors.white : Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //         <--- border radius here
                        ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          isDark(context) ? imageWhite : image,
                          height: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
