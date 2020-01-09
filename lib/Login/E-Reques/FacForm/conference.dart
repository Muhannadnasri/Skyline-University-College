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
import 'package:skyline_university/Global/dropDownWidget.dart';
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
  bool showResetIcon = true;

  String date;
  Map conferenceJson = {};

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
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_conference.currentState.validate()) {
            _conference.currentState.save();
            sendConference();
          }
        },
      ),
      appBar: appBarLogin(context, 'Conference'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                          }, 'Name', TextInputType.text),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          datePickers(context, (date) {
                            date = date.toString();
                          }, 'Data'),
                          SizedBox(
                            height: 5,
                          ),
                          dropDownWidget(
                            context,
                            'Select Option',
                            fromTime,
                            personalFamilyTimesJson,
                            'time_text',
                            'time_text',
                            (value) {
                              setState(() {
                                fromTime = value;
                              });
                            },
                            'From Time',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          dropDownWidget(
                            context,
                            'Select Option',
                            toTime,
                            personalFamilyTimesJson,
                            'time_text',
                            'time_text',
                            (value) {
                              setState(() {
                                toTime = value;
                              });
                            },
                            'To Time',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                'Session',
                                style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
                                    child: Text(
                                      'Select Events',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
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
                            height: 5,
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
                          }, 'Remark', TextInputType.text),
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
            'https://skylineportal.com/moappad/api/test/OutdoorEventTime'),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            personalFamilyTimesJson = json.decode(response.body)['data'];
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
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getTimes);
      }
    }
  }

  Future sendConference() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/outdoorEvent'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'EmpNumber': studentJson['data']['user_id'],
          'EventName': conferenceName,
          'Eventdate': date,
          'Shift': session,
          'Fromtime': fromTime,
          'ToTime': toTime,
          'REASON': conference,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            conferenceJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      showSuccessSnackBar(context, conferenceJson['message']);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendConference);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendConference);
      }
    }
  }

  Widget datePickers(BuildContext context, onSaved, labelText) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 5.0),
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
          validator: (date) {
            if (date == null) {
              return 'Date is required';
            }
            return null;
          },
          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
          initialValue: initialValue,
          onSaved: onSaved,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDark(context)
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black,
              ),
            ),
            fillColor: Colors.green,
          ),
        ),
      ),
    ]);
  }
}
