import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(LeaveApplication());

class LeaveApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaveApplicationState();
  }
}

final _leaveApplication = GlobalKey<FormState>();

// Map<String, int> body;

class _LeaveApplicationState extends State<LeaveApplication> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  List leaveTypesJson = [];
  Map leaveApplicationJson = {};
  Map leaveBalanceJson = {};

  int groupValue;
  String leaveType;
  String from;
  String to;

  String contactNo = '';
  String mobileNo = '';
  String documentSubmitted = '';
  String addressTo = '';
  String reasonLeave = '';

  @override
  void initState() {
    super.initState();
    getLeaveTypes();
    leaveBalanceJson.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true, //TODO: put in all page
      appBar: appBarLogin(context, 'Leave Application'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_leaveApplication.currentState.validate() && leaveType != null) {
            _leaveApplication.currentState.save();
            getLeaveApplication();
          }

          // getLeaveApplication();
          // print(value);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Leave Type',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Option',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        isExpanded: true,
                        value: leaveType,
                        items: leaveTypesJson
                                ?.map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item['leaveid'].toString(),
                                    child: Text(item['leavetype'].toString()),
                                  ),
                                )
                                ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            leaveType = value;
                            getLeaveBalance();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Balance',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                      leaveBalanceJson.isEmpty
                          ? ''
                          : leaveBalanceJson['Bal'] == null
                              ? ' '.toString()
                              : leaveBalanceJson['Bal'].toString(),
                      style: TextStyle(color: Colors.white),
//
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _leaveApplication,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        datePickers(context, (date) {
                          from = date.toString();
                        }, 'Leave From'),
                        SizedBox(
                          height: 10,
                        ),
                        datePickers(context, (date) {
                          to = date.toString();
                        }, 'Leave To'),
                        SizedBox(
                          height: 10,
                        ),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Contact number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            contactNo = x;
                          });
                        }, 'Contact number in UAE', true, TextInputType.number,
                            FontAwesomeIcons.phoneAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Mobile number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            mobileNo = x;
                          });
                        }, 'Mobile number in UAE', true, TextInputType.number,
                            FontAwesomeIcons.phoneAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Document is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            documentSubmitted = x;
                          });
                        }, 'Document Submitted', true, TextInputType.text,
                            FontAwesomeIcons.fileAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Adress is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            addressTo = x;
                          });
                        }, 'Address To', true, TextInputType.text,
                            FontAwesomeIcons.mapMarked, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Reason is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            reasonLeave = x;
                          });
                        }, 'Reason for leave', true, TextInputType.text,
                            FontAwesomeIcons.question, Colors.blue),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getLeaveTypes() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLeaveTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveTypesJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveTypes);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveTypes);
      }
    }
  }

  Future getLeaveApplication() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/leaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'from': from.toString(),
          'to': to.toString(),
          'contact_no': contactNo,
          'mobile_no': mobileNo,
          'document_submitted': documentSubmitted,
          'address_to': addressTo,
          'reason': reasonLeave,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveApplicationJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (leaveApplicationJson['success'] == '1') {
        showDoneInput(leaveApplicationJson['message'], context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveApplication);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveApplication);
      }
    }
  }

  Future getLeaveBalance() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLeaveTypeBalance'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'leave_type': leaveType,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveBalanceJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveBalance);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveBalance);
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
