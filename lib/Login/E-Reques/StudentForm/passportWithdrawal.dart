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

  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  Map passportWithdrawalJson;

  int groupValue;


  String localName = '';
  String localNumber = '';
  String internationalName = '';
  String internationalNumber = '';
  String reasonPassport = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true, //todo: On all Form
      appBar: appBarLogin(context, 'Passport Withdrawal'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (_passportWithdrawal.currentState.validate() && value != null) {
              _passportWithdrawal.currentState.save();
              sendPassportWithdrawal();
            } else {}
          });
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
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  localName = x;
                                });
                              },
                              'Contact Local Name',
                              TextInputType.text,
                            ),
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Number is required';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  localNumber = x;
                                });
                              },
                              'Contact Local Number',
                              TextInputType.number,
                            ),
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  internationalName = x;
                                });
                              },
                              'Contact International Name',
                              TextInputType.text,
                            ),
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Number is required';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  internationalNumber = x;
                                });
                              },
                              'Contact International Number',
                              TextInputType.number,
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
                                  reasonPassport = x;
                                });
                              },
                              'Reason',
                              TextInputType.text,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            datePickers(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendPassportWithdrawal() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/passportWithdrawal'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'LocalPersonName': localName,
          'LocalMobileNo': localNumber,
          'InternationalPersonName': internationalName,
          'InternationalMobileNo': internationalNumber,
          'ReturnDate': value,
          'Reason': reasonPassport,
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
      if (passportWithdrawalJson['success'] == '0') {
        showfailureSnackBar(context, passportWithdrawalJson['message']);
      }
      if (passportWithdrawalJson['success'] == '1') {
        showSuccessSnackBar(context, passportWithdrawalJson['message']);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendPassportWithdrawal);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendPassportWithdrawal);
      }
    }
  }

  Widget datePickers(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
            child: Text(
              'Date to Return',
              style: TextStyle(
                color: isDark(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
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
