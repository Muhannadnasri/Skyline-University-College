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
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

import '../home.dart';
import 'apptitudeTest.dart';

void main() => runApp(ApptutudeForm());

class ApptutudeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApptutudeFormState();
  }
}

final _apptutudeForm = GlobalKey<FormState>();

// Map<String, int> body;

class _ApptutudeFormState extends State<ApptutudeForm> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  List aptitudeProgramJson = [];
  List aptitudeNationalityJson = [];
  Map aptitudeMessageJson = {};

  String aptitudeNationality;
  String aptitudeProgram;
  String position;

  int groupValue;

  String dob;
  String university = '';
  String city = '';
  String telephone = '';
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String email = '';
  String mobile = '';
  String address = '';

  @override
  void initState() {
    super.initState();

    getProgramAndNationality();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar:
          aptitudeProgramJson == null || aptitudeProgramJson.isEmpty
              ? SizedBox()
              : bottomappBar(
                  context,
                  () {
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => ApptitudeTest()),
                    //     (Route<dynamic> route) => false);

                    if (_apptutudeForm.currentState.validate()) {
                      _apptutudeForm.currentState.save();
                      sendAptitude();
                    } else {}
                  },
                ),
      appBar: appBarLogin(context, 'Aptitude Register'),
      body: aptitudeProgramJson == null || aptitudeProgramJson.isEmpty
          ? exception(context)
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                          key: _apptutudeForm,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'First name is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      firstName = x;
                                    });
                                  },
                                  'First Name',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Middle name is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      middleName = x;
                                    });
                                  },
                                  'Middle Name',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Last name is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      lastName = x;
                                    });
                                  },
                                  'Last Name',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      email = x;
                                    });
                                  },
                                  'Email ',
                                  TextInputType.emailAddress,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Mobile Number is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      mobile = x;
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
                                      return 'Telephone number is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      telephone = x;
                                    });
                                  },
                                  'Telephone Number',
                                  TextInputType.number,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                datePickers(
                                  context,
                                  (date) {
                                    dob = date.toString();
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20.0, 0.0, 20.0, 5.0),
                                        child: Text(
                                          'Nationality',
                                          style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomDropDown(
                                        isExpanded: true,
                                        items: aptitudeNationalityJson
                                                ?.map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    value:
                                                        item['id'].toString(),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20.0, 0.0, 20.0, 5.0),
                                                      child: Text(
                                                        item['nationality']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: isDark(
                                                                    context)
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                ?.toList() ??
                                            [],
                                        value: aptitudeNationality,
                                        hint: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 0.0, 20.0, 5.0),
                                          child: new Text(
                                            'Select One',
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
                                        searchHint: new Text(
                                          'Select One',
                                          style: new TextStyle(
                                              fontSize: 20,
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            aptitudeNationality = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: <Widget>[
                                //       SizedBox(
                                //         width: 5,
                                //       ),
                                //       Icon(
                                //         FontAwesomeIcons.flag,
                                //         color: Colors.blue,
                                //         size: 20,
                                //       ),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       Expanded(
                                //         child: DropdownButton<String>(
                                //           style: TextStyle(
                                //               fontSize: 13,
                                //               color: Colors.black),
                                //           isExpanded: true,
                                //           value: aptitudeNationality,
                                //           hint: Padding(
                                //             padding:
                                //                 const EdgeInsets.all(8.0),
                                //             child: Text(
                                //               'Nationality',
                                //               style: TextStyle(
                                //                   color: Colors.black),
                                //             ),
                                //           ),
                                //           items: aptitudeNationalityJson
                                //                   ?.map(
                                //                     (item) =>
                                //                         DropdownMenuItem<
                                //                             String>(
                                //                       value: item['id']
                                //                           .toString(),
                                //                       child: Padding(
                                //                         padding:
                                //                             const EdgeInsets
                                //                                 .all(8.0),
                                //                         child: Text(item[
                                //                                 'nationality']
                                //                             .toString()),
                                //                       ),
                                //                     ),
                                //                   )
                                //                   ?.toList() ??
                                //               [],
                                //           onChanged: (x) {
                                //             aptitudeNationality = x;
                                //           },
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      city = x;
                                    });
                                  },
                                  'City',
                                  TextInputType.text,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                dropDownWidget(
                                    context,
                                    'Select Option',
                                    aptitudeProgram,
                                    aptitudeProgramJson,
                                    'id',
                                    'program', (value) {
                                  setState(() {
                                    aptitudeProgram = value;
                                  });
                                }, 'Program'),
                                SizedBox(
                                  height: 15,
                                ),

                                Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20.0, 0.0, 20.0, 5.0),
                                        child: Text(
                                          'Student/Professor',
                                          style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                            'Select Option',
                                            style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        isExpanded: true,
                                        value: position,
                                        items: ['Student', 'Professor']
                                                ?.map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    value: item.toString(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: FittedBox(
                                                          child: Text(
                                                              item.toString())),
                                                    ),
                                                  ),
                                                )
                                                ?.toList() ??
                                            [],
                                        onChanged: (value) {
                                          setState(() {
                                            position = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'University is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      university = x;
                                    });
                                  },
                                  'Name of school/university',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      address = x;
                                    });
                                  },
                                  'Address',
                                  TextInputType.text,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Are you student of Skyline?',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: groupValue,
                                          onChanged: (int e) {
                                            setState(() {
                                              groupValue = e;
                                            });
                                          },
                                          activeColor: Colors.blue,
                                        ),
                                        Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue: groupValue,
                                          onChanged: (int e) {
                                            setState(() {
                                              groupValue = e;
                                            });
                                          },
                                          activeColor: Colors.red,
                                        ),
                                        Text(
                                          'No',
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getProgramAndNationality() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getAptitudeProgramAndNationality'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': 'STUDENT',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            aptitudeProgramJson =
                json.decode(response.body)['data']['programs'];
            aptitudeNationalityJson =
                json.decode(response.body)['data']['nationality'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getProgramAndNationality());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getProgramAndNationality());
      }
    }
  }

  Future sendAptitude() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/apptitudeForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'fname': firstName,
          'mname': middleName,
          'lname': lastName,
          'mobile_no': mobile.toString(),
          'tel_no': telephone.toString(),
          'email': email,
          'dob': dob.toString(),
          'nationality_id': aptitudeNationality.toString(),
          'city': city.toString(),
          'address': address.toString(),
          'program_id': aptitudeProgram.toString(),
          'stud_prof': position.toString(),
          'school_university': university,
          'is_skyline_student': groupValue.toString(),
          'usertype': 'STUDENT',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            aptitudeJson = json.decode(response.body)['data']['questions'];
            aptitudeIDJson = json.decode(response.body)['data'];
            aptitudeMessageJson = json.decode(response.body);
          },
        );
      }
      if (aptitudeMessageJson['success'] == '1') {
        showLoading(false, context);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ApptitudeTest()),
            (Route<dynamic> route) => false);
      } else if (aptitudeMessageJson['success'] == '0') {
        showSuccessSnackBar(aptitudeMessageJson['message'], context);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getAptitude());

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendAptitude);
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getAptitude());
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendAptitude);
      }
    }
  }

  Widget datePickers(BuildContext context, onSaved) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
            child: Text(
              'Date of Birth',
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
              onSaved: onSaved,
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
