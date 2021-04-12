import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(AdvisorAppointment());

class AdvisorAppointment extends StatefulWidget {
  final String myAdvisorName;
  final String myAdvisorId;

  const AdvisorAppointment({Key key, this.myAdvisorName, this.myAdvisorId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdvisorAppointmentState();
  }
}

final _studentProblem = GlobalKey<FormState>();
// Map<String, int> body;

class _AdvisorAppointmentState extends State<AdvisorAppointment> {
  List advisorApptTimeJson = [];
  List advisorDateJson = [];
  List advisorCaseJson = [];
  Map advisorNameJson = {};

  Map advisorAppointmentJson = {};

  int groupValue;
  String studentProblem = '';

  String time;
  String date;
  bool checkValue = false;
  String caseDescription;
  String dates;
  @override
  void initState() {
    super.initState();

    getAdvisorDate();
    groupValue = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: bottomappBar(context, () {
        setState(() {
          if (groupValue == 1 &&
              _studentProblem.currentState.validate() &&
              date != null &&
              time != null &&
              caseDescription != null) {
            _studentProblem.currentState.save();
            sendAdvisorAppointment();
          } else {
            checkValue = true;
          }

          if (groupValue == 2 && date != null && time != null) {
            sendAdvisorAppointment();
          } else {
            checkValue = true;
          }
        });
      }),
      appBar: appBarLogin(context, 'Advisor Appointment'),
      body: advisorApptTimeJson == null && advisorApptTimeJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.myAdvisorName == null
                                        ? ''
                                        : widget.myAdvisorName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: isDark(context)
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF1F1F1F),
                                        Color(0xFF1F1F1F),
                                      ],
                                      stops: [
                                        0.7,
                                        0.9,
                                      ],
                                    )
                                  : LinearGradient(
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
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        dropDownWidget(context, 'Select Option', date,
                            advisorDateJson, 'days', 'days', (value) {
                          setState(() {
                            date = value;
                          });
                        }, 'Appointment Date'),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[

                        //     Padding(
                        //       padding: const EdgeInsets.fromLTRB(
                        //           20.0, 0.0, 20.0, 5.0),
                        //       child: DropdownButton<String>(
                        //         underline: Container(
                        //           height: 1,
                        //           color: checkValue
                        //               ? date == null
                        //                   ? Colors.red
                        //                   : Colors.white.withOpacity(0.2)
                        //               : null,
                        //         ),
                        //         isExpanded: true,
                        //         hint: Text(
                        //           'Date',
                        //           style: TextStyle(
                        //               color: isDark(context)
                        //                   ? Colors.white
                        //                   : Colors.black),
                        //         ),
                        //         value: date,
                        //         items: advisorDateJson
                        //                 ?.map(
                        //                   (item) => DropdownMenuItem<String>(
                        //                     value: item['days'],
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Text(item['days']),
                        //                     ),
                        //                   ),
                        //                 )
                        //                 ?.toList() ??
                        //             [],
                        //         onChanged: (value) {
                        //           setState(() {
                        //             date = value;
                        //             getAdvisorApptTime();
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 20.0, 5.0),
                                child: Text(
                                  'Appointment Time',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            dropDownWidget(
                                context,
                                'Select Option',
                                time,
                                advisorApptTimeJson,
                                'time_text',
                                'time_text', (value) {
                              setState(() {
                                time = value;
                              });
                            }, 'Time'),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(
                            //       20.0, 0.0, 20.0, 5.0),
                            //   child: DropdownButton<String>(
                            //     underline: Container(
                            //       height: 1,
                            //       color: checkValue
                            //           ? time == null
                            //               ? Colors.red
                            //               : Colors.white.withOpacity(0.2)
                            //           : null,
                            //     ),
                            //     value: time,
                            //     isExpanded: true,
                            //     hint: Text(
                            //       'Time',
                            //       style: TextStyle(
                            //           color: isDark(context)
                            //               ? Colors.white
                            //               : Colors.black),
                            //     ),
                            //     items: advisorApptTimeJson
                            //             ?.map(
                            //                 (item) => DropdownMenuItem<String>(
                            //                     value: item['Session_Time'],
                            //                     child: Padding(
                            //                       padding:
                            //                           const EdgeInsets.all(8.0),
                            //                       child: Text(
                            //                           item['Session_Time']),
                            //                     )))
                            //             ?.toList() ??
                            //         [],
                            //     onChanged: (value) {
                            //       setState(() {
                            //         time = value;
                            //       });
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Register New Case",
                                style: TextStyle(
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Radio(
                                        value: 1,
                                        groupValue: groupValue,
                                        onChanged: (int e) {
                                          setState(() {
                                            groupValue = e;
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'No',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: groupValue,
                                    onChanged: (int e) {
                                      setState(() {
                                        groupValue = e;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        groupValue == 2
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),

                                  dropDownWidget(
                                      context,
                                      'Select Option',
                                      caseDescription,
                                      advisorCaseJson,
                                      'CATEGORY_ID',
                                      'CATEGORY_DESCRIPTION', (value) {
                                    setState(() {
                                      caseDescription = value;
                                    });
                                  }, 'Case Description'),

                                  // Padding(
                                  //   padding: const EdgeInsets.fromLTRB(
                                  //       20.0, 0.0, 20.0, 5.0),
                                  //   child: DropdownButton<String>(
                                  //     underline: Container(
                                  //       height: 1,
                                  //       color: groupValue == 1
                                  //           ? checkValue
                                  //               ? caseDescription == null
                                  //                   ? Colors.red
                                  //                   : Colors.white
                                  //                       .withOpacity(0.2)
                                  //               : null
                                  //           : null,
                                  //     ),
                                  //     isExpanded: true,
                                  //     value: caseDescription,
                                  //     hint: Text(
                                  //       'Case Description',
                                  //       style: TextStyle(
                                  //           color: isDark(context)
                                  //               ? Colors.white
                                  //               : Colors.black),
                                  //     ),
                                  //     items: advisorCaseJson
                                  //             ?.map((item) => DropdownMenuItem<
                                  //                     String>(
                                  //                 value: item['CATEGORY_ID']
                                  //                     .toString(),
                                  //                 child: Text(item[
                                  //                     'CATEGORY_DESCRIPTION'])))
                                  //             ?.toList() ??
                                  //         [],
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         caseDescription = value;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  Form(
                                    key: _studentProblem,
                                    child: globalForms(
                                      context,
                                      '',
                                      (String value) {
                                        if (value.trim().isEmpty) {
                                          return 'Student problem is required';
                                        }
                                        return null;
                                      },
                                      (x) {
                                        setState(() {
                                          studentProblem = x;
                                        });
                                      },
                                      'Student Problem',
                                      TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getAdvisorDate() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/AdvisorNameDateCasedesc'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            advisorDateJson = json.decode(response.body)['data']['dates'];
            advisorCaseJson =
                json.decode(response.body)['data']['case_description'];
            advisorNameJson =
                json.decode(response.body)['data']['advisor_name'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdvisorDate);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdvisorDate);
      }
    }
  }

  Future getAdvisorApptTime() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/AdvisorApptTime'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'appt_date': date,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            advisorApptTimeJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdvisorDate);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdvisorDate);
      }
    }
  }

  Future sendAdvisorAppointment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/advisorAppointment'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'AdvisorID': widget.myAdvisorId,
          'AppoinmentDate': date,
          'AppoinmentTime': time,
          'CaseDescription': caseDescription,
          'StudentProblem': studentProblem,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            advisorAppointmentJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }

      showSuccessSnackBar(context, advisorAppointmentJson['message']);
    } catch (x) {
      print(x);

      if (x.toString().contains("TimeoutException")) {
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendAdvisorAppointment);
      } else {
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendAdvisorAppointment);
      }
    }
  }
}
