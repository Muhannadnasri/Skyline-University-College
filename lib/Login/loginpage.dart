import 'dart:convert';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/widgets/bezierContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginApp extends StatefulWidget {
  LoginApp({Key key, this.title, this.destination}) : super(key: key);

  final String title;
  final String destination;
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final _logInForm = GlobalKey<FormState>();
  final localAuth = LocalAuthentication();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();

    quick();
  }

  @override
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: isDark(context) ? Colors.white : Colors.black,
                )),
            Text('Back',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark(context) ? Colors.white : Colors.black,
                ))
          ],
        ),
      ),
    );
  }

  Widget _entryField(
      String title,
      IconData icon,
      TextInputAction textInputAction,
      String Function(String) validator,
      void Function(String) onSaved,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          // ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              style: TextStyle(
                color: isDark(context) ? Colors.black : Colors.black,
              ),
              textInputAction: textInputAction,
              validator: validator,
              onSaved: onSaved,
              obscureText: isPassword,
              decoration: InputDecoration(
                  prefixIcon: Icon(icon, color: Color(0xFF104c90), size: 20),
                  labelText: title,
                  labelStyle: TextStyle(
                    color: isDark(context) ? Colors.black : Colors.black,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        if (_logInForm.currentState.validate()) {
          _logInForm.currentState.save();
          setState(() {
            logIn();
          });
        } else {
          return;
          // return showErrorInput('Please check your input');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.centerRight,
                colors: [Color(0xFF275d9b), Color(0xFF0e4481)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _submitButtonPass() {
    return GestureDetector(
      onTap: () {
        // if (_logInForm.currentState.validate()) {
        //   _logInForm.currentState.save();
        //   setState(() {
        //     logIn();
        //   });
        // } else {
        //   return;
        //   // return showErrorInput('Please check your input');
        // }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            // fit: BoxFit.scaleDown,

            image: NetworkImage(
              'https://smartsso.dubai.gov.ae/images/UAEPASS_Sign_in_Btn_Outline_Pill_Focus.png',
            ),
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.center,
          //   end: Alignment.centerRight,
          //   colors: [Color(0xFF275d9b), Color(0xFF0e4481)],
          // ),
        ),
        // child: IconButton(
        //   icon: Image.network(
        //       'https://smartsso.dubai.gov.ae/images/AR_UAEPASS_Sign_in_Btn_Outline_Pill_Focus.png'),
        //   iconSize: 50,
        //   onPressed: () {},
        // )
        // Text(
        //   'Login',
        //   style: TextStyle(fontSize: 20, color: Colors.white),
        // ),
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 141,
      width: 205,
      // height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        boxShadow: [],
        image: DecorationImage(
          image: AssetImage(
            'images/skyline.png',
          ),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _logInForm,
      child: Column(
        children: <Widget>[
          _entryField(
            "User ID",
            FontAwesomeIcons.userAlt,
            TextInputAction.next,
            (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
              return null;
            },
            (x) {
              username = x;
            },
          ),
          _entryField("Password", Icons.lock, TextInputAction.done,
              (String value) {
            if (value.trim().isEmpty) {
              return 'Password is required';
            }
            return null;
          }, (x) {
            password = x;
          }, isPassword: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: isDark(context) ? Color(0xFF1F1F1F) : Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 50),
                        _emailPasswordWidget(),
                        SizedBox(height: 20),
                        _submitButton(),
                        SizedBox(height: 20),
                        _submitButtonPass(),
                        SizedBox(height: height * .055),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ));
  }

  Future logIn() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.parse("https://skylineportal.com/moappad/api/test/login"),
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
          if (response.body.contains("</div>"))
            studentJson = json.decode(response.body
                .substring(response.body.lastIndexOf("</div>") + 6));
          else
            studentJson = json.decode(response.body);
        });

        // switch (studentJson['success']) {
        //   case "1":
        //     {
        //       SharedPreferences prefs = await SharedPreferences.getInstance();
        //       prefs.setString('username', username);
        //       prefs.setString('password', password);
        //       loggedin = true;
        //       showLoading(false, context);
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(
        //               builder: (BuildContext context) => HomeLogin()),
        //           (Route<dynamic> route) => false);
        //     }
        //     break;
        //   case "0":
        //     {
        //       username = '';
        //       password = '';
        //       loggedin = false;
        //       SharedPreferences prefs = await SharedPreferences.getInstance();
        //       prefs.setString('username', username);
        //       prefs.setString('password', password);
        //       showLoading(false, context);
        //       final snackBar =
        //           SnackBar(content: Text('Invalid users credentials..!'));
        //       _scaffoldKey.currentState.showSnackBar(snackBar);

        //       studentJson = {};
        //     }
        // }

        if (widget.destination == null) {
          if (studentJson['success'] == "1") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            loggedin = true;
            showLoading(false, context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeLogin()),
                (Route<dynamic> route) => false);
          } else if (studentJson['message'] == "Invalid user credentials..!") {
            username = '';
            password = '';
            loggedin = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            showLoading(false, context);

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid user credentials..!')));

            studentJson = {};
          } else if (studentJson['message'] == "User info not available...") {
            username = '';
            password = '';
            loggedin = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            showLoading(false, context);

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User info not available...')));

            studentJson = {};
          }
        } else {
          if (studentJson['success'] == "1") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            loggedin = true;
            showLoading(false, context);

            Navigator.of(context).pushNamed('/' + widget.destination);
          } else if (studentJson['message'] == "Invalid user credentials..!") {
            username = '';
            password = '';
            loggedin = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            showLoading(false, context);

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid user credentials..!')));

            studentJson = {};
          } else if (studentJson['message'] == "User info not available...") {
            username = '';
            password = '';
            loggedin = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username', username);
            prefs.setString('password', password);
            showLoading(false, context);

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User info not available...')));

            studentJson = {};
          }
        }

        // if (studentJson['success'] == "1") {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('username', username);
        //   prefs.setString('password', password);
        //   loggedin = true;
        //   showLoading(false, context);
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
        //       (Route<dynamic> route) => false);
        // } else if (studentJson['message'] == "Invalid user credentials..!") {
        //   username = '';
        //   password = '';
        //   loggedin = false;
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('username', username);
        //   prefs.setString('password', password);
        //   showLoading(false, context);

        //   ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text('Invalid user credentials..!')));

        //   studentJson = {};
        // } else if (studentJson['message'] == "User info not available...") {
        //   username = '';
        //   password = '';
        //   loggedin = false;
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('username', username);
        //   prefs.setString('password', password);
        //   showLoading(false, context);

        //   ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text('User info not available...')));

        //   studentJson = {};
        // }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, logIn);
      } else {
        showLoading(false, context);
        // showError(
        //     "Sorry, we can't connect", Icons.perm_scan_wifi, context, logIn);
      }
    }
  }

  Future qLogin() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse("https://skylineportal.com/moappad/api/test/login"),
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

        if (widget.destination == null) {
          if (studentJson["success"] == "1") {
            loggedin = true;
            showLoading(false, context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeLogin()),
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
        } else {
          if (studentJson["success"] == "1") {
            loggedin = true;
            showLoading(false, context);

            Navigator.of(context).pushNamed('/' + widget.destination);
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => HomeLogin()),
            //     (Route<dynamic> route) => false);
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

        // if (studentJson["success"] == "1") {
        //   loggedin = true;
        //   showLoading(false, context);
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
        //       (Route<dynamic> route) => false);
        // } else if (studentJson["success"] == "0") {
        //   username = '';
        //   password = '';
        //   loggedin = false;
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('username', username);
        //   prefs.setString('password', password);
        //   showLoading(false, context);
        // }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, qLogin);
      } else {
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

    if (username != '' && password != '') {
      if (await localAuth.canCheckBiometrics) {
        bool didAuthenticate = await localAuth.authenticate(
            localizedReason: 'Please authenticate to login to your account',
            stickyAuth: true,
            sensitiveTransaction: true);

        if (didAuthenticate) {
          setState(() {
            qLogin();
          });
        } else {
          setState(() {
            username = username;
            password = password;
          });
        }
      }
    }
  }
}
