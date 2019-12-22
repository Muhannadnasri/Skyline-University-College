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
      bottomNavigationBar: currentTimeJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                setState(() {
                  if (_reason.currentState.validate() && newShift != null) {
                    _reason.currentState.save();

                    sendChangeClassTiming();
                  }
                });
              },
            ),
      appBar: appBarLogin(
        context,
        'Change Class Time',
      ),
      body: currentTimeJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                          child: Text(
                            'Current Timings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
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
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            child: Text(
                              'New Timings',
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Please Select Option',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              underline: Container(
                                height: 1,
                                color: Color(0xFF2f2f2f),
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
                          child: globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Your Reason is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                reason = x;
                              });
                            },
                            'Reason',
                            TextInputType.text,
                          )),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future getCurrentAndNewShift() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/CurrentAndNewShift'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
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

  Future sendChangeClassTiming() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/changeClassTiming'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'currentTiming': currentTimeJson['Shift_Desc'],
          'newTiming': newShift,
          'reason': reason,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            changeClassTimingJson = json.decode(response.body);
          },
        );
        showLoading(false, context);

        showSuccessSnackBar(context, changeClassTimingJson['message']);
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
}
