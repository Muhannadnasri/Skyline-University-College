import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skyline_university/Global/global.dart';

import 'package:skyline_university/Global/zigzag.dart';

import 'package:http/http.dart' as http;

import 'package:skyline_university/Login/home.dart';

void main() => runApp(MaterialApp(
      home: LoginApp(),
    ));

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => new _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final _logInForm = GlobalKey<FormState>();
  // Map studentMessageJson = {};

  void initState() {
    super.initState();
    // qLogin();
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              ZigZag(
                clipType: ClipType.waved,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
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
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius:
                                      70.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      5.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: Image.asset(
                              'images/logohd.png',
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Skyline University College',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 5.0),
                              blurRadius: 2.0,
                              color: Colors.black,
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(330),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Login",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: .6)),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Form(
                            key: _logInForm,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text("Username",
                                          style: TextStyle(
                                              fontFamily: "Poppins-Medium",
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(26))),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Username is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (x) {
                                      username = x;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0)),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text("Password",
                                          style: TextStyle(
                                              fontFamily: "Poppins-Medium",
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(26))),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Password is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (x) {
                                      password = x;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(300),
                          height: ScreenUtil.getInstance().setHeight(95),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF104C90),
                                Color(0xFF3773AC)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF3773AC).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  logIn();
                                });
                              },
                              child: Center(
                                child: Text("SIGNIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future logIn() async {
    if (_logInForm.currentState.validate()) {
      _logInForm.currentState.save();
    } else {
      return showErrorInput('Please check your input');
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/login"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'username': username,
          'password': password,
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicetype': '1',
          'devicetoken': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          studentJson = json.decode(response.body);
          // studentMessageJson = json.decode(response.body);
        });

        if (studentJson['success'] == "1") {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('username', username);
          prefs.setString('password', password);

          loggedin = true;
          showLoading(false, context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
              (Route<dynamic> route) => false);
        } else if (studentJson['success'] == "0") {
          username = '';
          password = '';
          loggedin = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('password', password);

          showErrorInput(studentJson['message']);
          Navigator.pop(context);
          studentJson = {};
        }
      }
    } catch (x) {
      print(studentJson.toString());
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, logIn);
      } else {
        showLoading(false, context);
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, logIn);
      }
    }
  }

  // Future qLogin() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   username = (prefs.getString('username') ?? '');
  //   password = (prefs.getString('password') ?? '');

  //   if (username == '') {
  //     setState(() {
  //       showLoading(false, context);
  //     });
  //     return;
  //   } else {}
  //   try {
  //     final response = await http.post(
  //       Uri.encodeFull("https://skylineportal.com/moappad/api/web/login"),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'username': username,
  //         'password': password,
  //         'usertype': '1',
  //         'ipaddress': '1',
  //         'deviceid': '1',
  //         'devicetype': '1',
  //         'devicetoken': '1',
  //         'devicename': '1'
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         studentJson = json.decode(response.body);
  //       });

  //       if (studentJson["success"] == "1") {
  //         loggedin = true;
  //         showLoading(false, context);
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
  //             (Route<dynamic> route) => false);
  //       } else if (studentJson["success"] == "0") {
  //         username = '';
  //         password = '';
  //         loggedin = false;
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         prefs.setString('username', username);
  //         prefs.setString('password', password);
  //         showLoading(false, context);
  //       }
  //     }
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);
  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, qLogin);
  //     }
  //   }
  // }
}
