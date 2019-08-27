import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/zigzag.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(HomeLogin());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeLoginState();
  }
}

class _HomeLoginState extends State<HomeLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> body;
  File dataFile;

  int _exit = 0;
  Map value = {};
  Map valueJson={};
  @override
  void initState() {

    super.initState();

    getCopyRight();
//    semester='';
//    program='';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: copyRight
            ? Container(
                height: 50,
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF104C90),
                      Color(0xFF3773AC),
                    ],
                    stops: [
                      0.3,
                      0.9,
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    _launchURL() async {
                      const url =

                          'https://www.linkedin.com/in/muhannad-nasri/';
                      if (await canLaunch(url)) {
                        await launch(url,
                            forceWebView: false,
                            forceSafariVC: false,
                            universalLinksOnly: true);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    _launchURL();
                  },
                  child: Center(
                    child: Text(


//                      '© MuhannadNasri 2019 / ALL RIGHTS RESERVED.'
                      value['events']['info'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            : SizedBox(),
        body: studentJson['data']['user_type'] == "STUDENT"
            ? Container(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  children: <Widget>[
                    studentJson['data']['user_type'] == "STUDENT" &&
                            studentJson['data']['user_id'] ==
                                '15379' /*&&  studentJson ['data'] ['name']  =='MUHANNAD NASRI'*/ ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/GPA");
                                  },
                                  child: Text('Hello')),
                            ],
                          )
                        : SizedBox(
                            height: 20,
                          ),
                    FittedBox(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/Attendance");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      width: 110,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/attendance.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Attendance',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/AssessmentMarkCourses");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      width: 110,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/assessment.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Assessment',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/HomeResult");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      width: 110,
                                      height: 100,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/result.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Result',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/HomeClass');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      width: 110,
                                      height: 100,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/class.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Classes',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/MyAdvisor");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      width: 110,
                                      height: 100,
                                      child: Container(
                                        width: 90,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/advisor.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Advisor',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/Circulars");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      width: 110,
                                      height: 100,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/circulars.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Circulars',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/HomeFees");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      width: 110,
                                      height: 100,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/fees.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Fees',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/HomeERequest");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      width: 110,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: Container(
                                        width: 90,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/erequest.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'E-Request',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/CDPDownload");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      width: 110,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/cdp.png',
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'CDP',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'images/logo.png',
                            height: 150,
                            width: 230,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : studentJson['data']['user_type'] == "STF"
                ? Container(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/Circulars");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  15.0) //         <--- border radius here
                                              ),
                                        ),
                                        width: 110,
                                        height: 100,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'images/circulars.png',
                                                height: 50,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Circulars',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/HomeERequest");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  15.0) //         <--- border radius here
                                              ),
                                        ),
                                        width: 110,
                                        height: 100,
                                        child: Container(
                                          width: 90,
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'images/erequest.png',
                                                height: 50,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'E-Request',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/ContactList");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  15.0) //         <--- border radius here
                                              ),
                                        ),
                                        width: 110,
                                        height: 100,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  'images/contactslist.png',
                                                  height: 50,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Contact List',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'images/logo.png',
                              height: 150,
                              width: 230,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : studentJson['data']['user_type'] == "FAC"
                    ? Container(
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/CourseAllocation");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15.0) //         <--- border radius here
                                                  ),
                                            ),
                                            width: 110,
                                            height: 100,
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'images/allocation.png',
                                                      height: 50,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Courses',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/Advisors");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15.0) //         <--- border radius here
                                                  ),
                                            ),
                                            width: 110,
                                            height: 100,
                                            child: Container(
                                              width: 90,
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/advisor.png',
                                                    height: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Advisor',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/Circulars");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15.0) //         <--- border radius here
                                                  ),
                                            ),
                                            width: 110,
                                            height: 100,
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/circulars.png',
                                                    height: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Circulars',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/HomeERequest");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15.0) //         <--- border radius here
                                                  ),
                                            ),
                                            width: 110,
                                            height: 100,
                                            child: Container(
                                              width: 90,
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/erequest.png',
                                                    height: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'E-Request',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/ContactList");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15.0) //         <--- border radius here
                                                  ),
                                            ),
                                            width: 110,
                                            height: 100,
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'images/contactslist.png',
                                                      height: 50,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Contact List',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'images/logo.png',
                                  height: 150,
                                  width: 230,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Stack(
            children: <Widget>[
              Column(
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
                                        studentJson['data']['user_type'] ==
                                                'FAC'
                                            ? 'images/professor-male.png'
                                            : studentJson['data']['Gender'] ==
                                                    'M'
                                                ? 'images/male.png'
                                                : studentJson['data']
                                                            ['Gender'] ==
                                                        'F'
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
                                              studentJson['data']['program']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                        studentJson['data']['acadyear_desc']
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ), //TODO: Name and years and type

                      height: 250,
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
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 70.0, right: 10),
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
                          ), //TODO: Image Profile
                  ],
                ),
              ), //TODO: Image Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            FontAwesomeIcons.powerOff,
                            color: Colors.red,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 17, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //TODO: Put all Icon Container
            ],
          ),
        ),
      ),
    );
  }

  Future getGallery() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    body = {};
    try {
      http.Response response = await http.post(
          "https://muhannadnasri.com/App/data.ph",
          body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {

        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['gallery'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }


        showLoading(false, context);

        setState(() {
          value = valueJson["gallery"];
        });
      } else if(response.statusCode == 300) {


        return null;
      }
    } catch (x) {



      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGallery);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGallery);
      }
    }
  }





  Future getCopyRight() async {
    Future.delayed(Duration.zero, () {});
    try {
      final response = await http
          .get(
            Uri.encodeFull('https://muhannadnasri.com/App/data.php'),
          )
          .timeout(Duration(seconds: 20));
      print(response.contentLength);

      if (response.body == 'True') {
        copyRight = true;
      } else {
        copyRight = false;
      }

      print(copyRight);
    } catch (x) {
      print(x);
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (_exit == 1) return true;

    _exit = 1;
    new Timer(Duration(seconds: 5), () {
      _exit = 0;
    });
    final snackBar = SnackBar(content: Text('Press back again to exit'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    return false;
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
