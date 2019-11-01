import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'global.dart';

Widget appBar(BuildContext context, header) {
  return GradientAppBar(
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          home(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 17.0),
          child: Icon(
            FontAwesomeIcons.home,
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
    
    isDark(context)?
    LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
             Color(0xFF1F1F1F),
              Color(0xFF1F1F1F),
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
