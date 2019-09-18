import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

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
              title: Image.asset(
                'images/logo.png',
                height: 50,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: new Text('Please Wait....'),
                    ),
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

void showError(String msg, IconData icon, context, action) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: new AlertDialog(
            title: Image.asset(
              'images/logo.png',
              height: 50,
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
                      child: new Icon(icon),
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

void showAttendance(context, msg) {
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
          content: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  msg,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      });
}
