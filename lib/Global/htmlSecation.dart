import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'global.dart';

Widget htmlSecation(BuildContext context, url, image, title, data) {
  return Column(
    children: <Widget>[
      url
          ? Container(
              child: Image.network(
                image,
                fit: BoxFit.contain,
              ),
            )
          : SizedBox(),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            url
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: url
                  ? SizedBox()
                  : Container(
                      width: 100,
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 3,
                              color:
                                  isDark(context) ? Colors.white : Colors.black,
                              style: BorderStyle.solid)),
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: url
                  ? SizedBox()
                  : Html(
                      defaultTextStyle: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                      data: data),
            )
          ],
        ),
      ),
    ],
  );
}
