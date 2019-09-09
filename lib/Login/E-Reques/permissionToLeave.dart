import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(LeaveHoliday());

class LeaveHoliday extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaveHolidayState();
  }
}

final _addressLeave = GlobalKey<FormState>();

// Map<String, int> body;

class _LeaveHolidayState extends State<LeaveHoliday> {
  Map leaveHolidayJson = {};

  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  String from;
  String to;
  String addressLeave = '';
  String reasonTravel = '';
  String emergencyAddress = '';
  String emergencyRelationship = '';
  String emergencyEmail = '';
  String emergencyPhoneNumber = '';
  String emergencyName = '';
  String emergencyOfficePhone = '';
  String emergencyMobile = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_addressLeave.currentState.validate()) {
            _addressLeave.currentState.save();
            getLeaveHoliday();
          }
        },
      ),
      appBar: appBarLogin(context, 'Leave During Holiday'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            color: Colors.white,
            child: ListView(children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _addressLeave,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        datePickers(context, (date) {
                          from = date.toString();
                        }, 'Leave From'),
                        datePickers(context, (date) {
                          to = date.toString();
                        }, 'Leave To'),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            addressLeave = x;
                          });
                        }, 'Address while on leave', true, TextInputType.text,
                            FontAwesomeIcons.mapMarked, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Reason is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            reasonTravel = x;
                          });
                        }, 'Reason for travel', true, TextInputType.text,
                            FontAwesomeIcons.question, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Contact number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyName = x;
                          });
                        }, 'Name ', true, TextInputType.text,
                            FontAwesomeIcons.user, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyEmail = x;
                          });
                        }, 'Email', true, TextInputType.emailAddress,
                            FontAwesomeIcons.inbox, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Relationship is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyRelationship = x;
                          });
                        }, 'Relationship', true, TextInputType.text,
                            FontAwesomeIcons.users, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Mobile number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyMobile = x;
                          });
                        }, 'Mobile Number', true, TextInputType.number,
                            FontAwesomeIcons.phoneAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyPhoneNumber = x;
                          });
                        }, 'Phone Number', true, TextInputType.number,
                            FontAwesomeIcons.phoneAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Office number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyOfficePhone = x;
                          });
                        }, 'Offie Phone Number', true, TextInputType.number,
                            FontAwesomeIcons.phoneAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            emergencyAddress = x;
                          });
                        }, 'Address', true, TextInputType.text,
                            FontAwesomeIcons.mapMarked, Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }

  Future getLeaveHoliday() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/leaveDuringHolidays'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'from': from.toString(),
          'to': to.toString(),
          'address_to': addressLeave,
          'reason': reasonTravel,
          'name': emergencyName,
          'email': emergencyEmail,
          'relationship': emergencyRelationship,
          'mobile_no': emergencyMobile,
          'residance_no': emergencyPhoneNumber,
          'office_no': emergencyOfficePhone,
          'address': emergencyAddress,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveHolidayJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (leaveHolidayJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: leaveHolidayJson['message'],
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
            context, getLeaveHoliday);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveHoliday);
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
