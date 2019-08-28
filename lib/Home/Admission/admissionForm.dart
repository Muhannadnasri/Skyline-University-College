import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';

void main() => runApp(AdmissionForm());

class AdmissionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdmissionFormState();
  }
}

final personalDetails = GlobalKey<FormState>();

final academicBackground = GlobalKey<FormState>();
final employmentDetails = GlobalKey<FormState>();

// Map<String, int> body;

class _AdmissionFormState extends State<AdmissionForm> {
  List programsByCategory2Json = [];

  List programsByCategory1Json = [];

  List admissionFormDropdownCountriesJson = [];

  List admissionFormDropdownProgramJson = [];

  List admissionFormDropdownTermsJson = [];

  List admissionFormDropdownQualificationJson = [];

  List admissionFormDropdownIELTSJson = [];

  Map admissionForm = {};

  String firstName = '';
  String middleName = '';
  String lastName = '';

  String town = '';

  String mobile = '';
  String email = '';

  String program;
  String know;
  String country;

  String liveOutside;

  String nationality;
  String courseName;

  @override
  void initState() {
    super.initState();

    container = false;

    programsByCategory2Json = [];

    programsByCategory1Json = [];

    admissionFormDropdownCountriesJson = [];

    admissionFormDropdownProgramJson = [];

    admissionFormDropdownTermsJson = [];

    admissionFormDropdownQualificationJson = [];

    admissionFormDropdownIELTSJson = [];

    admissionForm = {};

    getAdmissionFormDropdownRecords();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Application Form'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (personalDetails.currentState.validate() ||
              academicBackground.currentState.validate() ||
              employmentDetails.currentState.validate() &&
                  nationality != null &&
                  courseName != null &&
                  liveOutside != null &&
                  country != null &&
                  program != null &&
                  know != null) {
            personalDetails.currentState.save();
            academicBackground.currentState.save();
            employmentDetails.currentState.save();
            getAdmissionForm();
          } else {
            showErrorInput(
              'Please Check Your Input',
            );
          }
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Form(
                        key: personalDetails,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'First name is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                firstName = x;
                              });
                            }, 'First Name', true, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Middle name is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                middleName = x;
                              });
                            }, 'Middle Name', true, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Last name is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                lastName = x;
                              });
                            }, 'Last Name', true, TextInputType.text,
                                FontAwesomeIcons.user, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Email name is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                email = x;
                              });
                            }, 'Email', true, TextInputType.emailAddress,
                                FontAwesomeIcons.envelope, Colors.blue),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Mobile is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                mobile = x;
                              });
                            }, 'Mobile', true, TextInputType.number,
                                FontAwesomeIcons.phoneAlt, Colors.blue),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Country',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                            )),
                                        DropdownButton<String>(
                                          value: country,
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Select Option',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          items:
                                              admissionFormDropdownCountriesJson
                                                      ?.map((item) =>
                                                          DropdownMenuItem<
                                                                  String>(
                                                              value: item['id']
                                                                  .toString(),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(item[
                                                                    'country']),
                                                              )))
                                                      ?.toList() ??
                                                  [],
                                          onChanged: (value) {
                                            setState(() {
                                              country = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Nationality',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                        ),
                                        DropdownButton<String>(
                                          value: nationality,
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Select Option',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          items:
                                              admissionFormDropdownCountriesJson
                                                      ?.map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: item['id']
                                                              .toString(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(item[
                                                                'country']),
                                                          ),
                                                        ),
                                                      )
                                                      ?.toList() ??
                                                  [],
                                          onChanged: (value) {
                                            setState(() {
                                              nationality = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Town is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                town = x;
                              });
                            }, 'Town', true, TextInputType.text,
                                FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Program',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButton<String>(
                                    value: program,
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Option',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    items: admissionFormDropdownProgramJson
                                            ?.map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(item['program']
                                                      .toString()),
                                                )))
                                            ?.toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        program = value;
                                        getProgramsByCategory1();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Course Name',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButton<String>(
                                    value: courseName,
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Option',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    items: programsByCategory1Json
                                            ?.map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(item['name']),
                                                )))
                                            ?.toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        courseName = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'How did you come to know?',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: know,
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Select Option',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  items: <String>[
                                        'Others',
                                        'Google',
                                        'Facebook',
                                        'Yahoo',
                                        'School',
                                        'Friends/Relatives',
                                        'Word of mouth',
                                        'Newspaper',
                                        'Exhibition',
                                        'Radio',
                                        'Cinema Theater',
                                        'Billboards',
                                        'Television'
                                      ]
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(item),
                                                  )))
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      know = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Are you an international student living outside the UAE?',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: liveOutside,
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Select Option',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  items: <String>['Yes', 'No']
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(item),
                                                  )))
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      liveOutside = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getAdmissionFormDropdownRecords() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getAdmissionFormDropdownRecords'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'ipaddress': '1',
          'token': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionFormDropdownCountriesJson =
                json.decode(response.body)['data']['countries'];
            admissionFormDropdownProgramJson =
                json.decode(response.body)['data']['program'];

            admissionFormDropdownTermsJson =
                json.decode(response.body)['data']['terms'];
            admissionFormDropdownQualificationJson =
                json.decode(response.body)['data']['qualification'];
            admissionFormDropdownIELTSJson =
                json.decode(response.body)['data']['IELTS_tests'];
          },
        );
        showLoading(false, context);
        print(admissionFormDropdownProgramJson.toString());
      }
    } catch (x) {
      print(x);

      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }

  Future getProgramsByCategory1() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getProgramsByCategory'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'category_id': program,
          'usertype': '1',
          'ipaddress': '1',
          'token': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            programsByCategory1Json = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }

  Future getAdmissionForm() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/membershipForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'title': '',
          'gender': '',
          'fname': '',
          'mname': '',
          'lname': '',
          'email': '',
          'dob': '',
          'student_visa': '',
          'hostel_facility': '',
          'address': '',
          'suburb': '',
          'state': '',
          'postal_code': '',
          'country_id': '',
          'telphone_no': '',
          'mobile_no': '',
          'home_address': '',
          'home_suburb': '',
          'home_state': '',
          'home_postal_code': '',
          'home_country_id': '',
          'home_telphone_no': '',
          'home_mobile_no': '',
          'nationality_id': '',
          'country_permanent': '',
          'country_of_birth': '',
          'is_international_student': '',
          'program_preference1': '',
          'course_preference1': '',
          'program_preference2': '',
          'course_preference2': '',
          'begin_degree': '',
          'distance_learning': '',
          'underwent_sat_exam': '',
          'sat_score': '',
          'english_proficiency': '',
          'english_proficiency_year': '',
          'english_proficiency_overall': '',
          'institution_name': '',
          'qualifications': '',
          'employements': '',
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
          'know': know,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionForm = json.decode(response.body);
          },
        );
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }
}
