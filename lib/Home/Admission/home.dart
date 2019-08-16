import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBar.dart';

import 'package:skyline_university/Home/home.dart';

void main() => runApp(HomeAdmission());

class HomeAdmission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAdmissionState();
  }
}

class _HomeAdmissionState extends State<HomeAdmission> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FittedBox(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/AdmissionForm");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, right: 8.0),
                          child: Container(
                            width: 380,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //         <--- border radius here
                                  ),
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    'images/admission.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Admission Form',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Admission'),
    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
