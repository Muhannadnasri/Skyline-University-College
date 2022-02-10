import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(ReinStatement());

class ReinStatement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReinStatementState();
  }
}

final _documentry = GlobalKey<FormState>();

class _ReinStatementState extends State<ReinStatement> {
  Map reinStatementJson = {};

  bool fall = false;
  bool spring = false;
  bool summer = false;
  String semester = "";
  String documentry = '';

  bool incomplete = false;
  bool medical = false;
  bool death = false;
  bool personal = false;
  bool other = false;
  bool checkValue = false;
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
          setState(() {
            if (_documentry.currentState.validate()) {
              _documentry.currentState.save();

              sendReinStatement();
            } else {
              checkValue = true;
            }
          });
        },
      ),
      appBar: appBarLogin(context, 'Reinstatement'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Attend the class ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Fall'),
                        activeColor: Colors.blue,
                        value: fall,
                        onChanged: (value) {
                          spring = false;
                          summer = false;

                          setState(() {
                            spring = false;
                            summer = false;
                            fall = value;
                            value ? semester = "fall" : semester = "";
                          });
                        },
                        subtitle: checkValue
                            ? !spring & !fall & !summer
                                ? Text(
                                    'Please Select One Semester.',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  )
                                : null
                            : null,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Spring'),
                        activeColor: Colors.blue,
                        value: spring,
                        onChanged: (value) {
                          setState(() {
                            fall = false;
                            summer = false;
                            spring = value;
                            value ? semester = "spring" : semester = "";
                          });
                        },
                        subtitle: checkValue
                            ? !spring & !fall & !summer
                                ? Text(
                                    'Please Select One Semester.',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  )
                                : null
                            : null,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Summer'),
                        activeColor: Colors.blue,
                        value: summer,
                        onChanged: (value) {
                          setState(() {
                            spring = false;
                            fall = false;
                            summer = value;
                            value ? semester = "summer" : semester = "";
                          });
                        },
                        subtitle: checkValue
                            ? !spring & !fall & !summer
                                ? Text(
                                    'Please Select One Semester.',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  )
                                : null
                            : null,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  color: isDark(context)
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Incomplete Grades'),
                          activeColor: Colors.blue,
                          value: incomplete,
                          onChanged: (value) {
                            setState(() {
                              incomplete = value;
                            });
                          },
                          subtitle: checkValue
                              ? !incomplete &
                                      !medical &
                                      !death &
                                      !personal &
                                      !other
                                  ? Text(
                                      'Please Select One Reason.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : null
                              : null),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Medical conditions'),
                          activeColor: Colors.blue,
                          value: medical,
                          onChanged: (value) {
                            setState(() {
                              medical = value;
                            });
                          },
                          subtitle: checkValue
                              ? !incomplete &
                                      !medical &
                                      !death &
                                      !personal &
                                      !other
                                  ? Text(
                                      'Please Select One Reason.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : null
                              : null),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Death In Family'),
                          activeColor: Colors.blue,
                          value: death,
                          onChanged: (value) {
                            setState(() {
                              death = value;
                            });
                          },
                          subtitle: checkValue
                              ? !incomplete &
                                      !medical &
                                      !death &
                                      !personal &
                                      !other
                                  ? Text(
                                      'Please Select One Reason.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : null
                              : null),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Personal Circumstances'),
                          activeColor: Colors.blue,
                          value: personal,
                          onChanged: (value) {
                            setState(() {
                              personal = value;
                            });
                          },
                          subtitle: checkValue
                              ? !incomplete &
                                      !medical &
                                      !death &
                                      !personal &
                                      !other
                                  ? Text(
                                      'Please Select One Reason.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : null
                              : null),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Other'),
                          activeColor: Colors.blue,
                          value: other,
                          onChanged: (value) {
                            setState(() {
                              if (other == true) {}
                              other = value;
                            });
                          },
                          subtitle: checkValue
                              ? !incomplete &
                                      !medical &
                                      !death &
                                      !personal &
                                      !other
                                  ? Text(
                                      'Please Select One Reason.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : null
                              : null),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Form(
                    key: _documentry,
                    child: globalForms(
                      context,
                      '',
                      (String value) {
                        if (value.trim().isEmpty) {
                          return 'Documentry is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          documentry = x;
                        });
                      },
                      'Documentry',
                      TextInputType.text,
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future sendReinStatement() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/appealReinstatement'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'AttendClass': semester,
          'IncompleteGrades': incomplete ? "True" : "False",
          'MedicalConditions': medical ? "True" : "False",
          'DeathInFamily': death ? "True" : "False",
          'PersonalCircumstances': personal ? "True" : "False",
          'Other': other ? "True" : "False",
          'documentry': documentry,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            reinStatementJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (reinStatementJson['success'] == '0') {
        showfailureSnackBar(context, reinStatementJson['message']);
      }
      if (reinStatementJson['success'] == '1') {
        showSuccessSnackBar(context, reinStatementJson['message']);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendReinStatement);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendReinStatement);
      }
    }
  }
}
