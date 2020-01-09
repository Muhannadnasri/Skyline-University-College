import 'package:flutter/material.dart';

import 'global.dart';

Widget dropDownWidgetVisitor(BuildContext context, String title, value,
    List items, valueItems, textItems, onChanged, topTitle, bool languageAr) {
  return Column(
    children: <Widget>[
      Container(
        alignment: languageAr ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
          child: Text(
            topTitle,
            style: TextStyle(
              color: isDark(context) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
            underline: Container(
              height: 1,
              color: Color(0xFF2f2f2f),
            ),
            hint: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
              child: Text(
                title,
                style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black,
                ),
              ),
            ),
            isExpanded: true,
            value: value,
            items: items
                    ?.map(
                      (item) => DropdownMenuItem<String>(
                        value: item[valueItems].toString(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text(item[textItems].toString())),
                        ),
                      ),
                    )
                    ?.toList() ??
                [],
            onChanged: onChanged),
      ),
    ],
  );
}
