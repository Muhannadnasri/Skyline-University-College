import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(ReinStatement());

class ReinStatement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReinStatementState();
  }
}

final _documentry = GlobalKey<FormState>();

// Map<String, int> body;

class _ReinStatementState extends State<ReinStatement> {
  Map reinStatementJson = {};

  bool fall = false;
  bool spring = false;
  bool summer = false;
  String semester = "";

  bool incomplete = false;
  bool medical = false;
  bool death = false;
  bool personal = false;
  bool other = false;

  @override
  void initState() {
    super.initState();
    getReinStatement();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
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
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Reinstatment",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.powerOff,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Attend the class ',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Fall'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: fall,
                              onChanged: (value) {
                                spring = false;
                                summer = false;

                                setState(() {
                                  spring = false;
                                  summer = false;
                                  fall = value;
                                  value ? semester = "fall" : semester = "";
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Spring'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: spring,
                              onChanged: (value) {
                                setState(() {
                                  fall = false;
                                  summer = false;
                                  spring = value;
                                  value ? semester = "spring" : semester = "";
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Summer'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: summer,
                              onChanged: (value) {
                                setState(() {
                                  spring = false;
                                  fall = false;
                                  summer = value;
                                  value ? semester = "summer" : semester = "";
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Incomplete Grades'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: incomplete,
                              onChanged: (value) {
                                setState(() {
                                  incomplete = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Medical conditions'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: medical,
                              onChanged: (value) {
                                setState(() {
                                  medical = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Death In Family'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: death,
                              onChanged: (value) {
                                setState(() {
                                  death = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Personal Circumstances'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: personal,
                              onChanged: (value) {
                                setState(() {
                                  personal = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Other'),
                            Checkbox(
                              activeColor: Colors.purple,
                              value: other,
                              onChanged: (value) {
                                setState(() {
                                  if (other == true) {}
                                  other = value;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _documentry,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            maxLines: null,
                            onSaved: (x) {
                              documentry = x;
                            },
                            decoration: InputDecoration(
                              labelText: "Document",
                              fillColor: Colors.white,
                              helperStyle: TextStyle(fontSize: 13),
                              hintText: 'Enter Your Doucment Link',
                              hintStyle: TextStyle(fontSize: 15),
                              isDense: true,
                              prefixIcon: Icon(
                                FontAwesomeIcons.paperclip,
                                size: 15,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 35,
                      width: 80,
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
                      child: GestureDetector(
                          onTap: () {
                            getReinStatement();
                          },
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getReinStatement() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/appealReinstatement'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'attend_class': semester,
          'incomplete_grades': incomplete ? "True" : "False",
          'medical_conditions': medical ? "True" : "False",
          'death_in_family': death ? "True" : "False",
          'personal_circumstances': personal ? "True" : "False",
          'other': other ? "True" : "False",
          'documentry': documentry,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            reinStatementJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (reinStatementJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: reinStatementJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getReinStatement);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getReinStatement);
      }
    }
  }
}
