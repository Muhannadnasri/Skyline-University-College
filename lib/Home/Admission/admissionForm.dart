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
  String pBox = '';
  String town = '';
  String telephone = '';
  String mobile = '';
  String email = '';

  String program = '';
  String gender = '';

  String country = '';

  String liveOutside = '';
  String date = '';
  String online = '';

  String sat = '';
  String qualification = '';
  String qCountry = '';
  String qSchool = '';
  String qDuration = '';
  String qResult = '';
  String testName = '';
  String testYear = '';
  String testOverall = '';

  String nationality = '';
  String courseName = '';
  String employmentTime = '';
  String employmentName = '';
  String employmentLocation = '';
  String employmentPosition = '';

  @override
  void initState() {
    super.initState();

    container = false;
    disableForm = true;
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
                  sat != null &&
                  online != null &&
                  qualification != null &&
                  liveOutside != null &&
                  country != null &&
                  gender != null &&
                  program != null) {
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
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 10,),
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
                                return 'Telephone is requiblue';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                telephone = x;
                              });
                            }, 'Telephone', true, TextInputType.number,
                                FontAwesomeIcons.phoneAlt, Colors.blue),
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

//
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Country',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      )),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Select Option',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    items: admissionFormDropdownCountriesJson
                                            ?.map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(item['country']),
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

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Nationality',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: admissionFormDropdownCountriesJson
                                            ?.map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(item['country']),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Gender',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Your Gender',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: <String>['Male', 'Female']
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
                                    onChanged: (String value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Program',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Course Name',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
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
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Have you completed any studies through distance or online learning ? ',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                  DropdownButton<String>(
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
                                        online = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Have you underwent SAT exam ?',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
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
                                        sat = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'When do you which to begin your degree ?',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Select Option',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        items: admissionFormDropdownTermsJson
                                                ?.map((item) =>
                                                    DropdownMenuItem<String>(
                                                        value: item['id']
                                                            .toString(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              item['term']),
                                                        )))
                                                ?.toList() ??
                                            [],
                                        onChanged: (value) {
                                          setState(() {
                                            date = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Are you an international student living outside the UAE?',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 10,

                      color: Colors.white,
                      child: Row(

                        children: <Widget>[
                          Spacer(

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Text('Qualification')),
                          ),

                          Spacer(

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Icon(FontAwesomeIcons.graduationCap,color: Colors.grey,)),
                          ),SizedBox(width: 5,),

                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: academicBackground,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Qualification',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Select Option',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                items: admissionFormDropdownQualificationJson
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      item['qualification']),
                                                )))
                                        ?.toList() ??
                                    [],
                                onChanged: (value) {
                                  setState(() {
                                    qualification = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Qualification school is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            qSchool = x;
                          });
                        },
                            'Qualification School Name',
                            true,
                            TextInputType.text,
                            FontAwesomeIcons.school,
                            Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Qualification year is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            qDuration = x;
                          });
                        }, 'Qualification Year', true, TextInputType.number,
                            FontAwesomeIcons.calendarAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Qualification result is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            qResult = x;
                          });
                        }, 'Qualification Result', true, TextInputType.number,
                            FontAwesomeIcons.pollH, Colors.blue),



                        Container(
                          height: 70,
                          child: Card(
                            elevation: 10,

                            color: Colors.white,
                            child: Row(

                              children: <Widget>[
                                Spacer(

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(child: Text('Certificate')),
                                ),

                                Spacer(

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(child: Icon(FontAwesomeIcons.certificate,color: Colors.grey,)),
                                ),SizedBox(width: 5,),

                              ],
                            ),
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: Text('Select Option'),
                                items: admissionFormDropdownIELTSJson
                                        ?.map((item) =>
                                            DropdownMenuItem<String>(
                                                value: item['id'].toString(),
                                                child: Text(item['test_type'])))
                                        ?.toList() ??
                                    [],
                                onChanged: (value) {
                                  setState(() {
                                    testName = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Test year is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            testYear = x;
                          });
                        }, 'Test Year', true, TextInputType.number,
                            FontAwesomeIcons.calendarAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Test overall is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            testOverall = x;
                          });
                        }, 'Test Overall', true, TextInputType.number,
                            FontAwesomeIcons.pollH, Colors.blue),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Card(
                      elevation: 10,

                      color: Colors.white,
                      child: Row(

                        children: <Widget>[
                          Spacer(

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Text('Employment')),
                          ),

                          Spacer(

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Icon(FontAwesomeIcons.briefcase,color: Colors.grey,)),
                          ),SizedBox(width: 5,),

                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: employmentDetails,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Employment time is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            employmentTime = x;
                          });
                        }, 'Employment Time', true, TextInputType.text,
                            FontAwesomeIcons.calendarAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Employment name is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            employmentName = x;
                          });
                        }, 'Employment Name', true, TextInputType.text,
                            FontAwesomeIcons.user, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Employment location is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            employmentLocation = x;
                          });
                        }, 'Employment Location', true, TextInputType.text,
                            FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                        globalForms(context, '', (String value) {
                          if (value.trim().isEmpty) {
                            return 'Employment position is requiblue';
                          }
                          return null;
                        }, (x) {
                          setState(() {
                            employmentPosition = x;
                          });
                        }, 'Employment Position', true, TextInputType.text,
                            FontAwesomeIcons.plus, Colors.blue),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
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
