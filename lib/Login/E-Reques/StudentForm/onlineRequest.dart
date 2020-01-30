import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
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

final leaveApplication = GlobalKey<FormState>();
final time = GlobalKey<FormState>();

final _onlineRequest = GlobalKey<FormState>();
// Map<String, int> body;

class _OnlineRequestState extends State<OnlineRequest> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  String reasonAgains = '';
  String timeReason = '';
  String currentShift;
  String newShift;
  String reasonForLeave = '';
  String addressTo = '';
  String documentSubmitted = '';
  Map insertLeaveApplicationJson = {};
  String mobileNumber = '';
  String residenceContactNumber = '';
  List shiftTimesJson = [];
  List onlineRequestTypeJson = [];
  List courseWithdrawalJson = [];
  Map checkRequestJson = {};
  Map checkRequestMessageJson = {};
  Map onlineRequestJson = {};
  Map insertShiftChangeJson = {};
  Map requestAmountJson = {};
  List midMarksJson = [];
  List resitMarksJson = [];
  String localName = '';
  String localNumber = '';
  int multiSelect = 0;
  int course = 0;
  String remarksResit = '';
  Map insertMitigationJson = {};
  Map insertResitMarksJson = {};
  String internationalName = '';
  String reasonPassport = '';
  String internationalNumber = '';
  List repaeatingMarksJson = [];
  List againstMarksJson = [];
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
  Map insertAgainsJson = {};
  String grade;
  String allValueMid;
  List<bool> selectedAgainsMarks = new List<bool>();
  List<bool> selectedMitigationCourses = new List<bool>();
  List<bool> selectedResitCourses = new List<bool>();
  List<bool> selectedRepaeatingCourses = new List<bool>();
  List<bool> selectedCourseWithdrawals = new List<bool>();
  Map insertCourseWithdrawalJson = {};

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
                // insertMitigation();
                if (checkRequestJson['status'] != 'Closed') {
                  if (requestId != '6' ||
                      requestId != '1' ||
                      requestId != '5' ||
                      requestId != '143' ||
                      requestId != '109' ||
                      requestId != '31') insertRequest();
                  if (requestId == '6') {
                    insertMitigation();
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
                    showSuccessSnackBar(context,
                        'Thank You, Your Request Submitted Successfully');
                    //TODO: Send Request
                    // if (_onlineRequest.currentState.validate() &&
                    //     requestId != null) {
                    //   _onlineRequest.currentState.save();
                    //   sendOnlineRequest();
                    // } else {
                    //   // return showErrorInput('Please check your input');
                    // }
                  }
                  if (requestId == '31') {
                    insertShiftChange();
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
                    insertResitOrGradeImprovement();
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
                    setState(() {
                      insertAgainsMarks();
                    });
                  }
                  if (requestId == '109') {
                    //Passport

                  }
                  if (requestId == '66') {
                    //TODO: Send Request
                    if (leaveApplication.currentState.validate()) {
                      leaveApplication.currentState.save();
                      insertLeaveApplication();
                    } else {
                      // return showErrorInput('Please check your input');
                    }
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
                                            value: item['MiscID'].toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                child: Text(
                                                  item['MiscName'].toString(),
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
                                    // getCheckRequest();

                                    if (requestId != '143' ||
                                        requestId != '6' ||
                                        requestId != '1' ||
                                        requestId != '5' ||
                                        requestId != '109' ||
                                        requestId != '66') {
                                      getAmount();
                                    }
                                    if (requestId == '109') {
                                      getAmount();
                                    }

                                    if (requestId == '143') {
                                      getAmount();
                                      getAgainstMarks();
                                    }
                                    if (requestId == '6') {
                                      getAmount();
                                      getMidMarksCourses();
                                    }
                                    if (requestId == '5') {
                                      getAmount();
                                      getResitMarksCourses();
                                    }

                                    if (requestId == '1') {
                                      getAmount();
                                      // getRepaeatingMarksCourses();
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
                      // requestId == '109'
                      //     ?

                      //     Form(
                      //         key: _passportWithdrawal,
                      //         child: Column(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: <Widget>[
                      //             Padding(
                      //               padding: const EdgeInsets.all(5.0),
                      //               child: Card(
                      //                 color: isDark(context)
                      //                     ? Color(0xFF121212)
                      //                     : Colors.white,
                      //                 elevation: 5,
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.start,
                      //                   children: <Widget>[
                      //                     Column(
                      //                       children: <Widget>[
                      //                         Container(
                      //                           child: Padding(
                      //                             padding: const EdgeInsets.all(
                      //                                 10.0),
                      //                             child: Text(
                      //                               'Normal Amount',
                      //                               style: TextStyle(
                      //                                   color: isDark(context)
                      //                                       ? Colors.white
                      //                                       : Colors.black),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding:
                      //                               const EdgeInsets.all(10.0),
                      //                           child: Container(
                      //                             height: 25,
                      //                             child: Text(
                      //                               requestAmountJson.isEmpty ||
                      //                                       requestAmountJson ==
                      //                                           null
                      //                                   ? ''
                      //                                   : requestAmountJson[
                      //                                                   'data'][
                      //                                               'NormalAmount'] ==
                      //                                           ("NA")
                      //                                       ? "Not Avalible"
                      //                                       : requestAmountJson[
                      //                                                   'data'][
                      //                                               'NormalAmount']
                      //                                           .toString(),
                      //                               style: TextStyle(
                      //                                   color: isDark(context)
                      //                                       ? Colors.white
                      //                                       : Colors.black),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             globalForms(
                      //               context,
                      //               '',
                      //               (String value) {
                      //                 if (value.trim().isEmpty) {
                      //                   return 'Name is required';
                      //                 }
                      //                 return null;
                      //               },
                      //               (x) {
                      //                 setState(() {
                      //                   localName = x;
                      //                 });
                      //               },
                      //               'Contact Local Name',
                      //               TextInputType.text,
                      //             ),
                      //             globalForms(
                      //               context,
                      //               '',
                      //               (String value) {
                      //                 if (value.trim().isEmpty) {
                      //                   return 'Number is required';
                      //                 }
                      //                 return null;
                      //               },
                      //               (x) {
                      //                 setState(() {
                      //                   localNumber = x;
                      //                 });
                      //               },
                      //               'Contact Local Number',
                      //               TextInputType.number,
                      //             ),
                      //             globalForms(
                      //               context,
                      //               '',
                      //               (String value) {
                      //                 if (value.trim().isEmpty) {
                      //                   return 'Name is required';
                      //                 }
                      //                 return null;
                      //               },
                      //               (x) {
                      //                 setState(() {
                      //                   internationalName = x;
                      //                 });
                      //               },
                      //               'Contact International Name',
                      //               TextInputType.text,
                      //             ),
                      //             globalForms(
                      //               context,
                      //               '',
                      //               (String value) {
                      //                 if (value.trim().isEmpty) {
                      //                   return 'Number is required';
                      //                 }
                      //                 return null;
                      //               },
                      //               (x) {
                      //                 setState(() {
                      //                   internationalNumber = x;
                      //                 });
                      //               },
                      //               'Contact International Number',
                      //               TextInputType.number,
                      //             ),
                      //             globalForms(
                      //               context,
                      //               '',
                      //               (String value) {
                      //                 if (value.trim().isEmpty) {
                      //                   return 'Reason is required';
                      //                 }
                      //                 return null;
                      //               },
                      //               (x) {
                      //                 setState(() {
                      //                   reasonPassport = x;
                      //                 });
                      //               },
                      //               'Reason',
                      //               TextInputType.text,
                      //             ),
                      //             SizedBox(
                      //               height: 10,
                      //             ),
                      //             datePickers(context),
                      //           ],
                      //         ),
                      //       )

                      // value == time
                      // : requestId == '6'

                      requestId == '6'
                          ? midMarksJson == null || midMarksJson.isEmpty
                              ? SizedBox()
                              : Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        color: isDark(context)
                                            ? Color(0xFF121212)
                                            : Colors.white,
                                        elevation: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'Normal Amount',
                                                      style: TextStyle(
                                                          color: isDark(context)
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Container(
                                                    height: 25,
                                                    child: Text(
                                                      requestAmountJson
                                                                  .isEmpty ||
                                                              requestAmountJson ==
                                                                  null
                                                          ? ''
                                                          : requestAmountJson[
                                                                          'data']
                                                                      [
                                                                      'NormalAmount'] ==
                                                                  ("NA")
                                                              ? "Not Avalible"
                                                              : requestAmountJson[
                                                                          'data']
                                                                      [
                                                                      'NormalAmount']
                                                                  .toString(),
                                                      style: TextStyle(
                                                          color: isDark(context)
                                                              ? Colors.white
                                                              : Colors.black),
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          itemCount: midMarksJson.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return new Card(
                                              child: new Container(
                                                padding:
                                                    new EdgeInsets.all(10.0),
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CheckboxListTile(
                                                        value:
                                                            selectedMitigationCourses[
                                                                index],
                                                        title: new Text(
                                                            midMarksJson[index]
                                                                ['CourseName']),
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .leading,
                                                        onChanged: (bool val) {
                                                          setState(() {
                                                            selectedMitigationCourses[
                                                                index] = val;
                                                          });
                                                        })
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                )
                          : requestId == '31'
                              ? GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  },
                                  child: ListView(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 0.0, 10.0, 5.0),
                                              child: Text(
                                                'Current Timings',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark(context)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          dropDownWidget(
                                              context,
                                              'Select Your Current Timings',
                                              currentShift,
                                              shiftTimesJson,
                                              'Shift_Desc',
                                              'Shift_Desc', (value) {
                                            setState(() {
                                              currentShift = value;
                                            });
                                          }, 'New Timings'),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          dropDownWidget(
                                              context,
                                              'Select Your New Timings',
                                              newShift,
                                              shiftTimesJson,
                                              'Shift_Desc',
                                              'Shift_Desc', (value) {
                                            setState(() {
                                              newShift = value;
                                            });
                                          }, 'New Timings'),
                                          Form(
                                              key: time,
                                              child: globalForms(
                                                context,
                                                '',
                                                (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Your Reason is required';
                                                  }
                                                  return null;
                                                },
                                                (x) {
                                                  setState(() {
                                                    timeReason = x;
                                                  });
                                                },
                                                'Reason',
                                                TextInputType.text,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : requestId == '66'
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView(
                                        children: <Widget>[
                                          Form(
                                            key: leaveApplication,
                                            child: Column(
                                              children: <Widget>[
                                                datePickers(context,
                                                    'Leave from ', from),
                                                datePickers(
                                                    context, 'Leave to ', to),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Residence Contact Number is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    residenceContactNumber = x;
                                                  });
                                                }, 'Residence Contact Number',
                                                    TextInputType.text),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return ' Mobile Number is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    mobileNumber = x;
                                                  });
                                                }, ' Mobile Number',
                                                    TextInputType.text),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Document Submitted is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    documentSubmitted = x;
                                                  });
                                                }, 'Document Submitted',
                                                    TextInputType.text),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Address is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    addressTo = x;
                                                  });
                                                }, 'Address to',
                                                    TextInputType.text),
                                                globalForms(context, '',
                                                    (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Reason for Leave is required';
                                                  }
                                                  return null;
                                                }, (x) {
                                                  setState(() {
                                                    reasonForLeave = x;
                                                  });
                                                }, 'Reason for Leave',
                                                    TextInputType.text),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : requestId == '1'
                                      ? repaeatingMarksJson == null ||
                                              repaeatingMarksJson.isEmpty
                                          ? SizedBox()
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
                                                                              .all(
                                                                          8.0),
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
                                                        allValuerepaeating =
                                                            value;
                                                        cddIdrepaeating = value
                                                            .split('||')[0];
                                                        cddCoderepaeating =
                                                            value
                                                                .split('||')[1];
                                                        cddDescriptionrepaeating =
                                                            value
                                                                .split('||')[2];

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
                                      : requestId == '5'
                                          ? resitMarksJson == null ||
                                                  resitMarksJson.isEmpty
                                              ? SizedBox()
                                              : Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
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
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: Text(
                                                                      'Normal Amount',
                                                                      style: TextStyle(
                                                                          color: isDark(context)
                                                                              ? Colors.white
                                                                              : Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    child: Text(
                                                                      requestAmountJson.isEmpty ||
                                                                              requestAmountJson ==
                                                                                  null
                                                                          ? ''
                                                                          : requestAmountJson['data']['NormalAmount'] == ("NA")
                                                                              ? "Not Avalible"
                                                                              : requestAmountJson['data']['NormalAmount'].toString(),
                                                                      style: TextStyle(
                                                                          color: isDark(context)
                                                                              ? Colors.white
                                                                              : Colors.black),
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
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ListView.builder(
                                                          itemCount:
                                                              resitMarksJson
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return new Card(
                                                              child:
                                                                  new Container(
                                                                padding:
                                                                    new EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child:
                                                                    new Column(
                                                                  children: <
                                                                      Widget>[
                                                                    new CheckboxListTile(
                                                                        value: selectedResitCourses[
                                                                            index],
                                                                        title: new Text(resitMarksJson[index]
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
                                                                            selectedResitCourses[index] =
                                                                                val;
                                                                          });
                                                                        })
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                    globalForms(context, '',
                                                        (String value) {
                                                      if (value
                                                          .trim()
                                                          .isEmpty) {
                                                        return 'Reason is required';
                                                      }
                                                      return null;
                                                    }, (x) {
                                                      setState(() {
                                                        remarksResit = x;
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
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Card(
                                                              color: isDark(context)
                                                                  ? Color(
                                                                      0xFF121212)
                                                                  : Colors
                                                                      .white,
                                                              elevation: 5,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              Text(
                                                                            'Normal Amount',
                                                                            style:
                                                                                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              25,
                                                                          child:
                                                                              Text(
                                                                            requestAmountJson.isEmpty || requestAmountJson == null
                                                                                ? ''
                                                                                : requestAmountJson['data']['NormalAmount'] == null ? '' : requestAmountJson['data']['NormalAmount'] == ("NA") ? "Not Avalible" : requestAmountJson['data']['NormalAmount'].toString(),
                                                                            style:
                                                                                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: new ListView
                                                                    .builder(
                                                                itemCount:
                                                                    againstMarksJson
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return new Card(
                                                                    child:
                                                                        new Container(
                                                                      padding: new EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          new Column(
                                                                        children: <
                                                                            Widget>[
                                                                          new CheckboxListTile(
                                                                              value: selectedAgainsMarks[index],
                                                                              title: new Text(againstMarksJson[index]['CourseName']),
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              onChanged: (bool val) {
                                                                                setState(() {
                                                                                  selectedAgainsMarks[index] = val;
                                                                                });
                                                                              })
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                          globalForms(
                                                              context, '',
                                                              (String value) {
                                                            if (value
                                                                .trim()
                                                                .isEmpty) {
                                                              return 'Reason is required';
                                                            }
                                                            return null;
                                                          }, (x) {
                                                            setState(() {
                                                              reasonAgains = x;
                                                            });
                                                          },
                                                              'Reason',
                                                              TextInputType
                                                                  .text),
                                                        ],
                                                      ),
                                                    )
                                              : Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
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
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: Text(
                                                                      'Normal Amount',
                                                                      style: TextStyle(
                                                                          color: isDark(context)
                                                                              ? Colors.white
                                                                              : Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    child: Text(
                                                                      requestAmountJson.isEmpty ||
                                                                              requestAmountJson ==
                                                                                  null
                                                                          ? ''
                                                                          : requestAmountJson['data']['NormalAmount'] == ("NA")
                                                                              ? "Not Avalible"
                                                                              : requestAmountJson['data']['NormalAmount'].toString(),
                                                                      style: TextStyle(
                                                                          color: isDark(context)
                                                                              ? Colors.white
                                                                              : Colors.black),
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
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
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
                                                              children: <
                                                                  Widget>[
                                                                globalForms(
                                                                    context, '',
                                                                    (String
                                                                        value) {
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
                                                                    (String
                                                                        value) {
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
                                                  ],
                                                )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget datePickers(BuildContext context, String title, nameValue) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
            child: Text(
              title,
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
                if (nameValue == null) {
                  return 'Date is required';
                }
                return null;
              },
              initialValue: initialValue,
              onChanged: (date) => setState(() {
                nameValue = date;
                changedCount++;
              }),
              onSaved: (date) => setState(() {
                nameValue = date;
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

  Future getRequestType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestOnline'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'Operation': 'ONLINE',
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

  Future insertAgainstMarks() async {
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
            // midMarksJson = json.decode(response.body)['data'];
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

        if (requestId == '143') {
          setState(() {
            getAgainstMarks();
          });
        }

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
          'StudentID': username,
          'RequestTypeid': requestId.toString(),
          // 'RequestType': requestType,
          'AddressTo': address.toString(),
          'Remarks': remark.toString(),
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
          'RequestTypeid': requestId,
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

//   Future getRepaeatingMarksCourses() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//         selectedRepaeatingCourses = [];
//       repaeatingMarksJson = [];
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/test/RepaeatingMarksCourses'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             repaeatingMarksJson = json.decode(response.body)['data'];
//               for (int i = 0; i < 20; i++) {
//               selectedRepaeatingCourses.add(false);
//             }
//           },
//         );
//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);
//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getRequestType);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getRequestType);
//       }
//     }
//   }
//  Future insertRepaeatingMarks() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     int i = 0;

//     selectedRepaeatingCourses.forEach((selectedRepaeatingCourse) async {
//       if (selectedRepaeatingCourse) {
//         try {
//           final response = await http.post(
//             Uri.encodeFull(
//                 'https://skylineportal.com/moappad/api/test/InsertAgainstMarks'),
//             headers: {
//               "API-KEY": API,
//             },
//             body: {
//               'Stud_ID': username,
//               'RequestTypeID': requestId,
//               'Batch_ID': repaeatingMarksJson[i]['Batch_ID'],
//               'CDD_ID': repaeatingMarksJson[i]['CDD_ID'],
//               'CourseCode': repaeatingMarksJson[i]['CDD_Code'],
//               'CourseTitle': repaeatingMarksJson[i]['CourseName'],
//               'AssessmentName': repaeatingMarksJson[i]['AssessmentName'],
//             },
//           ).timeout(Duration(seconds: 35));

//           if (response.statusCode == 200) {
//             insertMitigationJson = json.decode(response.body);
//           }
//         } catch (x) {
//           if (x.toString().contains("TimeoutException")) {
//             showLoading(false, context);
//             showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//                 context, sendOnlineRequest);
//           } else {
//             showLoading(false, context);
//             showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//                 sendOnlineRequest);
//           }
//         }
//       }
//       i++;
//     });
//     showLoading(false, context);

//     //send confirmation
//   }

  // COURSE WITHDRAWAL
  // Repeating
  //HERE Get  CourseWithdrawal

  Future insertLeaveApplication() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/InsertLeaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'LeaveFrom': from.toString(),
          'LeaveTo': to.toString(),
          'LeaveContactNo': residenceContactNumber.toString(),
          'RequestTypeID': requestId.toString(),
          'Student_Id': username.toString(),
          'LeaveDocAttached': documentSubmitted.toString(),
          'LeaveContactAddress': reasonForLeave.toString(),
          'AddressTo': addressTo.toString(),
          'StudRemarks': reasonForLeave.toString(),
          'LeaveMobile': mobileNumber.toString(),
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          insertLeaveApplicationJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, insertLeaveApplication);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            insertLeaveApplication);
      }
    }

    if (insertLeaveApplicationJson['success'] == '0') {
      showfailureSnackBar(context, insertLeaveApplicationJson['message']);
    }
    if (insertLeaveApplicationJson['success'] == '1') {
      showSuccessSnackBar(context, insertLeaveApplicationJson['message']);
    }
    //send confirmation
  }

  Future getShiftTime() async {
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
            shiftTimesJson = json.decode(response.body)['data'];
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

  Future insertShiftChange() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/InsertLeaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'ClassShiftChangeFrom': '',
          'ClassShiftChangeTo': '',
          'RequestTypeID': requestId.toString(),
          'Student_Id': username,
          'AddressTo': '',
          'StudRemarks': '',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          insertShiftChangeJson = json.decode(response.body);
        });
        showLoading(false, context);

        // insertCourseWithdrawalJson = json.decode(response.body);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, insertShiftChange);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            insertShiftChange);
      }
    }
    if (insertShiftChangeJson['success'] == '0') {
      showfailureSnackBar(context, insertShiftChangeJson['message']);
    }
    if (insertShiftChangeJson['success'] == '1') {
      showSuccessSnackBar(context, insertShiftChangeJson['message']);
    }
    //send confirmation
  }

  Future getCourseWithdrawal() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedCourseWithdrawals = [];
      courseWithdrawalJson = [];
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/CourseWithdrawalCourses'),
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
            courseWithdrawalJson = json.decode(response.body)['data'];

            for (int i = 0; i < 20; i++) {
              selectedCourseWithdrawals.add(false);
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

  Future insertCourseWithdrawal() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;

    selectedCourseWithdrawals.forEach((selectedCourseWithdrawal) async {
      if (selectedCourseWithdrawal) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/InsertWithdrawalCourses'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId.toString(),
              'Batch_ID': againstMarksJson[i]['Batch_ID'].toString(),
              'CDD_ID': againstMarksJson[i]['CDD_ID'].toString(),
              'CourseCode': againstMarksJson[i]['CDD_Code'].toString(),
              'CourseTitle': againstMarksJson[i]['CourseName'].toString(),
              'AssessmentName':
                  againstMarksJson[i]['AssessmentName'].toString(),
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            setState(() {
              insertCourseWithdrawalJson = json.decode(response.body);
            });
            showLoading(false, context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertCourseWithdrawal);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertCourseWithdrawal);
          }
        }
      }
      i++;
    });
    if (insertCourseWithdrawalJson['success'] == '0') {
      showfailureSnackBar(context, insertCourseWithdrawalJson['message']);
    }
    if (insertCourseWithdrawalJson['success'] == '1') {
      showSuccessSnackBar(context, insertCourseWithdrawalJson['message']);
    }
    //send confirmation
  }

  Future getAgainstMarks() async {
    Future.delayed(Duration.zero, () {});

    try {
      selectedAgainsMarks = [];
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
              selectedAgainsMarks.add(false);
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

  Future insertAgainsMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;

    selectedAgainsMarks.forEach((selectedAgainsMark) async {
      if (selectedAgainsMark) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/InsertAgainstMarks'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId.toString(),
              'Batch_ID': againstMarksJson[i]['Batch_ID'].toString(),
              'CDD_ID': againstMarksJson[i]['CDD_ID'].toString(),
              'CourseCode': againstMarksJson[i]['CDD_Code'].toString(),
              'CourseTitle': againstMarksJson[i]['CourseName'].toString(),
              'AssessmentName':
                  againstMarksJson[i]['AssessmentName'].toString(),
              'Rason': reasonAgains
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            setState(() {
              insertAgainsJson = json.decode(response.body);
            });
            print(againstMarksJson);

            showLoading(false, context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertAgainsMarks);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertAgainsMarks);
          }
        }
      }
      i++;
    });
    if (insertAgainsJson['success'] == '0') {
      showfailureSnackBar(context, insertAgainsJson['message']);
    }
    if (insertAgainsJson['success'] == '1') {
      showSuccessSnackBar(context, insertAgainsJson['message']);
    }
    //send confirmation
  }

  Future getMidMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedMitigationCourses = [];
      midMarksJson = [];
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
            for (int i = 0; i < midMarksJson.length; i++) {
              selectedMitigationCourses.add(false);
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

  Future insertMitigation() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;

    selectedMitigationCourses.forEach((selectedMitigationCourse) async {
      if (selectedMitigationCourse) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/InsertMitigationExam'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId.toString(),
              'Batch_ID': midMarksJson[i]['Batch_ID'].toString(),
              'CDD_ID': midMarksJson[i]['CDD_ID'].toString(),
              'CourseCode': midMarksJson[i]['CDD_Code'].toString(),
              'CourseTitle': midMarksJson[i]['CourseName'].toString(),
              'AssessmentName': midMarksJson[i]['AssessmentName'].toString(),
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            setState(() {
              insertMitigationJson = json.decode(response.body);
            });
            showLoading(false, context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertMitigation);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertMitigation);
          }
        }
      }
      i++;
    });

    // showLoading(false, context);
    if (insertMitigationJson['success'] == '0') {
      showfailureSnackBar(context, insertMitigationJson['message']);
    }
    if (insertMitigationJson['success'] == '1') {
      showSuccessSnackBar(context, insertMitigationJson['message']);
    }
    //send confirmation
  }

  Future getResitMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedResitCourses = [];
      resitMarksJson = [];
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
            for (int i = 0; i < 20; i++) {
              selectedResitCourses.add(false);
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

  Future insertResitOrGradeImprovement() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;

    selectedResitCourses.forEach((selectedResitCourse) async {
      if (selectedResitCourse) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/onlineRequest'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId,
              'Remarks': remarksResit,
              'Grade': resitMarksJson[i],
              'CourseTitle': resitMarksJson[i],
              'CourseCode': resitMarksJson[i],
              'CDD_ID': resitMarksJson[i],
              'Batch_ID': resitMarksJson[i],
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            setState(() {
              insertResitMarksJson = json.decode(response.body);
            });
            showLoading(false, context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertResitOrGradeImprovement);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertResitOrGradeImprovement);
          }
        }
      }

      i++;
    });
    if (insertResitMarksJson['success'] == '0') {
      showfailureSnackBar(context, insertResitMarksJson['message']);
    }
    if (insertResitMarksJson['success'] == '1') {
      showSuccessSnackBar(context, insertResitMarksJson['message']);
    }
    //send confirmation
  }
}
