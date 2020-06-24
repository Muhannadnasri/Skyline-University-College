import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(GeneralAppointment());

class GeneralAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GeneralAppointmentState();
  }
}

final _generalAppointment = GlobalKey<FormState>();

// Map<String, int> body;

class _GeneralAppointmentState extends State<GeneralAppointment> {
  List generalAPPtDepartmentJson = [];
  List generalAPPtTimeJson = [];
  List generalAPPtJson = [];
  List generalApptDate = [];
  Map generalRequestJson = {};
  String remarkAppointment = '';

  String _categoryID;
  String _departmentID;
  String _empId;
  String _appointDate;

  String _appointTime;
  String twoValue;
  @override
  void initState() {
    super.initState();

    getGeneralApptCatDeptTime();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: generalAPPtJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                setState(() {
                  if (_generalAppointment.currentState.validate() &&
                      _categoryID != null &&
                      _departmentID != null &&
                      _appointDate != null &&
                      _appointTime != null) {
                    _generalAppointment.currentState.save();
                    sendGeneralAppointment();
                  }
                });
              },
            ),
      appBar: appBarLogin(context, 'General Appointment'),
      body: generalAPPtJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      dropDownWidget(
                          context,
                          'Select Option',
                          _categoryID,
                          generalAPPtJson,
                          'CATEGORY_ID',
                          'CATEGORY_DESCRIPTION', (value) {
                        setState(() {
                          _categoryID = value;
                          getGeneralApptCatDeptTime();
                        });
                      }, 'Case Category'),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                'Department',
                                style: TextStyle(
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: <Widget>[
                              //ToDo: Here
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomDropDown(
                                  value: twoValue,
                                  isExpanded: true,
                                  items: generalAPPtDepartmentJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item['EmpNumber'] +
                                                  "||" +
                                                  item['Department_ID']
                                                      .toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item['Department'],
                                                  style: TextStyle(
                                                      color: isDark(context)
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
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
                                      twoValue = value;
                                      _empId = value.split('||')[0];
                                      _departmentID = value.split('||')[1];
                                      getGeneralApptDate();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          dropDownWidget(context, 'Select Option', _appointDate,
                              generalApptDate, 'date', 'Dates', (value) {
                            setState(() {
                              _appointDate = value;
                              getGeneralApptCatDeptTime();
                            });
                          }, 'Appointment Date'),

                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text(
                          //       'Appointment Date',
                          //       style: TextStyle(color: Colors.grey[600]),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          dropDownWidget(
                              context,
                              'Select Option',
                              _appointTime,
                              generalAPPtTimeJson,
                              'timevalue',
                              'timevalue', (value) {
                            setState(() {
                              _appointTime = value;
                            });
                          }, 'Appointment Time'),
                        ],
                      ),
                      Form(
                        key: _generalAppointment,
                        child: globalForms(
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
                              remarkAppointment = x;
                            });
                          },
                          'Reason',
                          TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future getGeneralApptDate() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/GeneralApptDate'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'emp_no': _empId,
          'department': _departmentID,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            generalApptDate = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGeneralApptCatDeptTime);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGeneralApptCatDeptTime);
      }
    }
  }

  Future getGeneralApptCatDeptTime() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': studentJson['data']['user_type'],
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            generalAPPtJson = json.decode(response.body)['data']['category'];
            generalAPPtDepartmentJson =
                json.decode(response.body)['data']['department'];
            generalAPPtTimeJson = json.decode(response.body)['data']['time'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGeneralApptCatDeptTime);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGeneralApptCatDeptTime);
      }
    }
  }

  Future sendGeneralAppointment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/generalAppointment'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'CASETYPE_ID': '4',
          'CATEGORY_ID': _categoryID.toString(),
          'EmpNumber': _empId,
          'Department_ID': _departmentID.toString(),
          'AppointMentDate': _appointDate,
          'AppointmentTime': _appointTime,
          'StudentRemarks': remarkAppointment,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            generalRequestJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
        if (generalRequestJson['success'] == '0') {
          showfailureSnackBar(context, generalRequestJson['message']);
        }
        if (generalRequestJson['success'] == '1') {
          showSuccessSnackBar(context, generalRequestJson['message']);
        }
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendGeneralAppointment);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendGeneralAppointment);
      }
    }
  }
}
