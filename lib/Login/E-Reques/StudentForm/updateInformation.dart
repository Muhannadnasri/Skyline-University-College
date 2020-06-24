import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(UpdateInformation());

class UpdateInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateInformationState();
  }
}

final _information = GlobalKey<FormState>();
final _remark = GlobalKey<FormState>();

// Map<String, int> body;

class _UpdateInformationState extends State<UpdateInformation> {
  Map studentInfoJson = {};
  Map studentPersonalInfoJson = {};
  int dependentValue;
  int hostelValue;
  int visaValue;
  int workingValue;
  String email = '';
  String mobileNumber = '';
  String eid = '';
  String passport = '';
  String visa = '';
  String parentName = '';
  String parentEmiratesID = '';
  String parentMobileNumber = '';
  String parentEmail = '';
  String residenceMobileNumber = '';
  String parentWork = '';
  String parentDesignation = '';
  String boxNumber = '';

  @override
  void initState() {
    super.initState();

    getStudentInfo();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (_information.currentState.validate()) {
              _information.currentState.save();
              getStudentPersonalInfo();
            }
          });
        },
      ),
      appBar: appBarLogin(context, 'Update Information'),
      body: Container(
        color: Colors.white,
        child: studentInfoJson.isEmpty
            ? exception(context)
            : ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Visa Student'),
                                      Row(
                                        children: <Widget>[
                                          Text('Yes'),
                                          Radio(
                                            value: 1,
                                            groupValue: visaValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                visaValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text('No'),
                                          Radio(
                                            value: 2,
                                            groupValue: visaValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                visaValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Dependent'),
                                      Row(
                                        children: <Widget>[
                                          Text('Yes'),
                                          Radio(
                                            value: 1,
                                            groupValue: dependentValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                dependentValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text('No'),
                                          Radio(
                                            value: 2,
                                            groupValue: dependentValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                dependentValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Staying in Hostel'),
                                      Row(
                                        children: <Widget>[
                                          Text('Yes'),
                                          Radio(
                                            value: 1,
                                            groupValue: hostelValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                hostelValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text('No'),
                                          Radio(
                                            value: 2,
                                            groupValue: hostelValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                hostelValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 450,
                              height: 30,
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
                              child: Center(
                                  child: Text(
                                'Student Details',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _information,
                              child: Column(
                                children: <Widget>[
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Email'],
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
                                    'Email',
                                    TextInputType.emailAddress,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['MobileNo'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Mobile No is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        mobileNumber = x;
                                      });
                                    },
                                    'MobileNo',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['EmiratesID'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Emirates ID is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        eid = x;
                                      });
                                    },
                                    'EmiratesID',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['PassportNo'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Passport is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        passport = x;
                                      });
                                    },
                                    'Passport',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Visa'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Visa is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        visa = x;
                                      });
                                    },
                                    'Visa',
                                    TextInputType.text,
                                  ),
                                  Container(
                                    width: 450,
                                    height: 30,
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
                                    child: Center(
                                        child: Text(
                                      'Parent Details',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['ParentName'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Parent Name is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentName = x;
                                      });
                                    },
                                    'ParentName',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']
                                        ['ParentEmiratesIDNo'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Parent Emirates ID is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentEmiratesID = x;
                                      });
                                    },
                                    'Parent Emirates ID',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Parent Mobile No'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Parent Mobile is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentMobileNumber = x;
                                      });
                                    },
                                    'Parent Mobile Number',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Parent Email'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Parent Email is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentEmail = x;
                                      });
                                    },
                                    'Parent Email',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['ResidenceNumber'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Residence Number is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        residenceMobileNumber = x;
                                      });
                                    },
                                    'Residence Number',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['ParentWorkPlace'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Parent Work Place is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentWork = x;
                                      });
                                    },
                                    'Parent Work Place',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Designation'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Designation is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        parentDesignation = x;
                                      });
                                    },
                                    'Designation',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    studentInfoJson['data']['Po BoxNumber'],
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'BoxNumber is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        boxNumber = x;
                                      });
                                    },
                                    'BoxNumber',
                                    TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Working Student'),
                                      Row(
                                        children: <Widget>[
                                          Text('Yes'),
                                          Radio(
                                            value: 1,
                                            groupValue: workingValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                workingValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text('No'),
                                          Radio(
                                            value: 2,
                                            groupValue: workingValue,
                                            onChanged: (int e) {
                                              setState(() {
                                                workingValue = e;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future getStudentInfo() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getStudentPersonalInfo'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            studentInfoJson = json.decode(response.body);
          },
        );
        if (studentInfoJson['data']['VisaStudent'] == "NO") {
          visaValue = 2;
        } else {
          visaValue = 1;
        }
        if (studentInfoJson['data']['Dependent'] == "NO") {
          dependentValue = 2;
        } else {
          dependentValue = 1;
        }
        if (studentInfoJson['data']['Hostel Required'] == "NO") {
          hostelValue = 2;
        } else {
          hostelValue = 1;
        }
        if (studentInfoJson['data']['WORKING'] == "NO") {
          workingValue = 2;
        } else {
          workingValue = 1;
        }

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentInfo);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentInfo);
      }
    }
  }

  Future getStudentPersonalInfo() async {
    if (_information.currentState.validate()) {
      _information.currentState.save();
    }
    if (_remark.currentState.validate()) {
      _remark.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/studentPersonalInfo'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'visa_student':
              visaValue == 1 ? 'Yes' : visaValue == 2 ? 'No' : visaValue,
          'dependent': dependentValue == 1
              ? 'Yes'
              : dependentValue == 2 ? 'No' : dependentValue,
          'staying_hostel':
              hostelValue == 1 ? 'Yes' : hostelValue == 2 ? 'No' : hostelValue,
          'email': email,
          'mobile_no': mobileNumber,
          'visa_no': visa,
          'passport_no': passport,
          'emirates_id': eid,
          'parent_name': parentName,
          'parent_emirates_id': parentEmiratesID,
          'parent_mobile_no': parentMobileNumber,
          'parent_email': parentEmail,
          'residence_tel': residenceMobileNumber,
          'parent_workplace': parentWork,
          'parent_designation': parentDesignation,
          'po_box_no': boxNumber,
          'working_student': workingValue == 1
              ? 'Yes'
              : workingValue == 2 ? 'No' : workingValue,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            studentPersonalInfoJson = json.decode(response.body);
          },
        );

        showLoading(false, context);
      }

      showLoading(false, context);

      if (studentPersonalInfoJson['success'] == '0') {
        showfailureSnackBar(context, studentPersonalInfoJson['message']);
      }
      if (studentPersonalInfoJson['success'] == '1') {
        showSuccessSnackBar(context, studentPersonalInfoJson['message']);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentInfo);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentInfo);
      }
    }
  }
}
