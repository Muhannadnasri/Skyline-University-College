import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
  bool showResetIcon = true;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarLogin(context, 'Leave Application'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_leaveApplication.currentState.validate() && leaveType != null) {
            _leaveApplication.currentState.save();
            getLeaveApplication();
          }
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  dropDownWidget(context, 'Select Option', leaveType,
                      leaveTypesJson, 'leaveid', 'leavetype', (value) {
                    setState(() {
                      leaveType = value;
                    });
                  }, 'Leave Type'),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Balance',
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
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
                      leaveBalanceJson.isEmpty || leaveBalanceJson == null
                          ? ''
                          : leaveBalanceJson['Bal'].toString(),
                      style: TextStyle(color: Colors.white),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            child: Text(
                              'Leave From',
                              style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        datePickers(
                          context,
                          (date) {
                            from = date.toString();
                          },
                          'Leave From',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            child: Text(
                              'Leave To',
                              style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
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
                        }, 'Contact number in UAE', TextInputType.number),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Mobile number is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            mobileNo = x;
                          });
                        }, 'Mobile number in UAE', TextInputType.number),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Document is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            documentSubmitted = x;
                          });
                        }, 'Document Submitted', TextInputType.text),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Adress is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            addressTo = x;
                          });
                        }, 'Address To', TextInputType.text),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Reason is required';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            reasonLeave = x;
                          });
                        }, 'Reason for leave', TextInputType.text),
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
        Uri.parse('https://skylineportal.com/moappad/api/test/LeaveTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Empid': studentJson['data']['user_id'],
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
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/facultyStaffleaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
// 'UserID'=>$user_id,
//     							'UserType'=>$usertype,
// 								'LeaveType'=>$leave_type,
// 								'LeaveBalance'=>$leave_balance,
// 								'ForwardedTo'=>$forwarded_to,
// 								'AddressWhileOnLeave'=>$address_to,
// 								'UAEContactNo'=>$contact_no,
// 								'LeaveFrom'=>$from,
// 								'LeaveTo'=>$to,
// 								'halfdaydate'=>$half_day_date,
// 								'HalfDay'=>$half_day,
// 								'HalfDaySession'=>$half_day_session,
// 								'LeaveDays'=>$leave_days,
// 								'LWP'=>$lwp,
// 								'ReasonForLeave'=>$reason,
// 								'CreatedBy'=>$user_id);

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
      showSuccessSnackBar(context, leaveApplicationJson['message']);
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
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/LeaveTypeBalance'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Empid': studentJson['data']['user_id'],
          'leaveid': leaveType,
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
