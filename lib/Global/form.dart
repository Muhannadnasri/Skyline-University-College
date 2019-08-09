import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'global.dart';

Widget GlobalForms(BuildContext context, hintText, initialValue, icons, colorx,
    validators, onSaveds, label) {
  return Column(
    children: <Widget>[
      Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
        child: TextFormField(
          autofocus: true,

          initialValue: initialValue,
          onSaved: onSaveds,
          validator: validators,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(fontSize: 16.0, color: Colors.black),

          decoration: new InputDecoration(
            labelText: label,

            suffixIcon: Icon(icons, color: colorx),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),

            // fillColor: Colors.green
          ),
          // decoration: InputDecoration(
          //   border: OutlineInputBorder(

          //   ),
          //   hintText: hintText,
          //   suffixIcon: Icon(
          //     icons,
          //     size: 15,
          //     color: colors,
          //   ),
          //   hintStyle: TextStyle(fontSize: 14.0),

          // ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 1.0,
        color: Colors.grey[400],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
