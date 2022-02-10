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

void main() => runApp(LeaveApplicationForm());

class LeaveApplicationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaveApplicationFormState();
  }
}

final _leaveApplicationForm = GlobalKey<FormState>();

// Map<String, int> body;

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  List leaveTypesJson = [];
  Map leaveApplicationFormJson = {};
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  bool showResetIcon = true;

  String from;
  String to;

  String contactNo = '';
  String residenceContactNumber = '';
  String mobileNumber = '';
  String documentSubmitted = '';
  String reasonLeave = '';
  String addressTo = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_leaveApplicationForm.currentState.validate()) {
            _leaveApplicationForm.currentState.save();
            getLeaveApplication();
          }

          // getLeaveApplication();
        },
      ),
      appBar: appBarLogin(context, 'Leave Application'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _leaveApplicationForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                'Date to Leave',
                                style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          datePickers(context, (date) {
                            from = date.toString();
                          }, 'Leave From'),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                'Date to Return',
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
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Contact number is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                residenceContactNumber = x;
                              });
                            },
                            'Residence Contact Number',
                            TextInputType.number,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Mobile number is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                mobileNumber = x;
                              });
                            },
                            'Mobile Number',
                            TextInputType.number,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Document is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                documentSubmitted = x;
                              });
                            },
                            'Document Submitted',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Adress is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                addressTo = x;
                              });
                            },
                            'Address To',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Reason is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                reasonLeave = x;
                              });
                            },
                            'Reason For Leave',
                            TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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

  Future getLeaveApplication() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/leaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'from': from.toString(),
          'to': to.toString(),
          'contact_no': residenceContactNumber,
          'mobile_no': mobileNumber,
          'document_submitted': documentSubmitted,
          'address_to': addressTo,
          'reason': reasonLeave,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveApplicationFormJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (leaveApplicationFormJson['success'] == '0') {
        showfailureSnackBar(context, leaveApplicationFormJson['message']);
      }
      if (leaveApplicationFormJson['success'] == '1') {
        showSuccessSnackBar(context, leaveApplicationFormJson['message']);
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
            contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
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
