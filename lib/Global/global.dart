import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'package:url_launcher/url_launcher.dart';

Map studentJson = {};
String program = studentJson['data']['program'];
String userType = studentJson['data']['user_type'];

bool container = false;
bool disableForm = false;
bool copyRight = false;

//API-Key
String API = '965a0109d2fde592b05b94588bcb43f5';
//Global String

bool isValidat = true;

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
  } else {
    print('Could not Call');
  }
}

logOut(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    },
  );
  Widget continueButton = FlatButton(
    textColor: Colors.grey,
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog

  AlertDialog alert = AlertDialog(
    shape: SuperellipseShape(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    title: Image.asset(
      'images/logo.png',
      height: 50,
    ),
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Are you sure you want to logout ?"),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
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
