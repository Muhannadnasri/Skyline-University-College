import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(VisitorInfoAr());

class VisitorInfoAr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoArState();
  }
}

class _VisitorInfoArState extends State<VisitorInfoAr> {
  final visitor = GlobalKey<FormState>();

  Map currentTimeJson = {};
  List currentAndNewShiftJson = [];
  Map changeClassTimingJson = {};
  String callYou;
  String name = '';
  String mobile = '';
  String facebookId = '';
  String email = '';
  String event = '';
  String nationality;
  String program;
  String other;

  String languageStudied = '';
  String major = '';
  String school = '';
  String level = '';
  String occupation = '';
  String organizationName = '';
  String organizationType = '';

  String newShift;
  bool isValidat = false;
  @override
  void initState() {
    super.initState();

    // getCurrentAndNewShift();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar:
            // currentTimeJson == null || currentTimeJson.isEmpty
            //     ? Container()
            //     :
            bottomappBar(
          context,
          () {
            setState(() {
              if (visitor.currentState.validate() && newShift != null) {
                visitor.currentState.save();

                sendChangeClassTiming();
              }
            });
          },
        ),
        appBar: appBarLogin(
          context,
          'معلومات زائر',
        ),
        body:
            //  currentTimeJson == null || currentTimeJson.isEmpty
            //     ? exception(context)
            //     :

            GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
//                 Container(
//                   width: 500,
//                   height: 50,
//                   alignment: Alignment.center,
//                   decoration: new BoxDecoration(
//                     gradient: isDark(context)
//                         ? LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color(0xFF1F1F1F),
//                               Color(0xFF1F1F1F),
//                             ],
//                             stops: [
//                               0.7,
//                               0.9,
//                             ],
//                           )
//                         : LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color(0xFF104C90),
//                               Color(0xFF3773AC),
//                             ],
//                             stops: [
//                               0.7,
//                               0.9,
//                             ],
//                           ),
//                   ),
//                   child: Text(
//                     'Visitor Information Form',
//                     style: TextStyle(color: Colors.white),
// //
//                   ),
//                 ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                      key: visitor,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    'How do you want us to call you?',
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
                                      'حدد الخيار',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: callYou,
                                  items: ['', '', '', '']
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      callYou = value;
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
                                return 'اسمك مطلوب';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                name = x;
                              });
                            },
                            'الاسم',
                            TextInputType.text,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'رقم هاتفك المحمول مطلوب';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      mobile = x;
                                    });
                                  },
                                  'الجوال',
                                  TextInputType.text,
                                ),
                              ),
                              Flexible(
                                child: globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'الفيسبوك الخاص بك هو مطلوب';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      facebookId = x;
                                    });
                                  },
                                  'حساب الفيس بوك',
                                  TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'بريدك الإلكتروني مطلوب';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                email = x;
                              });
                            },
                            'البريد الإلكتروني',
                            TextInputType.text,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'بريدك الإلكتروني مطلوب';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      event = x;
                                    });
                                  },
                                  'المناسبة التي تم حضورها',
                                  TextInputType.text,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'الجنسية',
                                        style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black,
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
                                            'حدد الخيار',
                                            style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        isExpanded: true,
                                        value: nationality,
                                        items: []
                                                ?.map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    value: item.toString(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          Text(item.toString()),
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    'Program/Course Of Interest',
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
                                  value: program,
                                  items: []
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
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
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Please Specify';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                other = x;
                              });
                            },
                            'Other , Please Specify',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    'Mode Of Teaching',
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
                                  value: languageStudied,
                                  items: []
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      languageStudied = value;
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
                                return 'Your Major is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                major = x;
                              });
                            },
                            'Specific Major/Emphasis/Short Course',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Your School is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                school = x;
                              });
                            },
                            'Name Of School/University',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    'Level',
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
                                  value: level,
                                  items: []
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      level = value;
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
                                return 'Your Job Occupation is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                occupation = x;
                              });
                            },
                            'Current Occupation',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Your Organization Name is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                organizationName = x;
                              });
                            },
                            'Name of The Organization',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    'Type of Organization',
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
                                  value: organizationType,
                                  items: []
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.toString()),
                                              ),
                                            ),
                                          )
                                          ?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      organizationType = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getCurrentAndNewShift() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/CurrentAndNewShift'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            currentTimeJson =
                json.decode(response.body)['data']['current_shift'];

            currentAndNewShiftJson =
                json.decode(response.body)['data']['new_shift'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrentAndNewShift);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrentAndNewShift);
      }
    }
  }

  Future sendChangeClassTiming() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/changeClassTiming'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'UserID': username,
          'CurrentTiming': currentTimeJson['Shift_Desc'],
          'NewTiming': newShift,
          // 'Reason': reason,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            changeClassTimingJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
        if (changeClassTimingJson['success'] == '0') {
          showfailureSnackBar(context, changeClassTimingJson['message']);
        }
        if (changeClassTimingJson['success'] == '1') {
          showSuccessSnackBar(context, changeClassTimingJson['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrentAndNewShift);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrentAndNewShift);
      }
    }
  }
}
