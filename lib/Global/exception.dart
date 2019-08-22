import 'package:flutter/material.dart';

Widget exception(BuildContext context, icon, msg) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon),
        SizedBox(
          height: 25,
        ),
        Text(msg)
      ],
    ),
  );
}
