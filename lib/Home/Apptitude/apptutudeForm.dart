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
  List aptitudeProgramJson = [];
  List aptitudeNationalityJson = [];
  Map aptitudeMessageJson = {};
  final format = DateFormat("yyyy-MM-dd");

  final initialValue = DateTime.now();

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
      bottomNavigationBar: bottomappBar(
        context,
        () {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => ApptitudeTest()),
          //     (Route<dynamic> route) => false);

          if (_apptutudeForm.currentState.validate()) {
            _apptutudeForm.currentState.save();
            getAptitude();
          } else {
            print('wrong');
          }
        },
      ),
      appBar: appBarLogin(context, 'Aptitude Register'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _apptutudeForm,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                firstName = x;
                              });
                            }, 'First Name', false, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Middle name is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                middleName = x;
                              });
                            }, 'Middle Name', false, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                lastName = x;
                              });
                            }, 'Last Name', false, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                email = x;
                              });
                            }, 'Email ', false, TextInputType.emailAddress,
                                FontAwesomeIcons.inbox, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Mobile Number is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                mobile = x;
                              });
                            }, 'Mobile Number', false, TextInputType.number,
                                FontAwesomeIcons.phoneAlt, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Telephone number is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                telephone = x;
                              });
                            }, 'Telephone Number', false, TextInputType.number,
                                FontAwesomeIcons.phoneAlt, Colors.blue),
                            datePickers(context, (date) {
                              dob = date.toString();
                            }, 'Date of Birth'),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.flag,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                      isExpanded: true,
                                      value: aptitudeNationality,
                                      hint: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Nationality',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      items: aptitudeNationalityJson
                                              ?.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                  value: item['id'].toString(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        item['nationality']
                                                            .toString()),
                                                  ),
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (x) {
                                        aptitudeNationality = x;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                city = x;
                              });
                            }, 'City', false, TextInputType.text,
                                FontAwesomeIcons.mapMarked, Colors.blue),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.book,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Program',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      value: aptitudeProgram,
                                      items: aptitudeProgramJson
                                              ?.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                  value: item['id'].toString(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        Text(item['program']),
                                                  ),
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (x) {
                                        aptitudeProgram = x;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.book,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Student/Professional',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      value: position,
                                      items: ['Student', 'Professinol']
                                              ?.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(item),
                                                  ),
                                                ),
                                              )
                                              ?.toList() ??
                                          [],
                                      onChanged: (x) {
                                        position = x;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'University is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                university = x;
                              });
                            },
                                'Name of school/university',
                                false,
                                TextInputType.text,
                                FontAwesomeIcons.building,
                                Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                address = x;
                              });
                            }, 'Address', false, TextInputType.text,
                                FontAwesomeIcons.mapMarked, Colors.blue),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: Text('Are you student of Skyline?'),
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
                                    Text('Yes'),
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
                                    Text('No'),
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
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getProgramAndNationality);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getProgramAndNationality);
      }
    }
  }

  Future getAptitude() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/apptitudeForm'),
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
            aptitudeIDJson=json.decode(response.body)['data'];
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
        showDoneInput(aptitudeMessageJson['message'], context);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      }
      print(aptitudeIDJson.toString());
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAptitude());
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAptitude());
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
          // initialValue: initialValue,
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
