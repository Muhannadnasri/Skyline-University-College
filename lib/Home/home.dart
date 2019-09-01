import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_university/Global/global.dart';

import 'package:skyline_university/Login/home.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceId = 'Unknown';

  @override
  void initState() {
    super.initState();

    qLogin();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
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

      // PreferredSize(
      //   preferredSize: Size.fromHeight(110.0),
      //   child: Stack(
      //     children: <Widget>[
      //       Column(
      //         children: <Widget>[
      //           ZigZag(
      //             clipType: ClipType.waved,
      //             child: Container(
      //               height: MediaQuery.of(context).size.height / 6,
      //               decoration: new BoxDecoration(
      //                 gradient: LinearGradient(
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                   colors: [
      //                     Color(0xFF104C90),
      //                     Color(0xFF3773AC),
      //                   ],
      //                   stops: [
      //                     0.5,
      //                     0.9,
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Center(
      //         child: Container(
      //           height: 200,
      //           width: 200,
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               fit: BoxFit.fitWidth,
      //               alignment: Alignment.center,
      //               image: AssetImage(
      //                 'images/skyline_white.png',
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        child: ListView(
          children: <Widget>[
            FittedBox(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/HomeAdmission");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,

                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                              ),
                              width: 110,
                              height: 100,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/register.png',
                                        height: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Admission',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/homePrograms");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,

                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                              ),
                              width: 110,
                              height: 100,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/programs.png',
                                        height: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Programs',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/News");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                              width: 110,
                              height: 100,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/news.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'News',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/Location');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                              width: 110,
                              height: 100,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/location.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Location',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/HomeInfo");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                              child: Container(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/info.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'SUC Info',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/LoginApp");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              height: 100,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/login.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'SUC Login',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/Events");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/events.png',
                                        height: 50,
                                      ),
                                      Text(
                                        'Events',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/FAQ");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/questions.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'FAQ?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/Gallery");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        15.0) //         <--- border radius here
                                    ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius:
                                        100.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        2, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                              child: Container(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/gallery.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/apptutudeForm");
                      },
                      child: Container(
                        width: 110,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          border: Border.all(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  15.0) //         <--- border radius here
                              ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white30,
                              blurRadius:
                                  100.0, // has the effect of softening the shadow
                              spreadRadius:
                                  2, // has the effect of extending the shadow
                              offset: Offset(
                                5.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Container(
                          width: 90,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/gallery.png',
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Apptutude Test',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    } catch (x) {
      print(x);
    }
  }

  Future qLogin() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = (prefs.getString('username') ?? '');
    password = (prefs.getString('password') ?? '');
    // const MethodChannel _kChannel =
    //     MethodChannel('plugins.flutter.io/shared_preferences');
    // final Map<Object, Object> fromSystem =
    //     await _kChannel.invokeMethod('getAll');
    // print(fromSystem.toString());

    try {
      final response = await http.post(
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
        print('non');
        setState(() {
          studentJson = json.decode(response.body);
        });
      }

      if (studentJson["success"] == "1") {
        print('enter');

        loggedin = true;
        showLoading(false, context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomeLogin()),
            (Route<dynamic> route) => false);
      } else if (studentJson["success"] == "0") {
        print('exit');
        username = '';
        password = '';
        loggedin = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        prefs.setString('password', password);

        showLoading(false, context);
      }
      getLogs();
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, qLogin);
      }
    }
  }
}
