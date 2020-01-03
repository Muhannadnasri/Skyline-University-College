import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/global.dart' as prefix0;

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
  List admissionFormDropdownCountriesJson = [];

  List admissionFormDropdownProgramJson = [];

  Map admissionForm = {};

  String fullName = '';

  String mobile = '';
  String email = '';

  String program;
  String know;
  String country;

  @override
  void initState() {
    super.initState();

    container = false;

    admissionFormDropdownCountriesJson = [];

    admissionFormDropdownProgramJson = [];

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
          if (personalDetails.currentState.validate() &&
              country != null &&
              program != null &&
              know != null) {
            personalDetails.currentState.save();

            getAdmissionForm();
          } else {
            // showErrorInput(
            //   'Please Check Your Input',
            // );
          }
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'First name is requiblue';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  fullName = x;
                                });
                              },
                              'Full Name',
                              TextInputType.text,
                            ),
                            globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Email name is requiblue';
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
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Mobile is requiblue';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  mobile = x;
                                });
                              },
                              'Mobile',
                              TextInputType.number,
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 0.0, 20.0, 5.0),
                                      child: Text(
                                        'Country',
                                        style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    )),
                                DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  value: country,
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
                                    child: Text(
                                      'Select Option',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  items: admissionFormDropdownCountriesJson
                                          ?.map((item) => DropdownMenuItem<
                                                  String>(
                                              value: item['NationalityID']
                                                  .toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    item['NationalityName']),
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
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
                                    child: Text(
                                      'Program',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 1,
                                      color: Color(0xFF2f2f2f),
                                    ),
                                    value: program,
                                    isExpanded: true,
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
                                    items: admissionFormDropdownProgramJson
                                            ?.map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item['DegreeType_Id']
                                                    .toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      item['DegreeType_Desc']
                                                          .toString()),
                                                )))
                                            ?.toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        program = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
                                    child: Text(
                                      'How did you come to know?',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  value: know,
                                  isExpanded: true,
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
            'https://skylineportal.com/moappad/api/test/AdmissionFormDropdownRecords'),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionFormDropdownCountriesJson =
                json.decode(response.body)['data']['countries'];
            admissionFormDropdownProgramJson =
                json.decode(response.body)['data']['program'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        // showErrorServer(context, getAdmissionFormDropdownRecords());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getAdmissionFormDropdownRecords());
      }
    }
  }

  Future getAdmissionForm() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/admissionForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'FullName': fullName,
          'Email': email,
          'country_id': country,
          'MobileNO': mobile,
          'tbl_type': know,
          'ProgramofInterest': program,
          'usertype': 'Guest',
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
      showLoading(false, context);

      showSuccessSnackBar(admissionForm['message'], context);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        // showErrorServer(context, getAdmissionFormDropdownRecords());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getAdmissionFormDropdownRecords());
      }
    }
  }
}
