import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(OnlineRequest());

class OnlineRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnlineRequestState();
  }
}

final _onlineRequest = GlobalKey<FormState>();
final _passportWithdrawal = GlobalKey<FormState>();
// Map<String, int> body;

class _OnlineRequestState extends State<OnlineRequest> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  List onlineRequestTypeJson = [];
  Map checkRequestJson = {};
  Map checkRequestMessageJson = {};
  Map onlineRequestJson = {};
  Map requestAmountJson = {};
  List midMarksJson = [];
  List resitMarksJson = [];
  String localName = '';
  String localNumber = '';
  int multiSelect = 0;
  int course = 0;

  String internationalName = '';
  String reasonPassport = '';
  String internationalNumber = '';
  List repaeatingMarksJson = [];
  List againstMarksJson = [];
  String allValue;
  String address = '';
  String remark = '';
  String ex1 = "No value selected";
  int groupValue = 1;
  String gradeResit;
  String requestId;
  String allValuerepaeating;
  String cddIdrepaeating;
  String cddCoderepaeating;

  String cddDescriptionrepaeating;

  String cddIdMid;
  String cddCodeMid;
  String courseNameMid;
  String batchIdMid;
  String allValueResit;
  String cddIdResit;
  String cddCodeResit;
  String courseNameResit;
  String batchIdResit;

  String cddId;
  String reason;
  String batchId;
  String cddCode;
  String courseName;
  String grade;
  String allValueMid;

  List<bool> selectedCourses = new List<bool>();

  @override
  void initState() {
    super.initState();

    getRequestType();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: onlineRequestTypeJson == null ||
              onlineRequestTypeJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                if (checkRequestJson['status'] != 'Closed') {
                  if (requestId == '6') {
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }
                  if (requestId == '1') {
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }
                  if (requestId == '5') {
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }
                  if (requestId == '143') {
                    setState(() async {
                      if (multiSelect == aptitudeJson.length - 2) {
                        // btnName = "Finish";
                      }

                      if (multiSelect < aptitudeJson.length) {
                        if (course != -1) {
                          // await sendAptitudes();
                          if (multiSelect == aptitudeJson.length - 1) {
                            // completedAptitudes();
                            return;
                          }
                        } else {
                          // return showErrorInput('Please select one option');
                        }
                        multiSelect++;
                      }

                      course = -1;
                    });
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }
                  if (requestId == '109') {
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }

                  // if (_onlineRequest.currentState.validate() &&
                  //     requestId != null) {
                  //   // _onlineRequest.currentState.save();
                  //   // sendOnlineRequest();
                  // } else {
                  //   // return showErrorInput('Please check your input');
                  // }
                } else {
                  // print(checkRequestJson['message']);

                  showDailyFailureSnackBar(
                      context, checkRequestMessageJson['message'].toString());
                }
              },
            ),
      appBar: appBarLogin(context, 'Online Request'),
      body: onlineRequestTypeJson == null || onlineRequestTypeJson.isEmpty
          ? exception(context)
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                          child: Text(
                            'Request Type',
                            style: TextStyle(
                              color:
                                  isDark(context) ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: CustomDropDown(
                                isExpanded: true,
                                items: onlineRequestTypeJson
                                        ?.map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item['DetailsID'].toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                child: Text(
                                                  item['Item'].toString(),
                                                  style: TextStyle(
                                                      color: isDark(context)
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        ?.toList() ??
                                    [],
                                value: requestId,
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
                                  setState(() async {
                                    requestId = value;
                                    print(requestId);
                                    getCheckRequest();

                                    if (requestId != '143' ||
                                        requestId != '109' ||
                                        requestId != '6' ||
                                        requestId == '5') {
                                      getAmount();
                                    }

                                    if (requestId == '143') {
                                      getAgainstMarks();
                                    }
                                    if (requestId == '6') {
                                      getMidMarksCourses();
                                    }
                                    if (requestId == '5') {
                                      getResitMarksCourses();
                                    }

                                    if (requestId == '1') {
                                      getRepaeatingMarksCourses();
                                    }

                                    //  else {
                                    //   final result = await showfailureSnackBar(
                                    //       context, checkRequestJson['message']);
                                    // }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      requestId == '109'
                          ? Form(
                              key: _passportWithdrawal,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  globalForms(
                                    context,
                                    '',
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        localName = x;
                                      });
                                    },
                                    'Contact Local Name',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    '',
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Number is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        localNumber = x;
                                      });
                                    },
                                    'Contact Local Number',
                                    TextInputType.number,
                                  ),
                                  globalForms(
                                    context,
                                    '',
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        internationalName = x;
                                      });
                                    },
                                    'Contact International Name',
                                    TextInputType.text,
                                  ),
                                  globalForms(
                                    context,
                                    '',
                                    (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Number is required';
                                      }
                                      return null;
                                    },
                                    (x) {
                                      setState(() {
                                        internationalNumber = x;
                                      });
                                    },
                                    'Contact International Number',
                                    TextInputType.number,
                                  ),
                                  globalForms(
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
                                        reasonPassport = x;
                                      });
                                    },
                                    'Reason',
                                    TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  datePickers(context),
                                ],
                              ),
                            )

                          // value == time
                          : requestId == '6'
                              ? midMarksJson == null || midMarksJson.isEmpty
                                  ? SizedBox()
                                  : Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 5.0),
                                            child: Text(
                                              'Courses',
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
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
                                            value: allValueMid,
                                            items: midMarksJson
                                                    ?.map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item['CDD_ID']
                                                                .toString() +
                                                            "||" +
                                                            item['CDD_Code']
                                                                .toString() +
                                                            "||" +
                                                            item['CourseName']
                                                                .toString() +
                                                            "||" +
                                                            item['Batch_ID']
                                                                .toString(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: FittedBox(
                                                              child: Text(item[
                                                                      'CourseName'] +
                                                                  '  ' +
                                                                  item['AssessmentName']
                                                                      .toString())),
                                                        ),
                                                      ),
                                                    )
                                                    ?.toList() ??
                                                [],
                                            onChanged: (value) {
                                              setState(() {
                                                allValueMid = value;
                                                cddIdMid = value.split('||')[0];
                                                cddCodeMid =
                                                    value.split('||')[1];
                                                courseNameMid =
                                                    value.split('||')[2];

                                                batchIdMid =
                                                    value.split('||')[3];

                                                // againstMark = value;
                                              });
                                            },
                                          ),
                                        ),
                                        globalForms(context, '',
                                            (String value) {
                                          if (value.trim().isEmpty) {
                                            return 'Reason is required';
                                          }
                                          return null;
                                        }, (x) {
                                          setState(() {
                                            reason = x;
                                          });
                                        }, 'Reason', TextInputType.text),
                                      ],
                                    )
                              : requestId == '1'
                                  ? repaeatingMarksJson == null ||
                                          repaeatingMarksJson.isEmpty
                                      ? SizedBox()
                                      : Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0.0, 20.0, 5.0),
                                                child: Text(
                                                  'Courses',
                                                  style: TextStyle(
                                                    color: isDark(context)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton<String>(
                                                underline: Container(
                                                  height: 1,
                                                  color: Color(0xFF2f2f2f),
                                                ),
                                                hint: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                value: allValuerepaeating,
                                                items: repaeatingMarksJson
                                                        ?.map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                            value: item[
                                                                        'CDD_ID']
                                                                    .toString() +
                                                                "||" +
                                                                item['CDD_Code']
                                                                    .toString() +
                                                                "||" +
                                                                item['Cdd_Description']
                                                                    .toString(),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: FittedBox(
                                                                  child: Text(item[
                                                                          'CourseName'] +
                                                                      '  ' +
                                                                      item['AssessmentName']
                                                                          .toString())),
                                                            ),
                                                          ),
                                                        )
                                                        ?.toList() ??
                                                    [],
                                                onChanged: (value) {
                                                  setState(() {
                                                    allValuerepaeating = value;
                                                    cddIdrepaeating =
                                                        value.split('||')[0];
                                                    cddCoderepaeating =
                                                        value.split('||')[1];
                                                    cddDescriptionrepaeating =
                                                        value.split('||')[2];

                                                    // againstMark = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            globalForms(context, '',
                                                (String value) {
                                              if (value.trim().isEmpty) {
                                                return 'Reason is required';
                                              }
                                              return null;
                                            }, (x) {
                                              setState(() {
                                                reason = x;
                                              });
                                            }, 'Reason', TextInputType.text),
                                          ],
                                        )
                                  : requestId == '5'
                                      ? resitMarksJson == null ||
                                              resitMarksJson.isEmpty
                                          ? SizedBox()
                                          : Column(
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20.0, 0.0, 20.0, 5.0),
                                                    child: Text(
                                                      'Courses',
                                                      style: TextStyle(
                                                        color: isDark(context)
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: DropdownButton<String>(
                                                    underline: Container(
                                                      height: 1,
                                                      color: Color(0xFF2f2f2f),
                                                    ),
                                                    hint: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
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
                                                    value: allValueResit,
                                                    items: resitMarksJson
                                                            ?.map(
                                                              (item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                value: item[
                                                                            'CDD_ID']
                                                                        .toString() +
                                                                    "||" +
                                                                    item['CDD_Code']
                                                                        .toString() +
                                                                    "||" +
                                                                    item['CourseName']
                                                                        .toString() +
                                                                    "||" +
                                                                    item['Grade']
                                                                        .toString() +
                                                                    "||" +
                                                                    item['Batch_ID']
                                                                        .toString(),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: FittedBox(
                                                                      child: Text(item[
                                                                              'CourseName'] +
                                                                          '  ' +
                                                                          item['Grade']
                                                                              .toString())),
                                                                ),
                                                              ),
                                                            )
                                                            ?.toList() ??
                                                        [],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        allValueResit = value;
                                                        cddIdResit = value
                                                            .split('||')[0];
                                                        cddCodeResit = value
                                                            .split('||')[1];
                                                        courseNameResit = value
                                                            .split('||')[2];
                                                        gradeResit = value
                                                            .split('||')[4];

                                                        batchIdResit = value
                                                            .split('||')[4];

                                                        // againstMark = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Reason is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    reason = x;
                                                  });
                                                }, 'Reason',
                                                    TextInputType.text),
                                              ],
                                            )
                                      : requestId == '143'
                                          ? againstMarksJson == null ||
                                                  againstMarksJson.isEmpty
                                              ? SizedBox()
                                              : Container(
                                                  height: 400,
                                                  child: new ListView.builder(
                                                      itemCount:
                                                          againstMarksJson
                                                              .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return new Card(
                                                          child: new Container(
                                                            padding:
                                                                new EdgeInsets
                                                                    .all(10.0),
                                                            child: new Column(
                                                              children: <
                                                                  Widget>[
                                                                new CheckboxListTile(
                                                                    value: selectedCourses[
                                                                        index],
                                                                    title: new Text(
                                                                        againstMarksJson[index]
                                                                            [
                                                                            'CourseName']),
                                                                    controlAffinity:
                                                                        ListTileControlAffinity
                                                                            .leading,
                                                                    onChanged:
                                                                        (bool
                                                                            val) {
                                                                      setState(
                                                                          () {
                                                                        selectedCourses[index] =
                                                                            val;
                                                                      });
                                                                    })
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                )

                                          // Column(
                                          //     children: <Widget>[

                                          //       // Text(
                                          //       //   againstMarksJson[
                                          //       //           multiSelect]
                                          //       //       ['CourseName'],
                                          //       //   style: TextStyle(
                                          //       //       fontWeight:
                                          //       //           FontWeight.bold,
                                          //       //       color: Colors.white),
                                          //       // ),
                                          //       // againstMarksJson[
                                          //       //         multiSelect]
                                          //       //     ['question'],
                                          //       // ListTile(
                                          //       //   onTap: () {
                                          //       //     setState(() {
                                          //       //       course = 1;
                                          //       //     });
                                          //       //   },
                                          //       //   selected: course == 1,
                                          //       //   title: Center(
                                          //       //     child: Text(
                                          //       //       'Yes',
                                          //       //       style: TextStyle(
                                          //       //           fontWeight:
                                          //       //               FontWeight
                                          //       //                   .bold),
                                          //       //     ),
                                          //       //   ),
                                          //       // ),
                                          //       Container(
                                          //         alignment:
                                          //             Alignment.centerLeft,
                                          //         child: Padding(
                                          //           padding:
                                          //               const EdgeInsets
                                          //                       .fromLTRB(
                                          //                   20.0,
                                          //                   0.0,
                                          //                   20.0,
                                          //                   5.0),
                                          //           child: Text(
                                          //             'Courses',
                                          //             style: TextStyle(
                                          //               color: isDark(
                                          //                       context)
                                          //                   ? Colors.white
                                          //                   : Colors.black,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(
                                          //                 8.0),
                                          //         child: DropdownButton<
                                          //             String>(
                                          //           underline: Container(
                                          //             height: 1,
                                          //             color:
                                          //                 Color(0xFF2f2f2f),
                                          //           ),
                                          //           hint: Padding(
                                          //             padding:
                                          //                 const EdgeInsets
                                          //                         .fromLTRB(
                                          //                     20.0,
                                          //                     0.0,
                                          //                     20.0,
                                          //                     5.0),
                                          //             child: Text(
                                          //               'Select Option',
                                          //               style: TextStyle(
                                          //                 color: isDark(
                                          //                         context)
                                          //                     ? Colors.white
                                          //                     : Colors
                                          //                         .black,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           isExpanded: true,
                                          //           value: allValue,
                                          //           items: againstMarksJson
                                          //                   ?.map(
                                          //                     (item) =>
                                          //                         DropdownMenuItem<
                                          //                             String>(
                                          //                       value: item[
                                          //                                   'CDD_ID']
                                          //                               .toString() +
                                          //                           "||" +
                                          //                           item['CDD_Code']
                                          //                               .toString() +
                                          //                           "||" +
                                          //                           item['CourseName']
                                          //                               .toString() +
                                          //                           "||" +
                                          //                           item['Grade']
                                          //                               .toString() +
                                          //                           "||" +
                                          //                           item['Batch_ID']
                                          //                               .toString(),
                                          //                       child:
                                          //                           Padding(
                                          //                         padding:
                                          //                             const EdgeInsets.all(
                                          //                                 8.0),
                                          //                         child: FittedBox(
                                          //                             child: Text(item['CourseName'] +
                                          //                                 '  ' +
                                          //                                 item['Grade'].toString())),
                                          //                       ),
                                          //                     ),
                                          //                   )
                                          //                   ?.toList() ??
                                          //               [],
                                          //           onChanged: (value) {
                                          //             setState(() {
                                          //               allValue = value;
                                          //               cddId = value
                                          //                   .split('||')[0];
                                          //               cddCode = value
                                          //                   .split('||')[1];
                                          //               courseName = value
                                          //                   .split('||')[2];
                                          //               grade = value
                                          //                   .split('||')[3];
                                          //               batchId = value
                                          //                   .split('||')[4];

                                          //               // againstMark = value;
                                          //             });
                                          //           },
                                          //         ),
                                          //       ),
                                          //       globalForms(context, '',
                                          //           (String value) {
                                          //         if (value
                                          //             .trim()
                                          //             .isEmpty) {
                                          //           return 'Reason is required';
                                          //         }
                                          //         return null;
                                          //       }, (x) {
                                          //         setState(() {
                                          //           reason = x;
                                          //         });
                                          //       }, 'Reason',
                                          //           TextInputType.text),
                                          //     ],
                                          //   )
                                          : Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Card(
                                                    color: isDark(context)
                                                        ? Color(0xFF121212)
                                                        : Colors.white,
                                                    elevation: 5,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Text(
                                                                  'Normal Amount',
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Container(
                                                                height: 25,
                                                                child: Text(
                                                                  requestAmountJson
                                                                              .isEmpty ||
                                                                          requestAmountJson ==
                                                                              null
                                                                      ? ''
                                                                      : requestAmountJson['data']['NormalAmount'] ==
                                                                              ("NA")
                                                                          ? "Not Avalible"
                                                                          : requestAmountJson['data']['NormalAmount']
                                                                              .toString(),
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Card(
                                                    color: isDark(context)
                                                        ? Color(0xFF121212)
                                                        : Colors.white,
                                                    elevation: 5,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Text(
                                                                  'Urgent Amount',
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Container(
                                                                height: 25,
                                                                child: Text(
                                                                  requestAmountJson
                                                                              .isEmpty ||
                                                                          requestAmountJson ==
                                                                              null
                                                                      ? ''
                                                                      : requestAmountJson['data']['UrgentAmount'] ==
                                                                              ("NA")
                                                                          ? "Not Avalible"
                                                                          : requestAmountJson['data']['UrgentAmount']
                                                                              .toString(),
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Form(
                                                        key: _onlineRequest,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            globalForms(
                                                                context, '',
                                                                (String value) {
                                                              if (value
                                                                  .trim()
                                                                  .isEmpty) {
                                                                return 'Address  is required';
                                                              }
                                                              return null;
                                                            }, (x) {
                                                              setState(() {
                                                                address = x;
                                                              });
                                                            },
                                                                'Address',
                                                                TextInputType
                                                                    .text),
                                                            globalForms(
                                                                context, '',
                                                                (String value) {
                                                              if (value
                                                                  .trim()
                                                                  .isEmpty) {
                                                                return 'Remark is required';
                                                              }
                                                              return null;
                                                            }, (x) {
                                                              setState(() {
                                                                remark = x;
                                                              });
                                                            },
                                                                'Remark',
                                                                TextInputType
                                                                    .text),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20.0, 0.0, 20.0, 5.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Pay Amount",
                                                            style: TextStyle(
                                                                color: isDark(
                                                                        context)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                          )),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Radio(
                                                                value: 1,
                                                                groupValue:
                                                                    groupValue,
                                                                onChanged:
                                                                    (int e) {
                                                                  setState(() {
                                                                    groupValue =
                                                                        e;
                                                                  });
                                                                },
                                                                activeColor:
                                                                    Colors.blue,
                                                              ),
                                                              Text('Normal',
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Radio(
                                                                value: 2,
                                                                groupValue:
                                                                    groupValue,
                                                                onChanged:
                                                                    (int e) {
                                                                  setState(() {
                                                                    groupValue =
                                                                        e;
                                                                  });
                                                                },
                                                                activeColor:
                                                                    Colors.red,
                                                              ),
                                                              Text('Urgent',
                                                                  style: TextStyle(
                                                                      color: isDark(
                                                                              context)
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future getRequestType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'program': studentJson['data']['program'],
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestTypeJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getAgainstMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
  
    try {
      selectedCourses = [];
      againstMarksJson = [];
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/AgainstMarksCourses'),
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
            againstMarksJson = json.decode(response.body)['data'];
            
            for (int i = 0; i < 20; i++) {
              selectedCourses.add(false);
            }
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestAmount'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'req_type_id': requestId,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAmount);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAmount);
      }
    }
  }

  Future sendOnlineRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;
    bool firstRequest = true;

    selectedCourses.forEach((selectedCourse) async {
      if (selectedCourse) {
        try {
          final response = await http.post(
            Uri.encodeFull(firstRequest
                ? 'https://skylineportal.com/moappad/api/test/onlineRequestFirst'
                : 'https://skylineportal.com/moappad/api/test/onlineRequest'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'user_id': username,
              // 'request_type': requestAmountJson['data']['MiscName'],
              // 'request_process': groupValue == 1 ? "Normal" : "Urgent",
              // 'address': address,
              // 'remarks': remark,
              // 'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
              'BatchCode': againstMarksJson[i]['BatchCode'],
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {}
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, sendOnlineRequest);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                sendOnlineRequest);
          }
        }
        firstRequest = false;
      }
      
      i++;
    });
    showLoading(false, context);

    //send confirmation

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/onlineRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'request_type': requestAmountJson['data']['MiscName'],
          'request_process': groupValue == 1 ? "Normal" : "Urgent",
          'address': address,
          'remarks': remark,
          'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestJson = json.decode(response.body);
          },
        );

        showLoading(false, context);
        if (onlineRequestJson['success'] == '0') {
          showfailureSnackBar(context, onlineRequestJson['message']);
        }
        if (onlineRequestJson['success'] == '1') {
          showSuccessSnackBar(context, onlineRequestJson['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendOnlineRequest);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendOnlineRequest);
      }
    }
  }

  Widget datePickers(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
            child: Text(
              'Date to Return',
              style: TextStyle(
                color: isDark(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
              validator: (date) {
                if (value == null) {
                  return 'Date is required';
                }
                return null;
              },
              initialValue: initialValue,
              onChanged: (date) => setState(() {
                value = date;
                changedCount++;
              }),
              onSaved: (date) => setState(() {
                value = date;
                savedCount++;
              }),
              resetIcon: showResetIcon ? Icon(Icons.delete) : null,
              readOnly: readOnly,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: isDark(context)
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black,
                  ),
                ),
                fillColor: Colors.green,
              ),
            ),
          ),
        ]);
  }

  Future getMidMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/MidMarksCourses'),
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
            midMarksJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getRepaeatingMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/RepaeatingMarksCourses'),
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
            repaeatingMarksJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getResitMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/ResitMarksCourses'),
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
            resitMarksJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future insertRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/InsertRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'RequestTypeid': '24', //requestId
          'StudentID': username,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            checkRequestJson = json.decode(response.body)['data'];
            checkRequestMessageJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getCheckRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/CheckRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'RequestTypeid': '24',
          //TODO: Here RequestId
          'StudentID': username,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            checkRequestJson = json.decode(response.body)['data'];
            checkRequestMessageJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }
}
//  ResitMarksCourses
