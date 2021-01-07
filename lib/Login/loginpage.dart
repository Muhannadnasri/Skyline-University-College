import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/home.dart';
import 'package:skyline_university/widgets/custom_shape.dart';
import 'package:skyline_university/widgets/responsive_ui.dart';
import 'package:skyline_university/widgets/textformfield.dart';

void main() => runApp(MaterialApp(
      home: LoginApp(),
    ));

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => new _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final _logInForm = GlobalKey<FormState>();
  final localAuth = LocalAuthentication();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String deviceToken = '';
  final focus = FocusNode();
  bool _obscuredText = true;

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  void initState() {
    super.initState();

    quick();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return new Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'images/skyline_white.png',
          // fit: BoxFit.cover,
          height: 40,
          width: 200,
        ),
        elevation: 0.0,
      ),
      backgroundColor: isDark(context) ? Color(0xFF1F1F1F) : Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                clipShape(),
                welcomeTextRow(),
                signInTextRow(),
                form(),
                // forgetPassTextRow(),
                SizedBox(height: _height / 12),
                button(),
                // signUpTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF275d9b), Color(0xFF0e4481)],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF104c90), Color(0xFF0e4481)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _logInForm,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
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
      // textEditingController: emailController,
      icon: FontAwesomeIcons.userAlt,
      hint: "User ID",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      // textEditingController: passwordController,
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
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _toggle();
            });
          },
          child: Icon(
            _obscuredText ? Icons.visibility_off : Icons.visibility,
            size: 20,
            color: Color(0xFF144C90),
          )),
      icon: Icons.lock,
      obscureText: _obscuredText,
      hint: "Password",
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark(context) ? Colors.white : Color(0xFF1F1F1F),
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Please sign in to continue",
            style: TextStyle(
              color: isDark(context) ? Colors.white : Color(0xFF1F1F1F),
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        // print("Routing to your account");
        setState(() {
          logIn();
        });
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 2.75 : _width / 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Color(0xFF275d9b), Color(0xFF104c90)],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 13))),
      ),
    );
  }

  Future logIn() async {
    if (_logInForm.currentState.validate()) {
      _logInForm.currentState.save();
    } else {
      return null;
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
        } else if (studentJson['message'] == "Invalid users credentials..!") {
          username = '';
          password = '';
          loggedin = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('password', password);
          showLoading(false, context);
          final snackBar =
              SnackBar(content: Text('Invalid users credentials..!'));
          _scaffoldKey.currentState.showSnackBar(snackBar);

          studentJson = {};
        } else if (studentJson['message'] == "User info not available...") {
          username = '';
          password = '';
          loggedin = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('password', password);
          showLoading(false, context);
          final snackBar =
              SnackBar(content: Text('User info not available...'));
          _scaffoldKey.currentState.showSnackBar(snackBar);

          studentJson = {};
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, logIn);
      } else {
        print(x);
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
        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate to login to your account');

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
