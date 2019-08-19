import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(PassportWithdrawal());

class PassportWithdrawal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PassportWithdrawalState();
  }
}

final _passportWithdrawal = GlobalKey<FormState>();

// Map<String, int> body;

class _PassportWithdrawalState extends State<PassportWithdrawal> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  Map passportWithdrawalJson;

  int groupValue;
  String ID;

  String localName = '';
  String localNumber = '';
  String internationalName = '';
  String internationalNumber = '';
  String reasonPassport = '';

  @override
  void initState() {
    super.initState();
    disableForm = true;

    // getPassportWithdrawal();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true, //todo: On all Form
      appBar: appBarLogin(context, 'Passport Withdrawal'),
      body: Container(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Form(
                        key: _passportWithdrawal,
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
                                localName = x;
                              });
                            }, 'Contact Local Name', false, TextInputType.text,
                                Icons.flight_takeoff, Colors.red),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Number is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                localNumber = x;
                              });
                            },
                                'Contact Local Number',
                                false,
                                TextInputType.number,
                                Icons.flight_takeoff,
                                Colors.red),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                internationalName = x;
                              });
                            },
                                'Contact International Name',
                                false,
                                TextInputType.text,
                                Icons.flight_takeoff,
                                Colors.red),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Number is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                internationalNumber = x;
                              });
                            },
                                'Contact International Number',
                                false,
                                TextInputType.number,
                                Icons.flight_takeoff,
                                Colors.red),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Reason is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                reasonPassport = x;
                              });
                            }, 'Reason', false, TextInputType.text,
                                Icons.flight_takeoff, Colors.red),
                            datePickers(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     height: 40,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: new BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [
                  //           Color(0xFF104C90),
                  //           Color(0xFF3773AC),
                  //         ],
                  //         stops: [
                  //           0.7,
                  //           0.9,
                  //         ],
                  //       ),
                  //     ),
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           _showDateReturnPassport();
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: <Widget>[
                  //             SizedBox(
                  //               width: 15,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(right: 10.0),
                  //               child: Icon(
                  //                 FontAwesomeIcons.calendarAlt,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 10.0),
                  //               child: Text(
                  //                 _dateTimeReturnPassport == null
                  //                     ? 'Date To Return'
                  //                     : 'Date To Return',
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
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
                              if (_passportWithdrawal.currentState.validate() &&
                                  value != null) {
                                _passportWithdrawal.currentState.save();
                                getPassportWithdrawal();
                              } else {
                                return null;
                              }
                            });
                            // print(value);
                          },
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getPassportWithdrawal() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/passportRetaining'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'local_person': localName,
          'local_contact': localNumber,
          'intl_person': internationalName,
          'intl_contact': internationalNumber,
          'return_date': value,
          'reason': reasonPassport,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            passportWithdrawalJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (passportWithdrawalJson['success'] == '1') {
        showDoneInput(passportWithdrawalJson['message'], context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPassportWithdrawal);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPassportWithdrawal);
      }
    }
  }

  Widget datePickers(BuildContext context) {
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
          validator: (date) {
            if (value == null) {
              return 'Date is required';
            }
            return null;
          },
          initialValue: initialValue,
          onChanged: (date) => setState(() {
            value = date;
            changedCount++;
          }),
          onSaved: (date) => setState(() {
            value = date;
            savedCount++;
          }),
          resetIcon: showResetIcon ? Icon(Icons.delete) : null,
          readOnly: readOnly,
          decoration: InputDecoration(
            labelText: 'Date to Return',
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
