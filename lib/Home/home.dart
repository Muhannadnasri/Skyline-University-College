import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/homeBox.dart';
import 'package:skyline_university/Login/loginpage.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

Map<String, String> body;
List sliders = [];

Map slidersJson = {};

final _scaffoldKey = GlobalKey<ScaffoldState>();
final QuickActions quickActions = QuickActions();

class _HomeState extends State<Home> {
  int _exit = 0;

//   final Firestore _db = Firestore.instance;

  String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _setupQuickActions();
    _handleQuickActions();
    getLogs();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'attendance',
          localizedTitle: 'Attendance',
          icon: Platform.isAndroid ? 'attendance' : 'attendance'),
      ShortcutItem(
          type: 'assessment',
          localizedTitle: 'Assessment',
          icon: Platform.isAndroid ? 'assessment' : 'assessment'), //
      ShortcutItem(
          type: 'class_schedul',
          localizedTitle: 'Class Schedule',
          icon: Platform.isAndroid ? 'class_schedul' : 'class_schedul')
    ]);
  }

  void _handleQuickActions() {
    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'attendance':
          print('attendance');
          break;
        case 'assessment':
          print('assessment');

          break;
        case 'class_schedul':
          setState(() {
            Navigator.pushNamed(context, '/LoginApp');
          });
          print('class_schedul');

          break;
      }
    });
  }
  // void _setupQuickActions() {
  //   quickActions.initialize((String shortcutType) {
  //     setState(() {
  //       if (shortcutType != null) shortcut = shortcutType;
  //     });
  //   });

  //   quickActions.setShortcutItems(<ShortcutItem>[
  //     // NOTE: This first action icon will only work on iOS.
  //     // In a real world project keep the same file name for both platforms.
  //     const ShortcutItem(
  //       type: 'attendance',
  //       localizedTitle: 'Attendance',
  //       icon: 'AppIcon',
  //     ),

  //     // NOTE: This second action icon will only work on Android.
  //     // In a real world project keep the same file name for both platforms.
  //     const ShortcutItem(
  //         type: 'action_two',
  //         localizedTitle: 'Action two',
  //         icon: 'ic_launcher'),
  //   ]);
  // }

  // void _handleQuickActions() {
  //   quickActions.initialize((shortcutType) {
  //     if (shortcutType == 'attendance') {
  //       if (loggedin) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => Attendance()));
  //       } else {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => LoginApp(
  //               page: 'attendance',
  //             ),
  //           ),
  //         );
  //       }
  //     } else if (shortcutType == 'action_two') {
  //       print('Show the help dialog!');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: GradientAppBar(
          centerTitle: true,
          title: Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage(
                  'images/skyline_white.png',
                ),
              ),
            ),
          ),
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
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/announcements");
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.notifications_active),
                )),
          ],
        ),
        body: Container(
          color: isDark(context) ? Color(0xFF121212) : Colors.white,
          child: Column(
            children: <Widget>[
              // sliders.isEmpty
              //     ? Container(
              //         height: 140,
              //         child: Center(
              //           child: new CircularProgressIndicator(
              //             strokeWidth: 2,
              //           ),
              //         ),
              //       )
              //     : PhotoSlider(sliders),
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
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
                                    'images-white/admission.png',
                                    'images/admission.png',
                                    "/HomeAdmission",
                                    Colors.white60,
                                    Colors.black,
                                    'Admission',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/programs.png',
                                    'images/programs.png',
                                    "/homePrograms",
                                    Colors.white60,
                                    Colors.black,
                                    'Programs',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/news.png',
                                    'images/news.png',
                                    "/news",
                                    Colors.white60,
                                    Colors.black,
                                    'News',
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
                                    'images-white/location.png',
                                    'images/location.png',
                                    "/Location",
                                    Colors.white60,
                                    Colors.black,
                                    'Location',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/info.png',
                                    'images/info.png',
                                    "/HomeInfo",
                                    Colors.white60,
                                    Colors.black,
                                    'SUC Info',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/login.png',
                                    'images/login.png',
                                    "/LoginApp",
                                    Colors.white60,
                                    Colors.black,
                                    'SUC Login',
                                    Colors.white,
                                    Colors.black,
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
                                    'images-white/events.png',
                                    'images/events.png',
                                    "/events",
                                    Colors.white60,
                                    Colors.black,
                                    'Events',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/FAQ.png',
                                    'images/FAQ.png',
                                    "/FAQ",
                                    Colors.white60,
                                    Colors.black,
                                    'FAQ ?',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/gallery.png',
                                    'images/gallery.png',
                                    "/Gallery",
                                    Colors.white60,
                                    Colors.black,
                                    'Gallery',
                                    Colors.white,
                                    Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                homeBox(
                                  context,
                                  'images-white/aptitude.png',
                                  'images/aptitude.png',
                                  "/apptutudeForm",
                                  Colors.white60,
                                  Colors.black,
                                  'apptitude Test',
                                  Colors.white,
                                  Colors.black,
                                ),
                                homeBox(
                                  context,
                                  'images-white/aptitude.png',
                                  'images/aptitude.png',
                                  "/visitorInfoLan",
                                  Colors.white60,
                                  Colors.black,
                                  'Visitor Info',
                                  Colors.white,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () => _exitApp(context),
    );
  }

  Future getLogs() async {
    try {
      await http.post(
        Uri.encodeFull('http://muhannadnasri.com/App/logUser.php'),
        body: {
          'date': formattedDate,
        },
      );
    } catch (x) {}
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (_exit == 1) return true;

    _exit = 1;
    new Timer(Duration(seconds: 5), () {
      _exit = 0;
    });
    final snackBar = SnackBar(content: Text('Press back again for exit'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    return false;
  }

  Future getSliders() async {
    try {
      http.Response response = await http
          .post("http://muhannadnasri.com/App/slider/data.json", body: body);

      if (response.statusCode == 200) {
        slidersJson = json.decode(response.body);

        setState(() {
          sliders = slidersJson["slider"];
        });
      }
    } catch (x) {}
  }
}
