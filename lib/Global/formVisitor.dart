import 'package:flutter/material.dart';
import 'package:skyline_university/Global/global.dart';

Widget formVisitor(
    BuildContext context, validators, onSaveds, label, keyboardType) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          color: isDark(context) ? Colors.white : Colors.black,
        ),
      ),
      TextFormField(
        onSaved: onSaveds,
        validator: validators,
        keyboardType: keyboardType,
      ),
      SizedBox(
        height: 25,
      ),
    ],
  );
}
