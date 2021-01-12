import 'package:flutter/material.dart';
import 'package:skyline_university/Global/zigzag.dart';

import 'global.dart';

// actions:
Widget appBarLoginHome(BuildContext context) {
  return Stack(
    children: <Widget>[
      ZigZag(
        clipType: ClipType.waved,
        child: Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius:
                                    12.0, // has the effect of softening the shadow
                                spreadRadius:
                                    3.0, // has the effect of extending the shadow
                              )
                            ],
                          ),
                          child: Image.asset(
                            studentJson['data']['user_type'] == 'FAC'
                                ? 'images/professor-male.png'
                                : studentJson['data']['Gender'] == 'M'
                                    ? 'images/male.png'
                                    : studentJson['data']['Gender'] == 'F'
                                        ? 'images/female.png'
                                        : 'images/professor-male.png',
                            height: 25,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            studentJson['data']['name'].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    studentJson['data']['user_type'] == 'STF'
                        ? SizedBox(
                            height: 10,
                          )
                        : Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius:
                                          12.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          3.0, // has the effect of extending the shadow
                                    )
                                  ],
                                ),
                                child: Image.asset(
                                  'images/degree.png',
                                  height: 25,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  studentJson['data']['program'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius:
                                    12.0, // has the effect of softening the shadow
                                spreadRadius:
                                    3.0, // has the effect of extending the shadow
                              )
                            ],
                          ),
                          child: Image.asset(
                            'images/year.png',
                            height: 25,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            studentJson['data']['acadyear_desc'].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          height: 220,
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF104C90),
                Color(0xFF3773AC),
              ],
              stops: [
                0.7,
                0.9,
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            studentJson['photo'].toString() ==
                    "https:\/\/skylineportal.com\/sitgmioxg\/professor.png"
                ? Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                            'images/logosmall.png',
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            studentJson['photo'].toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ],
  );
}
