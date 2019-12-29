import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget isuee(BuildContext context,action) {
  SystemChrome.setEnabledSystemUIOverlays([]);
  return Scaffold(
      body: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('images/serverIsuee.png')),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 13,
        ),
        Column(
          children: <Widget>[
            Container(
                child: Text(
              'No Data',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
              child: Container(
                  child: Text(
                      "Looks like the data you're looking for, do not exist at the mean time. Sorry to bother you.",
                      style: TextStyle(fontSize: 17))),
            ),
            SizedBox(
              height: 60,
            ),

            FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
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
                      color: Colors.black),
                  constraints: BoxConstraints(
                      maxWidth: 200 ?? MediaQuery.of(context).size.width / 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'RETRY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFFFCBE00),
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )

            // NiceButton(
            //   width: 200,

            //   radius: 10.0,
            //   text: "RETRY",
            //   textColor: Color(0xFFFCBE00),

            //   //  Colors.black,
            //   // gradientColors: [
            //   //   Color(0xFF104C90),
            //   //   Color(0xFF3773AC),
            //   // ],

            //   background: Color(0xFF34424C),
            //   onPressed: () {
            //     print("hello");
            //   },
            // ),
          ],
        ),
      ],
    ),
  ));
}
