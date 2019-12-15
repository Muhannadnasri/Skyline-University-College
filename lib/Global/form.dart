import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget globalForms(BuildContext context, initialValue, validators, onSaveds,
    label, keyboardType) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
        child: Text(
          label,
          style: TextStyle(
            color: Color(0xFF104C90),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
        child: TextFormField(
          initialValue: initialValue,
          onSaved: onSaveds,
          validator: validators,
          keyboardType: keyboardType,

          textCapitalization: TextCapitalization.words,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
          decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF3773AC),
              ),
            ),
            fillColor: Colors.green,
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
    ],
  );
}
