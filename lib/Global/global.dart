import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'package:url_launcher/url_launcher.dart';

import 'sheets.dart';

bool isDark(context) {
  return Theme.of(context).brightness == Brightness.dark;
}

String selectedName = "";

String deviceId = 'Unknown';
String program = studentJson['data']['program'];
String userType = studentJson['data']['user_type'];

bool copyRight = false;

List courseAllocationMorningJson = [];
List courseAllocationEveningJson = [];
List courseAllocationWeekendJson = [];
//API-Key
String API = '965a0109d2fde592b05b94588bcb43f5';
//Global String
Map studentJson = {};

bool isValidat = true;
List aptitudeJson = [];
Map aptitudeIDJson = {};

bool loggedin = false;

bool newVersion = false;
String username = '';

String password = '';

//Admin

int selectStudent;
int selectStaff;

Map gpaJson = {};
List imageJson = [];
List finalJson = [];
List marksJson = [];
List staffPJson = [];
List studentPJson = [];
List finalxJson = [];
bool internet = true;
bool data = true;
//
bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

const APP_STORE_URL =
    'https://apps.apple.com/ae/app/skyline-university/id1300445743';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=YOUR-APP-ID';
showVersionDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = "New Update Available";
      String message =
          "There is a newer version of app available please update it now.";
      String btnLabel = "Update Now";
      String btnLabelCancel = "Later";
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => launchURL(APP_STORE_URL),
                ),
                FlatButton(
                  child: Text(btnLabelCancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => launchURL(PLAY_STORE_URL),
                ),
                FlatButton(
                  child: Text(btnLabelCancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
    },
  );
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

phoneCall() async {
  if (await canLaunch("tel:+97165441155")) {
    await launch("tel:+97165441155");
  } else {}
}

void logOut(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: SuperellipseShape(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Image.asset(
          isDark(context) ? 'images-white/logo.png' : 'images/logo.png',
          height: 50,
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Are you sure you want to logout ?"),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () async {
              username = '';
              password = '';
              loggedin = false;
              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.setString('username', username);

              prefs.setString('password', password);
              _handleClearShortcutItems();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);

              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (BuildContext context) => Home()),
              //     (Route<dynamic> route) => false);
            },
          ),
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void home(context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

void _handleClearShortcutItems() {
  final QuickActions quickActions = QuickActions();

  quickActions.clearShortcutItems();
}

void showLoading(isLoading, context) {
  if (isLoading) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Stack(
                children: <Widget>[
                  Image.asset(
                    isDark(context)
                        ? 'images-white/logo.png'
                        : 'images/logo.png',
                    height: 50,
                    color: isDark(context) ? Colors.white : Colors.black,
                  ),
                  Image.asset(
                    isDark(context)
                        ? 'images-white/logo.png'
                        : 'images/logo.png',
                    height: 50,
                  ),
                ],
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Row(
                  children: <Widget>[
                    new Text('Please Wait....'),
                  ],
                ),
              ),
            ),
          );
        });
  } else {
    Navigator.pop(context);
  }
}

void showSuccessSnackBar(BuildContext context, message) {
  Flushbar(
    duration: Duration(seconds: 2),
    // aroundPadding: EdgeInsets.all(10),
    borderRadius: 30,
    backgroundGradient: LinearGradient(
      colors: isDark(context)
          ? [
              Color(0xFF1F1F1F),
              Color(0xFF1F1F1F),
            ]
          : [
              Color(0xFF67B26F),
              Color(0xFF4ca2cd),
            ],
      stops: [0.7, 0.9],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 10,
      ),
    ],
    // All of the previous Flushbars could be dismissed by swiping down
    // now we want to swipe to the sides
    dismissDirection: FlushbarDismissDirection.VERTICAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    onStatusChanged: (FlushbarStatus) {
      Navigator.pop(context);
    },
    title: 'Success',
    message: message,
  )..show(context);
}

void showfailureSnackBar(BuildContext context, message) {
  Flushbar(
    duration: Duration(seconds: 2),
    // aroundPadding: EdgeInsets.all(10),
    borderRadius: 30,
    backgroundGradient: LinearGradient(
      colors: isDark(context)
          ? [
              Color(0xFF1F1F1F),
              Color(0xFF1F1F1F),
            ]
          : [
              Color(0xFFe52d27),
              Color(0xFFb31217),
            ],
      stops: [0.7, 0.9],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 10,
      ),
    ],
    onStatusChanged: (FlushbarStatus) {
      Navigator.pop(context);
    },
    // All of the previous Flushbars could be dismissed by swiping down
    // now we want to swipe to the sides
    dismissDirection: FlushbarDismissDirection.VERTICAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'Failure',
    message: message,
  )..show(context);
}

void showDailyFailureSnackBar(BuildContext context, message) {
  Flushbar(
    duration: Duration(seconds: 2),
    // aroundPadding: EdgeInsets.all(10),
    borderRadius: 30,
    backgroundGradient: LinearGradient(
      colors: isDark(context)
          ? [
              Color(0xFF1F1F1F),
              Color(0xFF1F1F1F),
            ]
          : [
              Color(0xFFe52d27),
              Color(0xFFb31217),
            ],
      stops: [0.7, 0.9],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 10,
      ),
    ],
    onStatusChanged: (FlushbarStatus) {
      // Navigator.pop(context);
    },
    // All of the previous Flushbars could be dismissed by swiping down
    // now we want to swipe to the sides
    dismissDirection: FlushbarDismissDirection.VERTICAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'Failure',
    message: message,
  )..show(context);
}

void showError(String msg, IconData icon, context, action) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: new AlertDialog(
            title: Stack(
              children: <Widget>[
                Image.asset(
                  isDark(context) ? 'images-white/logo.png' : 'images/logo.png',
                  color: Colors.white,
                  height: 50,
                ),
                Image.asset(
                  isDark(context) ? 'images-white/logo.png' : 'images/logo.png',
                  height: 50,
                ),
              ],
            ),
            shape: SuperellipseShape(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: FittedBox(
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(
                        icon,
                        color: isDark(context) ? Colors.white : Colors.black,
                      ),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: new Text('Back'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);

                  action();
                },
                child: new Text('Try again'),
              ),
            ],
          ),
        );
      });
}

void showAttendance(context, msg, msg2, msg2Color) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('Ok'),
            ),
          ],
          title: Image.asset(
            isDark(context) ? 'images-white/logo.png' : 'images/logo.png',
            height: 50,
          ),
          shape: SuperellipseShape(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    new Text(
                      msg,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Status' + " : " + ' ',
                            style: TextStyle(fontSize: 20)),
                        new Text(
                          msg2,
                          style: TextStyle(fontSize: 20, color: msg2Color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

final SweetSheet _sweetSheet = SweetSheet();

void vottomSheetSuccess(context) {
  _sweetSheet.show(
    isDismissible: false,
    context: context,
    title: Text("SUCCESS"),
    description: Text("Your request has been send successfully."),
    color: CustomSheetColor(
      main: Color(0xFF3773AC),
      accent: Color(0xFF3773AC),
      // icon: Color(0xff5A67D8),
    ),
    icon: Icons.check,
    positive: SweetSheetAction(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      title: 'Home Page',
    ),
  );
}

void bottomSheetFailure(context) {
  _sweetSheet.show(
    isDismissible: false,
    context: context,
    title: Text("Failure"),
    description: Text("Sorry the request failed. please try again later."),
    color: CustomSheetColor(
      main: Color(0xFF3773AC),
      accent: Color(0xFF3773AC),
      // icon: Color(0xff5A67D8),
    ),
    icon: Icons.check,
    positive: SweetSheetAction(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      title: 'Go Back',
    ),
  );
}
