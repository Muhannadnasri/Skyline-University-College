import 'package:flutter/material.dart';

import 'global.dart';

Widget exception(BuildContext context, isLoading) {
  if (isLoading) {
    return Container();
  } else {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'images/cloud.png',
                  ),
                  fit: BoxFit.contain),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Text('No Results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark(context) ? Colors.white : Colors.black,
              )),
          SizedBox(
            height: 25,
          ),
          Text('Sorry there are no results for this request.',
              style: TextStyle(
                color: isDark(context) ? Colors.white : Colors.black,
              )),
          SizedBox(
            height: 15,
          ),
          Text('Try again later.',
              style: TextStyle(
                color: isDark(context) ? Colors.white : Colors.black,
              )),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Material(
              // elevation: 5,
              color: Colors.transparent,
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(10),
              // elevation: elevation,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  // gradient: linearGradient,
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF104C90),
                ),
                constraints: BoxConstraints(
                    maxWidth: 200 ?? MediaQuery.of(context).size.width / 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Go Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
