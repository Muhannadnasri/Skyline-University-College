import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Conference());

class Conference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConferenceState();
  }
}

final _conference = GlobalKey<FormState>();

// Map<String, int> body;

class _ConferenceState extends State<Conference> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  String date;
  Map courseWithdrawalJson = {};

  List personalFamilyTimesJson = [];

  int groupValue;
  String fromTime;
  String session;

  String conferenceName = '';
  String conference = '';

  String toTime;
  @override
  void initState() {
    super.initState();

    getTimes();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_conference.currentState.validate()) {
            _conference.currentState.save();
            getTimes();
          }
        },
      ),
      appBar: appBarLogin(context, 'Conference'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _conference,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          globalForms(context, '', (String value) {
                            if (value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          }, (x) {
                            setState(() {
                              conferenceName = x;
                            });
                          }, 'Name', true, TextInputType.text,
                              FontAwesomeIcons.user, Colors.blue),
                          datePickers(context, (date) {
                            date = date.toString();
                          }, 'Data'),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'From Time',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: DropdownButton<String>(
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    isExpanded: true,
                                    value: fromTime,
                                    items: personalFamilyTimesJson
                                            ?.map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item['time_value']
                                                    .toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      Text(item['time_value']),
                                                ),
                                              ),
                                            )
                                            ?.toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        fromTime = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('To Time'),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  hint: Text(
                                    'Select Option',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  value: toTime,
                                  items: personalFamilyTimesJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value:
                                                  item['time_value'].toString(),
                                              child: Text(item['time_value']),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      toTime = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Session',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Select Events',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: session,
                                  items: ['Morning Session', 'Evening Session']
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      session = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          globalForms(context, '', (String value) {
                            if (value.trim().isEmpty) {
                              return 'Remark is required';
                            }
                            return null;
                          }, (x) {
                            setState(() {
                              conference = x;
                            });
                          }, 'Remark', true, TextInputType.text,
                              FontAwesomeIcons.question, Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getTimes() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getPersonalFamilyTimes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'emp_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            personalFamilyTimesJson =
                json.decode(response.body)['data']['times'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getTimes);
      } else {
        showLoading(false, context);
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getTimes);
      }
    }
  }

  Future getConference() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/outdoorEvent'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'type': 'conferenceform',
          'event_name': conferenceName,
          'event_date': date,
          'session': session,
          'from_time': fromTime,
          'to_time': toTime,
          'remark': conference,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            courseWithdrawalJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      print(courseWithdrawalJson);
      if (courseWithdrawalJson['success'] == '1') {
        showLoading(false, context);
        showDoneInput(courseWithdrawalJson['message'], context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getTimes);
      } else {
        showLoading(false, context);
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getTimes);
      }
    }
  }

  Widget datePickers(BuildContext context, onSaved, labelText) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
          // validator: validator,
          initialValue: initialValue,
          onSaved: onSaved,
          readOnly: true,
          decoration: InputDecoration(
            labelText: labelText,
            icon: Icon(
              Icons.date_range,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ]);
  }
}
