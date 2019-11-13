import 'package:flutter/material.dart';

Widget exceptionWait(BuildContext context, icon, msg) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        SizedBox(
          height: 100,
        ),
        Text(msg)
      ],
    ),
  );
}
