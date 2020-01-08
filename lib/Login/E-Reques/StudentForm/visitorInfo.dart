import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(VisitorInfo());

class VisitorInfo extends StatefulWidget {
  final bool languageAr;

  const VisitorInfo({Key key, this.languageAr}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoState();
  }
}

class _VisitorInfoState extends State<VisitorInfo> {
  final visitor = GlobalKey<FormState>();
  List admissionFormDropdownCountriesJson = [];
  List admissionFormDropdownProgramJson = [];
  String callYou;
  String name = '';
  String mobile = '';
  String facebookId = '';
  String email = '';
  String event = '';
  String nationality;
  String program;
  String other;

  String languageStudied;
  String major = '';
  String school = '';
  String level = '';
  String occupation = '';
  String organizationName = '';
  String organizationType;

  @override
  void initState() {
    super.initState();
    getCountriesAndProgram();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Directionality(
      textDirection: widget.languageAr ? TextDirection.rtl : TextDirection.ltr,
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
              if (visitor.currentState.validate()) {
                visitor.currentState.save();

                // sendChangeClassTiming();
              }
            });
          },
        ),
        appBar: appBarLogin(
          context,
          widget.languageAr ? 'معلومات الزائر' : 'Visitor Information',
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
                                alignment: widget.languageAr
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    widget.languageAr ? 'القب' : 'Title',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select Option',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: callYou,
                                  items: ['Mr', 'Mrs', 'MS', 'Dr']
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
                                return widget.languageAr
                                    ? 'اسمك مطلوب'
                                    : 'Your Name is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                name = x;
                              });
                            },
                            widget.languageAr ? 'الاسم' : 'Name',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return widget.languageAr
                                    ? 'رقم هاتفك المحمول مطلوب'
                                    : 'Your Mobile Number  is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                mobile = x;
                              });
                            },
                            widget.languageAr ? 'رقم الجوال' : 'Mobile',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return widget.languageAr
                                    ? 'الفيسبوك الخاص بك هو مطلوب'
                                    : 'Your Facebook ID is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                facebookId = x;
                              });
                            },
                            widget.languageAr ? 'حساب الفيسبوك' : 'Facebook ID',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return widget.languageAr
                                    ? 'بريدك الإلكتروني مطلوب'
                                    : 'Your Email is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                email = x;
                              });
                            },
                            widget.languageAr ? 'البريد الإلكتروني' : 'Email',
                            TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: widget.languageAr
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: Text(
                                widget.languageAr ? 'الجنسية' : 'Nationality',
                                style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 5.0),
                                child: CustomDropDown(
                                  isExpanded: true,
                                  items: admissionFormDropdownCountriesJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item['NationalityID']
                                                  .toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item['NationalityName']
                                                      .toString(),
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
                                  value: nationality,
                                  hint: new Text(
                                    widget.languageAr
                                        ? 'اختار'
                                        : 'Select option',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  searchHint: new Text(
                                    widget.languageAr
                                        ? 'اختار'
                                        : 'Select option',
                                    style: new TextStyle(
                                        fontSize: 20,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      nationality = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // alignment: widget.languageAr
                          //                             ? Alignment.centerRight
                          //                             : Alignment.centerLeft,

                          Column(
                            children: <Widget>[
                              Container(
                                alignment: widget.languageAr
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    widget.languageAr
                                        ? 'برنامج / دورة الاهتمام'
                                        : 'Program/Course Of Interest',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select option',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: program,
                                  items: admissionFormDropdownProgramJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item['DegreeType_Id']
                                                  .toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    item['DegreeType_Id']
                                                        .toString()),
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
                                return widget.languageAr
                                    ? 'الرجاء حدد'
                                    : 'Please Specify';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                other = x;
                              });
                            },
                            widget.languageAr
                                ? 'الرجاء حدد, آخر'
                                : 'Other , Please Specify',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: widget.languageAr
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    widget.languageAr
                                        ? 'طريقة التدريس'
                                        : 'Mode Of Teaching',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select option',
                                      style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: languageStudied,
                                  items: ['English', 'Arabic']
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
                                return widget.languageAr
                                    ? 'تخصصك مطلوب'
                                    : 'Your Major is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                major = x;
                              });
                            },
                            widget.languageAr
                                ? 'التخصص الدقيق / التركيز / الدورة القصيرة'
                                : 'Specific Major/Emphasis/Short Course',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return widget.languageAr
                                    ? 'مدرستك مطلوبة'
                                    : 'Your School is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                school = x;
                              });
                            },
                            widget.languageAr
                                ? 'اسم المدرسة / الجامعة'
                                : 'Name Of School/University',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: widget.languageAr
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    widget.languageAr ? 'مستوى' : 'Level',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select option',
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
                                return widget.languageAr
                                    ? 'مهنتك الوظيفية مطلوبة'
                                    : 'Your Job Occupation is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                occupation = x;
                              });
                            },
                            widget.languageAr
                                ? 'المهنة الحالية'
                                : 'Current Occupation',
                            TextInputType.text,
                          ),
                          globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return widget.languageAr
                                    ? 'اسم منظمتك مطلوب'
                                    : 'Your Organization Name is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                organizationName = x;
                              });
                            },
                            widget.languageAr
                                ? 'اسم المنظمة'
                                : 'Name of The Organization',
                            TextInputType.text,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: widget.languageAr
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: Text(
                                    widget.languageAr
                                        ? 'نوع المنظمة'
                                        : 'Type of Organization',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select option',
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

  Future getCountriesAndProgram() async {
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
}
