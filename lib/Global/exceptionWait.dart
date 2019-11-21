import 'package:flutter/material.dart';

Widget exceptionWait(BuildContext context, icon, msg) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      icon,
   
      Text(msg)
    ],
  );
}
