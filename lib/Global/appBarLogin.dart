import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:skyline_university/Global/global.dart';

Widget appBarLogin(BuildContext context, header) {
  return 
  GradientAppBar(
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          logOut(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Icon(
            FontAwesomeIcons.powerOff,
            color: Colors.red,
            size: 20,
          ),
        ),
      ),
    ],
    centerTitle: true,
    title: Text(
      header,
      style: TextStyle(fontSize: 17),
    ),
    gradient:
     isDark(context) ?
          
           LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
             Color(0xFF121212),
              Color(0xFF121212),
            ],
            stops: [
              0.7,
              0.9,
            ],
          ):
    
     LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF104C90),
        Color(0xFF3773AC),
      ],
      stops: [
        0.7,
        0.9,
      ],
    ),
  );
}
