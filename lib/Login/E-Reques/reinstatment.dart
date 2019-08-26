import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

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
  Map policyDetailsJson = {};

  bool fall = false;
  bool spring = false;
  bool summer = false;
  String semester = "";
  String documentry = '';

  bool incomplete = false;
  bool medical = false;
  bool death = false;
  bool personal = false;
  bool other = false;

  @override
  void initState() {
    super.initState();
    getPolicyDetails();

    // getReinStatement();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (_documentry.currentState.validate() &&
                (incomplete == true ||
                    medical == true ||
                    medical == true ||
                    death == true ||
                    personal == true ||
                    other == true) &&
                semester.isNotEmpty) {
              _documentry.currentState.save();

              getReinStatement();
            } else {
              return showErrorInput(
                'Please Check Your Input',
              );
            }
          });
        },
      ),
      appBar: appBarLogin(context, 'Reinstatement'),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(policyDetailsJson.isEmpty
                        ? ''
                        : policyDetailsJson['data']['description']),
                  ),
                ],
                title: Text('Policy Details'),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Attend the class ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
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
                            ),
                            Text('Fall'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: spring,
                              onChanged: (value) {
                                setState(() {
                                  fall = false;
                                  summer = false;
                                  spring = value;
                                  value ? semester = "spring" : semester = "";
                                });
                              },
                            ),
                            Text('Spring'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: summer,
                              onChanged: (value) {
                                setState(() {
                                  spring = false;
                                  fall = false;
                                  summer = value;
                                  value ? semester = "summer" : semester = "";
                                });
                              },
                            ),
                            Text('Summer'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: incomplete,
                              onChanged: (value) {
                                setState(() {
                                  incomplete = value;
                                });
                              },
                            ),
                            Text('Incomplete Grades'),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: medical,
                              onChanged: (value) {
                                setState(() {
                                  medical = value;
                                });
                              },
                            ),
                            Text('Medical conditions'),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: death,
                              onChanged: (value) {
                                setState(() {
                                  death = value;
                                });
                              },
                            ),
                            Text('Death In Family'),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: personal,
                              onChanged: (value) {
                                setState(() {
                                  personal = value;
                                });
                              },
                            ),
                            Text('Personal Circumstances'),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.blue,
                              value: other,
                              onChanged: (value) {
                                setState(() {
                                  if (other == true) {}
                                  other = value;
                                });
                              },
                            ),
                            Text('Other'),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                      key: _documentry,
                      child: globalForms(context, '', (String value) {
                        if (value.trim().isEmpty) {
                          return 'Documentry is required';
                        }
                        return null;
                      }, (x) {
                        setState(() {
                          documentry = x;
                        });
                      }, 'Documentry', true, TextInputType.text,
                          FontAwesomeIcons.fileAlt, Colors.blue)),
                  SizedBox(
                    height: 10,
                  ),
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

      if (reinStatementJson['success'] == '1') {
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

  Future getPolicyDetails() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getRequestFormsText'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'name': 'changeClassTimings',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            policyDetailsJson = json.decode(response.body);
          },
        );
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPolicyDetails);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPolicyDetails);
      }
    }
  }
}
