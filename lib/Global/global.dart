import 'package:easy_dialog/easy_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customDialog.dart';
import 'loader.dart';

bool isDark(context) {
  return Theme.of(context).brightness == Brightness.dark;
}

//TODO:  Color(0xFF121212) for dark mode color

String deviceId = 'Unknown';
String program = studentJson['data']['program'];
String userType = studentJson['data']['user_type'];

bool container = false;

bool copyRight = false;

List courseAllocationJson = [];

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
//

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
        title: Image.asset(
          'images/logo.png',
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
                    'images/logo.png',
                    height: 50,
                    color: isDark(context) ? Colors.white : Colors.black,
                  ),
                  Image.asset(
                    'images/logo.png',
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
                    Loader(),
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
              Color(0xFF104C90),
              Color(0xFF3773AC),
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
              Color(0xFF104C90),
              Color(0xFF3773AC),
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
    title: 'Failure',
    message: message,
  )..show(context);
}
textField(){
return null;
  
}

// void showError(context, title, yes) {
//   EasyDialog(
//     title: Text(
//       title,
//       style: TextStyle(
//           fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54),
//     ),
//     closeButton: false,
//     cornerRadius: 20,
//     fogOpacity: 0.60,
//     //TODO: Change fogOpacity
//     height: MediaQuery.of(context).size.height / 5,
//     contentList: [
//       SizedBox(
//         height: 20,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               alignment: Alignment.center,
//               child: RaisedButton(
//                   elevation: 5.0,
//                   color: Colors.green[300],
//                   child: Text(
//                     'Yes',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: yes),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               alignment: Alignment.center,
//               child: RaisedButton(
//                   elevation: 5.0,
//                   color: Colors.red[300],
//                   child: Text(
//                     'No',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ).show(context);
// }

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
                  'images/logo.png',
                  color: Colors.white,
                  height: 50,
                ),
                Image.asset(
                  'images/logo.png',
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

void showErrorInput(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black,
      fontSize: 15.0);
}

void showDoneInput(String msg, context) {
  Navigator.pop(context);

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.grey[400],
      textColor: Colors.black87,
      fontSize: 13.0);
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
            'images/logo.png',
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
