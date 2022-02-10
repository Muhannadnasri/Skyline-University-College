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
import 'package:skyline_university/Login/E-Reques/StudentForm/dropList.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  bool isLoading = true;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  Map aptitudeMessageJson = {};
  int initialIndex = 0;
  int initialIndexYes = 0;

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
  var nationalityNameCnt = TextEditingController();
  var programNameCnt = TextEditingController();

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
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
                        height: 25,
                      ),
                      datePickers(
                        context,
                        (date) {
                          dob = date.toString();
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nationality',
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DropList(
                                    type: 'Nationality',
                                  ),
                                ),
                              ).then((val) async {
                                setState(() {
                                  // miscName = val['MiscName'];
                                  aptitudeNationality =
                                      val['NationalityID'].toString();

                                  nationalityNameCnt.text =
                                      val['NationalityName'].toString();
                                });
                              });
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                validator: (x) => x.isEmpty
                                    ? "Please select request type"
                                    : null,
                                onChanged: (x) {
                                  setState(() {
                                    // isEditing = true;
                                  });
                                },
                                controller: nationalityNameCnt,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
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
                            city = x;
                          });
                        },
                        'City',
                        TextInputType.text,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Program',
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DropList(
                                    type: 'Program',
                                  ),
                                ),
                              ).then((val) async {
                                setState(() {
                                  // miscName = val['MiscName'];
                                  aptitudeProgram =
                                      val['DegreeType_Id'].toString();

                                  programNameCnt.text =
                                      val['DegreeType_Desc'].toString();
                                });
                              });
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                validator: (x) => x.isEmpty
                                    ? "Please select request type"
                                    : null,
                                onChanged: (x) {
                                  setState(() {
                                    // isEditing = true;
                                  });
                                },
                                controller: programNameCnt,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Student / Professor',
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ToggleSwitch(
                            minWidth: 90.0,
                            initialLabelIndex: initialIndex,
                            cornerRadius: 10.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['Student', 'Professor'],
                            activeBgColor: [Colors.green, Colors.red],
                            onToggle: (index) {
                              print('switched to: $index');
                              setState(() {
                                initialIndex = index;
                                switch (initialIndex) {
                                  case 0:
                                    {
                                      setState(() {
                                        position = 'Student';
                                      });
                                    }

                                    break;
                                  case 1:
                                    {
                                      setState(() {
                                        position = 'Professor';
                                      });
                                    }
                                    break;
                                  default:
                                    {
                                      setState(() {
                                        position = 'Student';
                                      });
                                    }
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
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
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Are you student of Skyline?',
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ToggleSwitch(
                            minWidth: 90.0,
                            initialLabelIndex: initialIndexYes,
                            cornerRadius: 10.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['Yes', 'No'],
                            activeBgColor: [Colors.green, Colors.red],
                            onToggle: (index) {
                              print('switched to: $index');
                              setState(() {
                                initialIndexYes = index;
                                switch (initialIndexYes) {
                                  case 0:
                                    {
                                      setState(() {
                                        groupValue = 1;
                                      });
                                    }

                                    break;
                                  case 1:
                                    {
                                      setState(() {
                                        groupValue = 0;
                                      });
                                    }
                                    break;
                                  default:
                                    {
                                      setState(() {
                                        groupValue = 0;
                                      });
                                    }
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendAptitude() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/apptitudeForm'),
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
          Text(
            'Date of Birth',
            style: TextStyle(
              color: isDark(context) ? Colors.white : Colors.black,
            ),
          ),
          DateTimeField(
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
        ]);
  }
}
