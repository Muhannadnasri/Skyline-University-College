import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/global.dart';

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
            color: isDark(context) ? Colors.white : Colors.black,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 5.0),
        child: TextFormField(
          
          initialValue: initialValue,
          onSaved: onSaveds,
          validator: validators,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
              fontSize: 16.0,
              color: isDark(context) ? Colors.white : Colors.black),
          decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDark(context)
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black,
              ),
            ),
            fillColor: Colors.green,
          ),
        ),
      ),
    ],
  );
}
