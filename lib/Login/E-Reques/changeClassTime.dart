import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:superellipse_shape/superellipse_shape.dart';

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
  String reason = '';

  String newShift;
  bool isValidat = false;
  @override
  void initState() {
    super.initState();

    getCurrentAndNewShift();
    currentTimeJson.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    "Change Class Timing",
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
                        'Current Timings',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'News Timings',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Please Select Option',
                            style: TextStyle(color: Colors.black),
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
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _reason,
                    onChanged: () {
                      if (_reason.currentState.validate()) {
                        isValidat = true;
                        return 'Please check your input';
                      } else {
                        isValidat = false;
                        return null;
                      }
                    },
                    child: GlobalForms(
                      context,
                      "Please enter you'r reason",
                      '',
                      isValidat
                          ? FontAwesomeIcons.checkCircle
                          : !isValidat ? FontAwesomeIcons.timesCircle : null,
                      isValidat ? Colors.green : !isValidat ? Colors.red : null,
                      (String value) {
                        if (value.length < 3 ||
                            value.isEmpty ||
                            _reason == null) {
                          isValidat = false;
                          return 'Please check your input';
                        } else {
                          isValidat = true;
                          return null;
                        }
                      },
                      (x) {
                        setState(() {
                          reason = x;
                        });
                      },
                      'Reason',
                    ),
                  ),

                  //  Forms(
                  //   context,
                  //   'Reason',
                  //   '',
                  //   FontAwesomeIcons.question,
                  //   Colors.purple,
                  //   (x) {
                  //     if (x.length < 3 || x.length > 30) {
                  //       setState(() {
                  //         isValidat = false;
                  //       });
                  //     } else {
                  //       setState(() {
                  //         isValidat = true;
                  //       });
                  //     }
                  //   },
                  //   (x) {
                  //     setState(() {
                  //       reason = x;
                  //     });
                  //   },
                  //   isValidat
                  //       ? Colors.green
                  //       : !isValidat ? Colors.red : Colors.grey,
                  // ),

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
                            setState(() {
                              if (_reason.currentState.validate() &&
                                  newShift != null) {
                                _reason.currentState.save();

                                print(reason.toString());

                                getChangeClassTiming();
                              } else {
                                return null;
                              }
                            });
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

//TODO: RequestType
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

//TODO: Amount
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
      }
      if (changeClassTimingJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: changeClassTimingJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
      if (changeClassTimingJson['success'] == '1') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: changeClassTimingJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
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
}
