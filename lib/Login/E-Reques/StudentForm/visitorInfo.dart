import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidgetVisitor.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/formVisitor.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:translator/translator.dart';

void main() => runApp(VisitorInfo());

class VisitorInfo extends StatefulWidget {
  final bool languageAr;

  const VisitorInfo({Key key, this.languageAr}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoState();
  }
}

final visitor = GlobalKey<FormState>();
final translator = GoogleTranslator();

class _VisitorInfoState extends State<VisitorInfo> {
  Map visitorInformationFormJson = {};
  List admissionFormDropdownProgramEnJson = [];
  List admissionFormDropdownCountriesJson = [];
  List admissionFormDropdownOrganizationEnJson = [];
  List admissionFormDropdownQualificationEnJson = [];
  List admissionFormDropdowShortCoursesJson = [];
  List titleJson = [];
  String translatorName = '';
  String callYou;
  String name = '';
  String shortCourse;
  String mobile = '';
  String facebookId = '';
  String email = '';
  String event = '';
  String nationality;
  String program;
  String other = '';

  String languageStudied;
  String major = '';
  String school = '';
  String level;
  String occupation = '';
  String organizationName = '';
  String organizationType;
  String translatorOrganizationType = '';

  // String translatorevent = '';
  String translatorOther = '';
  String translatorMajor = '';
  String translatorOccupation = '';
  String translatororganizationName = '';
  String translatorProgram = '';
  String translatorShortCourse = '';

  String translatorLevel = '';
  String translatorEvent = '';

  @override
  void initState() {
    super.initState();

    getCountriesAndProgram();
  }

  @override
  Widget build(BuildContext context) {
    
    return Directionality(
      textDirection: widget.languageAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
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

                sendVisitorInformationForm();
              }
            });
          },
        ),
        appBar: appBarLogin(
          context,
          widget.languageAr ? 'معلومات الزائر' : 'Visitor Information',
        ),
        body: admissionFormDropdownCountriesJson == null ||
                admissionFormDropdownCountriesJson.isEmpty
            ? exception(context)
            : //  currentTimeJson == null || currentTimeJson.isEmpty
            //     ? exception(context)
            //     :

            GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
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
                                padding: const EdgeInsets.all(8),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
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
                                  items: titleJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: widget.languageAr
                                                  ? item['titleAr']
                                                  : item['title'],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  widget.languageAr
                                                      ? item['titleAr']
                                                      : item['title'],
                                                ),
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
                          formVisitor(
                            context,
                            '',
                            (String value) {
                              if (value.trim().length < 2) {
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
                          formVisitor(
                            context,
                            '',
                            (String value) {
                              if (int.parse(value) <= 0 || !isNumeric(value)) {
                                return widget.languageAr
                                    ? 'رقم الجوال مطلوب'
                                    : 'Your Mobile Number  is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                mobile = x;
                              });
                            },
                            widget.languageAr ? 'الجوال' : 'Mobile',
                            TextInputType.number,
                          ),
                          formVisitor(
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
                            widget.languageAr
                                ? 'حساب الفيس بوك'
                                : 'Facebook ID',
                            TextInputType.text,
                          ),
                          formVisitor(
                            context,
                            '',
                            (String value) {
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return widget.languageAr
                                    ? 'البريد الإلكتروني مطلوب'
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
                            TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          formVisitor(context, '', (String value) {
                            if (value.trim().isEmpty) {
                              return widget.languageAr
                                  ? 'الفيسبوك الخاص بك هو مطلوب'
                                  : 'Your Facebook ID is required';
                            }
                            return null;
                          }, (x) {
                            setState(() {
                              event = x;
                            });
                          }, widget.languageAr ? 'المناسبة' : 'Event',
                              TextInputType.text),
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
                                padding: const EdgeInsets.all(8),
                                child: CustomDropDown(
                                  isExpanded: true,
                                  items: admissionFormDropdownCountriesJson
                                          ?.map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item['country_code']
                                                  .toString(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  widget.languageAr
                                                      ? item['country_arName']
                                                          .toString()
                                                      : item['country_enName']
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
                                  hint: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
                                    child: new Text(
                                      widget.languageAr
                                          ? 'اختار'
                                          : 'Select option',
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
                          dropDownWidgetVisitor(
                              context,
                              widget.languageAr ? 'اختار' : 'Select option',
                              program,
                              admissionFormDropdownProgramEnJson,
                              widget.languageAr ? 'programAr' : 'programEn',
                              widget.languageAr ? 'programAr' : 'programEn',
                              (value) {
                            setState(() {
                              program = value;
                            });
                            if (program == 'SHORT TERM COURSE' ||
                                program == 'دورات قصيرة') {
                              setState(() {
                                getvisitorCourses();
                              });
                            }
                          },
                              widget.languageAr
                                  ? 'ما هو البرنامج الذي ترغب بدراسته ؟'
                                  : 'Program/Course Of Interest',
                              widget.languageAr),
                          program == 'SHORT TERM COURSE' ||
                                  program == 'دورات قصيرة'
                              ? Column(
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
                                              ? 'دورات قصيرة'
                                              : 'Short courses',
                                          style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          height: 1,
                                          color: Color(0xFF2f2f2f),
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 0.0, 20.0, 5.0),
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
                                        value: shortCourse,
                                        items:
                                            admissionFormDropdowShortCoursesJson
                                                    ?.map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item['courseEn']
                                                            .toString(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: FittedBox(
                                                            child: Text(item[
                                                                    'courseEn']
                                                                .toString()),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    ?.toList() ??
                                                [],
                                        onChanged: (value) {
                                          setState(() {
                                            shortCourse = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          formVisitor(
                            context,
                            '',
                            (String value) {
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
                          SizedBox(
                            height: 10,
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
                                padding: const EdgeInsets.all(8),
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Color(0xFF2f2f2f),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 5.0),
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
                          formVisitor(
                            context,
                            '',
                            (String value) {
                              if (value.trim().length < 4) {
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
                                ? 'اذكر البرنامج أو التخصص/ الدورة القصيرة التي ترغب بدراستها'
                                : 'Specific Major/Emphasis/Short Course',
                            TextInputType.text,
                          ),
                          formVisitor(
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
                                ? 'الاسم المدرسة / الجامعة التي تخرجت منها'
                                : 'Name Of School/University',
                            TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dropDownWidgetVisitor(
                              context,
                              widget.languageAr ? 'اختار' : 'Select option',
                              level,
                              admissionFormDropdownQualificationEnJson,
                              widget.languageAr
                                  ? 'qualificationAr'
                                  : 'qualificationEn',
                              widget.languageAr
                                  ? 'qualificationAr'
                                  : 'qualificationEn', (value) {
                            setState(() {
                              level = value;
                            });
                          }, widget.languageAr ? 'مستوى' : 'Level',
                              widget.languageAr),
                          formVisitor(
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
                          formVisitor(
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
                          SizedBox(
                            height: 10,
                          ),
                          dropDownWidgetVisitor(
                              context,
                              widget.languageAr ? 'اختار' : 'Select option',
                              organizationType,
                              admissionFormDropdownOrganizationEnJson,
                              widget.languageAr
                                  ? 'organizationNameEn'
                                  : 'organizationNameAr',
                              widget.languageAr
                                  ? 'organizationNameEn'
                                  : 'organizationNameAr', (value) {
                            setState(() {
                              organizationType = value;
                            });
                          },
                              widget.languageAr
                                  ? 'نوع المنظمة'
                                  : 'Type of Organization',
                              widget.languageAr),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future getvisitorCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
          Uri.encodeFull(
              'https://skylineportal.com/moappad/api/test/visitorCourses'),
          headers: {
            "API-KEY": API,
          },
          body: {
            // "program"programId,
          }).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionFormDropdowShortCoursesJson =
                json.decode(response.body)['data'];
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

  Future getCountriesAndProgram() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries'),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            titleJson = json.decode(response.body)['data']['title'];
            admissionFormDropdownCountriesJson =
                json.decode(response.body)['data']['countries'];
            admissionFormDropdownProgramEnJson =
                json.decode(response.body)['data']['programEn'];

            admissionFormDropdownQualificationEnJson =
                json.decode(response.body)['data']['qualificationEn'];
            admissionFormDropdownOrganizationEnJson =
                json.decode(response.body)['data']['organization'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCountriesAndProgram);
        // showErrorServer(context, getAdmissionFormDropdownRecords());
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCountriesAndProgram);
        // showErrorConnect(context, getAdmissionFormDropdownRecords());
      }
    }
  }

  Future sendVisitorInformationForm() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
          Uri.encodeFull(
              'https://skylineportal.com/moappad/api/test/visitorInformationForm'),
          headers: {
            "API-KEY": API,
          },
          body: {
            "name": widget.languageAr
                ? translatorName =
                    await translator.translate(name, from: 'ar', to: 'en')
                : name,
            // "shortCourse": widget.languageAr
            //     ? translatorName = await translator.translate(shotrCourse,
            //         from: 'ar', to: 'en')
            //     : shotrCourse,
            "title": callYou,
            "other": program == null
                ? widget.languageAr
                    ? translatorOther =
                        await translator.translate(other, from: 'ar', to: 'en')
                    : other
                : '',
            "shortCourse": widget.languageAr
                ? translatorShortCourse = await translator
                    .translate(shortCourse, from: 'ar', to: 'en')
                : shortCourse,
            "mobile": mobile,
            "facebookId": facebookId,
            "email": email,
            "event": widget.languageAr
                ? translatorEvent =
                    await translator.translate(event, from: 'ar', to: 'en')
                : event,
            "programOfInterest": translatorProgram =
                await translator.translate(program, from: 'ar', to: 'en'),
            "modeOfTeaching": languageStudied,
            "specificMajor": widget.languageAr
                ? translatorMajor =
                    await translator.translate(major, from: 'ar', to: 'en')
                : major,
            "nameOfSchoolUniversity": school,
            "level": widget.languageAr
                ? translatorLevel =
                    await translator.translate(level, from: 'ar', to: 'en')
                : level,
            "currentOccupation": widget.languageAr
                ? translatorOccupation =
                    await translator.translate(occupation, from: 'ar', to: 'en')
                : occupation,
            "nameOfOrganization": widget.languageAr
                ? translatororganizationName = await translator
                    .translate(organizationName, from: 'ar', to: 'en')
                : organizationName,
            "typeOfOrganization": widget.languageAr
                ? translatorOrganizationType = await translator
                    .translate(organizationType, from: 'ar', to: 'en')
                : organizationType,
            "language": widget.languageAr == true ? 'AR' : 'EN',
          }).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            visitorInformationFormJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
        if (visitorInformationFormJson['success'] == '0') {
          showfailureSnackBar(context, visitorInformationFormJson['message']);
        }
        if (visitorInformationFormJson['success'] == '1') {
          showSuccessSnackBar(context, visitorInformationFormJson['message']);
        }
      }
    } catch (x) {
      print(x);
      // if (x.toString().contains("TimeoutException")) {
      //   showLoading(false, context);
      //   showError("Time out from server", FontAwesomeIcons.hourglassHalf,
      //       context, sendVisitorInformationForm);
      //   // showErrorServer(context, getAdmissionFormDropdownRecords());
      // } else {
      //   showLoading(false, context);
      //   showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
      //       sendVisitorInformationForm);
      //   // showErrorConnect(context, getAdmissionFormDropdownRecords());
      // }
    }
  }
}
