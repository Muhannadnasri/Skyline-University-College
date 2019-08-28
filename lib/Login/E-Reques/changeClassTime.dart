import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(ChangeClassTime());

class ChangeClassTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeClassTimeState();
  }
}

// Map<String, int> body;

class _ChangeClassTimeState extends State<ChangeClassTime> {
  final _reason = GlobalKey<FormState>();

  Map policyChangeTimeJson = {};
  Map currentTimeMessageJson = {};
  Map currentTimeJson = {};
  List currentAndNewShiftJson = [];
  Map changeClassTimingJson = {};
  Map policyDetailsJson = {};
  String reason = '';

  String newShift;
  bool isValidat = false;
  @override
  void initState() {
    super.initState();

    getCurrentAndNewShift();
    getPolicyDetails();
    currentTimeJson.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (_reason.currentState.validate() && newShift != null) {
              _reason.currentState.save();

              getChangeClassTiming();
            }
          });
        },
      ),
      appBar: appBarLogin(
        context,
        'Change Class Time',
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            ExpansionTile(
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
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                      child: Text(
                        'Current Timings',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 500,
                    height: 50,
                    alignment: Alignment.center,
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
                    child: Text(
                      currentTimeJson.isEmpty
                          ? ''
                          : currentTimeJson['Shift_Desc'] == 'NA'
                              ? ''
                              : currentTimeJson['Shift_Desc'],
                      style: TextStyle(color: Colors.white),
//
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                        child: Text(
                          'New Timings',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Please Select Option',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          isExpanded: true,
                          value: newShift,
                          items: currentAndNewShiftJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item['Shift_Desc'],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item['Shift_Desc']),
                                      ),
                                    ),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              newShift = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                      key: _reason,
                      child: globalForms(context, '', (String value) {
                        if (value.trim().isEmpty) {
                          return 'Your Reason is required';
                        }
                        return null;
                      }, (x) {
                        setState(() {
                          reason = x;
                        });
                      }, 'Reason', true, TextInputType.text,
                          FontAwesomeIcons.question, Colors.blue)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getRequestFormsText() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getRequestFormsText'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'name': 'changeclasstimings',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            policyChangeTimeJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrentAndNewShift);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrentAndNewShift);
      }
    }
  }

  Future getCurrentAndNewShift() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCurrentAndNewShift'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            currentTimeMessageJson = json.decode(response.body);
            currentTimeJson =
                json.decode(response.body)['data']['current_shift'];

            currentAndNewShiftJson =
                json.decode(response.body)['data']['new_shift'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrentAndNewShift);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrentAndNewShift);
      }
    }
  }

  Future getChangeClassTiming() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/changeClassTiming'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'current_timing': currentTimeJson['Shift_Desc'],
          'new_timing': newShift,
          'reason': reason,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            changeClassTimingJson = json.decode(response.body);
          },
        );
        showLoading(false, context);

        if (changeClassTimingJson['success'] == '1') {
          showLoading(false, context);
          Fluttertoast.showToast(
              msg: changeClassTimingJson['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.grey[400],
              textColor: Colors.black87,
              fontSize: 13.0);
        }
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrentAndNewShift);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrentAndNewShift);
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
