import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quick_actions/quick_actions.dart';
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

  String deviceToken = '';
  final focus = FocusNode();
  void initState() {
    super.initState();

    quick();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: isDark(context) ? Color(0xFF1F1F1F) : Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              ZigZag(
                clipType: ClipType.waved,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
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
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
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
                              height: MediaQuery.of(context).size.height / 7,
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
                    height: ScreenUtil.getInstance().setHeight(400),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isDark(context) ? Colors.white : Colors.black,
                            width: 0.4),
                        color: isDark(context) ? Colors.black : Colors.white,
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
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: ScreenUtil.getInstance().setSp(45),
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
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(26))),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus);
                                    },
                                    textInputAction: TextInputAction.next,
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
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        hintText: "Username",
                                        hintStyle: TextStyle(fontSize: 12.0)),
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
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(26))),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                    focusNode: focus,
                                    onFieldSubmitted: (term) {
                                      logIn();
                                    },
                                    textInputAction: TextInputAction.done,
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
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
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
                        onTap: () {
                          setState(() {
                            logIn();
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(300),
                          height: ScreenUtil.getInstance().setHeight(95),
                          decoration: BoxDecoration(
                              gradient: isDark(context)
                                  ? LinearGradient(colors: [
                                      Color(0xFF1F1F1F),
                                      Color(0xFF1F1F1F),
                                    ])
                                  : LinearGradient(colors: [
                                      Color(0xFF104C90),
                                      Color(0xFF3773AC)
                                    ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(.3),
                                    offset: Offset(0.5, 5.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Text("SIGNIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      letterSpacing: 1.0)),
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
      // return showErrorInput('Please check your input');
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/test/login"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'username': username,
          'password': password,
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': deviceId,
          'devicetype': '1',
          'devicetoken': deviceToken,
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          studentJson = json.decode(response.body);
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
          // showErrorInput(studentJson['message']);
          Navigator.pop(context);

          studentJson = {};
        }
      }
    } catch (x) {
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

  Future qLogin() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/test/login"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          studentJson = json.decode(response.body);
        });

        if (studentJson["success"] == "1") {
          print(studentJson['user_id']);
          loggedin = true;
          showLoading(false, context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
              (Route<dynamic> route) => false);
        } else if (studentJson["success"] == "0") {
          username = '';
          password = '';
          loggedin = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('password', password);
          showLoading(false, context);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, qLogin);
      } else {
//ToDo:here
        showLoading(false, context);
//
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, qLogin);

        //

      }
    }
  }

  Future quick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = (prefs.getString('username') ?? '');
    password = (prefs.getString('password') ?? '');

    if (username == '') {
    } else {
      setState(() {
        qLogin();
      });
    }
  }
}
