import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global.dart';

Widget globalForms(BuildContext context, initialValue, validators, onSaveds,
    label, container, keyboardType, icon, color) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        child: TextFormField(
          enabled: disableForm == true,

          initialValue: initialValue,
          onSaved: onSaveds,
          validator: validators,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(fontSize: 16.0, color: Colors.black),

          decoration: new InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Icon(
                icon,
                color: color,
                size: 17,
              ),
            ),
            labelText: label,

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
        height: 20,
      ),
      container == true
          ? Container(
              height: 1.0,
              color: Colors.grey[400],
            )
          : SizedBox()
    ],
  );
}
