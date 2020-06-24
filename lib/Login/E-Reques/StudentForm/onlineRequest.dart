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

final insertRepaeating = GlobalKey<FormState>();

final _passportWithdrawal = GlobalKey<FormState>();
final insertResit = GlobalKey<FormState>();
final againsMarks = GlobalKey<FormState>();
DateTime now = DateTime.now();
String date = DateFormat("yyyy-MM-dd").format(now);
final leaveApplication = GlobalKey<FormState>();
final time = GlobalKey<FormState>();

final _onlineRequest = GlobalKey<FormState>();
// Map<String, int> body;

class _OnlineRequestState extends State<OnlineRequest> {
  final format = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime from = DateTime.now();

  String returnDate = DateFormat("yyyy-MM-dd").format(now);

  DateTime to = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  String reasonAgains = '';
  String timeReason = '';
  String newShift;
  String remarksRepaeating = '';
  Map studentPassportJson = {};
  Map currentShiftTimeJson = {};
  String reasonForLeave = '';
  String addressTo = '';
  String documentSubmitted = '';
  Map insertLeaveApplicationJson = {};
  String mobileNumber = '';
  String residenceContactNumber = '';
  List shiftTimesJson = [];
  String addressToTime = '';
  List onlineRequestTypeJson = [];
  List courseWithdrawalJson = [];
  // Map checkRequestJson = {};
  Map checkRequestMessageJson = {};
  Map onlineRequestJson = {};
  Map insertShiftChangeJson = {};
  Map requestAmountJson = {};
  List midMarksJson = [];
  List resitMarksJson = [];
  String remarksWithdrawals = '';
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
    print(now);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: onlineRequestTypeJson == null ||
              onlineRequestTypeJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                switch (requestId) {
                  case '31':
                    {
                      if (time.currentState.validate() && newShift != null) {
                        time.currentState.save();
                        setState(() {
                          insertShiftChange();
                        });
                      }
                    }
                    break;
                  case '143':
                    {
                      if (againsMarks.currentState.validate()) {
                        againsMarks.currentState.save();
                        setState(() {
                          insertAgainsMarks();
                        });
                      }
                    }
                    break;
                  case '5':
                    {
                      if (insertResit.currentState.validate()) {
                        insertResit.currentState.save();

                        setState(() {
                          insertResitOrGradeImprovement();
                        });
                      }
                    }
                    break;

                  case '109':
                    {
                      if (_passportWithdrawal.currentState.validate()) {
                        _passportWithdrawal.currentState.save();

                        setState(() {
                          insertStudentPassport();
                        });
                      }
                    }
                    break;

                  default:
                    {
                      setState(() {});
                      showfailureSnackBar(context,
                          'Your request submitted failed. Please contact IT department');
                    }
                }

                // if (requestId == '1') {
                //   showSuccessSnackBar(context,
                //       'Thank You, Your Request Submitted Successfully');
                //   //TODO: Send Request
                //   // if (_onlineRequest.currentState.validate() &&
                //   //     requestId != null) {
                //   //   _onlineRequest.currentState.save();
                //   //   sendOnlineRequest();
                //   // } else {
                //   //   // return showErrorInput('Please check your input');
                //   // }
                // }

                // if (requestId == '139') {
                //   //COURSE WITHDRAWAL
                //   setState(() {
                //     insertCourseWithdrawal();
                //   });
                // }
                // if (requestId == '66') {
                //   if (leaveApplication.currentState.validate() &&
                //       requestId != null) {
                //     leaveApplication.currentState.save();
                //     setState(() {
                //       insertLeaveApplication();
                //     });
                //   } else {
                //     return;
                //   }
                // }
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

                                    // getCheckRequest();

                                    getAmount();

                                    if (requestId == '139') {
                                      getCourseWithdrawal();
                                    }
                                    if (requestId == '109') {
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
                                    if (requestId == '31') {
                                      getShiftTime();
                                    }
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
                                  // Padding(
                                  //   padding: const EdgeInsets.all(5.0),
                                  //   child: Card(
                                  //     color: isDark(context)
                                  //         ? Color(0xFF121212)
                                  //         : Colors.white,
                                  //     elevation: 5,
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.start,
                                  //       children: <Widget>[
                                  //         Column(
                                  //           children: <Widget>[
                                  //             Container(
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(
                                  //                     10.0),
                                  //                 child: Text(
                                  //                   'Normal Amount',
                                  //                   style: TextStyle(
                                  //                       color: isDark(context)
                                  //                           ? Colors.white
                                  //                           : Colors.black),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(10.0),
                                  //               child: Container(
                                  //                 height: 25,
                                  //                 child: Text(
                                  //                   requestAmountJson.isEmpty ||
                                  //                           requestAmountJson ==
                                  //                               null
                                  //                       ? ''
                                  //                       : requestAmountJson[
                                  //                                       'data'][
                                  //                                   'NormalFees'] ==
                                  //                               ("NA")
                                  //                           ? "Not Avalible"
                                  //                           : requestAmountJson[
                                  //                                       'data'][
                                  //                                   'NormalFees']
                                  //                               .toString(),
                                  //                   style: TextStyle(
                                  //                       color: isDark(context)
                                  //                           ? Colors.white
                                  //                           : Colors.black),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
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
                                    'Local Contact Person',
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
                                    'International Contact Person',
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
                                    'International Contact  Number',
                                    TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  datePickers(
                                      context, 'Date to be Return', returnDate),

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
                                ],
                              ),
                            )

                          // value == time
                          // : requestId == '6'
                          : requestId == '139'
                              ? courseWithdrawalJson == null ||
                                      courseWithdrawalJson.isEmpty
                                  ? SizedBox()
                                  : Column(
                                      children: <Widget>[
                                        // Padding(
                                        //   padding: const EdgeInsets.all(5.0),
                                        //   child: Card(
                                        //     color: isDark(context)
                                        //         ? Color(0xFF121212)
                                        //         : Colors.white,
                                        //     elevation: 5,
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       children: <Widget>[
                                        //         Column(
                                        //           children: <Widget>[
                                        //             Container(
                                        //               child: Padding(
                                        //                 padding:
                                        //                     const EdgeInsets
                                        //                         .all(10.0),
                                        //                 child: Text(
                                        //                   'Normal Amount',
                                        //                   style: TextStyle(
                                        //                       color: isDark(
                                        //                               context)
                                        //                           ? Colors.white
                                        //                           : Colors
                                        //                               .black),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //             Padding(
                                        //               padding:
                                        //                   const EdgeInsets.all(
                                        //                       10.0),
                                        //               child: Container(
                                        //                 height: 25,
                                        //                 child: Text(
                                        //                   requestAmountJson ==
                                        //                               null ||
                                        //                           requestAmountJson
                                        //                               .isEmpty
                                        //                       ? ''
                                        //                       : requestAmountJson[
                                        //                                       'data']
                                        //                                   [
                                        //                                   'NormalFees'] ==
                                        //                               ("NA")
                                        //                           ? "Not Avalible"
                                        //                           : requestAmountJson[
                                        //                                       'data']
                                        //                                   [
                                        //                                   'NormalFees']
                                        //                               .toString(),
                                        //                   style: TextStyle(
                                        //                       color: isDark(
                                        //                               context)
                                        //                           ? Colors.white
                                        //                           : Colors
                                        //                               .black),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount:
                                                courseWithdrawalJson.length,
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
                                                              selectedCourseWithdrawals[
                                                                  index],
                                                          title: new Text(
                                                              midMarksJson[
                                                                      index][
                                                                  'CourseName']),
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          onChanged:
                                                              (bool val) {
                                                            setState(() {
                                                              selectedCourseWithdrawals[
                                                                  index] = val;
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        Form(
                                          key: insertResit,
                                          child: globalForms(context, '',
                                              (String value) {
                                            if (value.trim().isEmpty) {
                                              return 'Reason is required';
                                            }
                                            return null;
                                          }, (x) {
                                            setState(() {
                                              remarksWithdrawals = x;
                                            });
                                          }, 'Reason', TextInputType.text),
                                        ),
                                      ],
                                    )
                              : requestId == '6'
                                  ? midMarksJson == null || midMarksJson.isEmpty
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
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
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
                                                                  .all(10.0),
                                                          child: Container(
                                                            height: 25,
                                                            child: Text(
                                                              requestAmountJson
                                                                          .isEmpty ||
                                                                      requestAmountJson ==
                                                                          null
                                                                  ? ''
                                                                  : requestAmountJson['data']
                                                                              [
                                                                              'NormalFees'] ==
                                                                          ("NA")
                                                                      ? "Not Avalible"
                                                                      : requestAmountJson['data']
                                                                              [
                                                                              'NormalFees']
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
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                itemCount: midMarksJson.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return new Card(
                                                    child: new Container(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              10.0),
                                                      child: new Column(
                                                        children: <Widget>[
                                                          new CheckboxListTile(
                                                              value:
                                                                  selectedMitigationCourses[
                                                                      index],
                                                              title: new Text(
                                                                  midMarksJson[
                                                                          index]
                                                                      [
                                                                      'CourseName']),
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .leading,
                                                              onChanged:
                                                                  (bool val) {
                                                                setState(() {
                                                                  selectedMitigationCourses[
                                                                          index] =
                                                                      val;
                                                                });
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            //  Form(
                                            //                   key:
                                            //                       againsMarks,
                                            //                   child: globalForms(
                                            //                       context,
                                            //                       '',
                                            //                       (String
                                            //                           value) {
                                            //                     if (value
                                            //                         .trim()
                                            //                         .isEmpty) {
                                            //                       return 'Reason is required';
                                            //                     }
                                            //                     return null;
                                            //                   }, (x) {
                                            //                     setState(
                                            //                         () {
                                            //                       reasonMitigation =
                                            //                           x;
                                            //                     });
                                            //                   },
                                            //                       'Reason',
                                            //                       TextInputType
                                            //                           .text),
                                            //                 ),
                                          ],
                                        )
                                  : requestId == '31'
                                      ? GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isDark(context)
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 500,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: new BoxDecoration(
                                                  gradient: isDark(context)
                                                      ? LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
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
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
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
                                                child: Text(
                                                  currentShiftTimeJson
                                                              .isEmpty ||
                                                          currentShiftTimeJson ==
                                                              null
                                                      ? ''
                                                      : currentShiftTimeJson[
                                                                  'Shift_Desc'] ==
                                                              'NA'
                                                          ? ''
                                                          : currentShiftTimeJson[
                                                              'Shift_Desc'],
                                                  style: TextStyle(
                                                      color: Colors.white),
//
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              dropDownWidget(
                                                  context,
                                                  'Select Your Current Timings',
                                                  newShift,
                                                  shiftTimesJson,
                                                  'Shift_Desc',
                                                  'Shift_Desc', (value) {
                                                setState(() {
                                                  newShift = value;
                                                });
                                              }, 'New Timings'),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // dropDownWidget(
                                              //     context,
                                              //     'Select Your New Timings',
                                              //     newShift,
                                              //     shiftTimesJson,
                                              //     'Shift_Desc',
                                              //     'Shift_Desc', (value) {
                                              //   setState(() {
                                              //     newShift = value;
                                              //   });
                                              // }, 'New Timings'),
                                              Form(
                                                  key: time,
                                                  child: Column(
                                                    children: <Widget>[
                                                      globalForms(
                                                        context,
                                                        '',
                                                        (String value) {
                                                          if (value
                                                              .trim()
                                                              .isEmpty) {
                                                            return 'Your AddressTo is required';
                                                          }
                                                          return null;
                                                        },
                                                        (x) {
                                                          setState(() {
                                                            addressToTime = x;
                                                          });
                                                        },
                                                        'Address To',
                                                        TextInputType.text,
                                                      ),
                                                      globalForms(
                                                        context,
                                                        '',
                                                        (String value) {
                                                          if (value
                                                              .trim()
                                                              .isEmpty) {
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
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      : requestId == '66'
                                          ? Form(
                                              key: leaveApplication,
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      datePickers(context,
                                                          'Leave from ', from),
                                                      datePickers(context,
                                                          'Leave to ', to),
                                                      globalForms(context, '',
                                                          (String value) {
                                                        if (!RegExp(
                                                                r'^05[0-9]{8}$')
                                                            .hasMatch(value)) {
                                                          return 'Please check residence contact number';
                                                        }
                                                        return null;
                                                      }, (x) {
                                                        setState(() {
                                                          residenceContactNumber =
                                                              x;
                                                        });
                                                      }, 'Residence Contact Number',
                                                          TextInputType.number),
                                                      globalForms(context, '',
                                                          (String value) {
                                                        if (!RegExp(
                                                                r'^05[0-9]{8}$')
                                                            .hasMatch(value)) {
                                                          return 'Please check residence mobile Number ';
                                                        }
                                                        return null;
                                                      }, (x) {
                                                        setState(() {
                                                          mobileNumber = x;
                                                        });
                                                      }, ' Mobile Number',
                                                          TextInputType.number),
                                                      globalForms(context, '',
                                                          (String value) {
                                                        if (value
                                                            .trim()
                                                            .isEmpty) {
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
                                                        if (value
                                                            .trim()
                                                            .isEmpty) {
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
                                                        if (value
                                                            .trim()
                                                            .isEmpty) {
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
                                                  )
                                                ],
                                              ),
                                            )
                                          : requestId == '1'
                                              ? repaeatingMarksJson == null ||
                                                      repaeatingMarksJson
                                                          .isEmpty
                                                  ? SizedBox()
                                                  : Column(
                                                      children: <Widget>[
                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(5.0),
                                                        //   child: Card(
                                                        //     color: isDark(context)
                                                        //         ? Color(0xFF121212)
                                                        //         : Colors.white,
                                                        //     elevation: 5,
                                                        //     child: Row(
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment.start,
                                                        //       children: <Widget>[
                                                        //         Column(
                                                        //           children: <Widget>[
                                                        //             Container(
                                                        //               child: Padding(
                                                        //                 padding:
                                                        //                     const EdgeInsets
                                                        //                         .all(10.0),
                                                        //                 child: Text(
                                                        //                   'Normal Amount',
                                                        //                   style: TextStyle(
                                                        //                       color: isDark(
                                                        //                               context)
                                                        //                           ? Colors.white
                                                        //                           : Colors
                                                        //                               .black),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //             Padding(
                                                        //               padding:
                                                        //                   const EdgeInsets.all(
                                                        //                       10.0),
                                                        //               child: Container(
                                                        //                 height: 25,
                                                        //                 child: Text(
                                                        //                   requestAmountJson ==
                                                        //                               null ||
                                                        //                           requestAmountJson
                                                        //                               .isEmpty
                                                        //                       ? ''
                                                        //                       : requestAmountJson[
                                                        //                                       'data']
                                                        //                                   [
                                                        //                                   'NormalFees'] ==
                                                        //                               ("NA")
                                                        //                           ? "Not Avalible"
                                                        //                           : requestAmountJson[
                                                        //                                       'data']
                                                        //                                   [
                                                        //                                   'NormalFees']
                                                        //                               .toString(),
                                                        //                   style: TextStyle(
                                                        //                       color: isDark(
                                                        //                               context)
                                                        //                           ? Colors.white
                                                        //                           : Colors
                                                        //                               .black),
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                ClampingScrollPhysics(),
                                                            itemCount:
                                                                repaeatingMarksJson
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
                                                                          value: selectedCourseWithdrawals[
                                                                              index],
                                                                          title: new Text(repaeatingMarksJson[index]
                                                                              [
                                                                              'CourseName']),
                                                                          controlAffinity: ListTileControlAffinity
                                                                              .leading,
                                                                          onChanged:
                                                                              (bool val) {
                                                                            setState(() {
                                                                              selectedRepaeatingCourses[index] = val;
                                                                            });
                                                                          })
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                        Form(
                                                          key: insertRepaeating,
                                                          child: globalForms(
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
                                                              remarksRepaeating =
                                                                  x;
                                                            });
                                                          },
                                                              'Reason',
                                                              TextInputType
                                                                  .text),
                                                        ),
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
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Card(
                                                                color: isDark(
                                                                        context)
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
                                                                              style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
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
                                                                              requestAmountJson == null || requestAmountJson.isEmpty ? '' : requestAmountJson['data']['NormalFees'] == "NA" ? "Not Avalible" : requestAmountJson['data']['NormalFees'].toString(),
                                                                              style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    ClampingScrollPhysics(),
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
                                                                      padding: new EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          new Column(
                                                                        children: <
                                                                            Widget>[
                                                                          new CheckboxListTile(
                                                                              value: selectedResitCourses[index],
                                                                              title: new Text(resitMarksJson[index]['CourseName']),
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              onChanged: (bool val) {
                                                                                setState(() {
                                                                                  selectedResitCourses[index] = val;
                                                                                });
                                                                              })
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                            Form(
                                                              key: insertResit,
                                                              child: globalForms(
                                                                  context, '',
                                                                  (String
                                                                      value) {
                                                                if (value
                                                                    .trim()
                                                                    .isEmpty) {
                                                                  return 'Reason is required';
                                                                }
                                                                return null;
                                                              }, (x) {
                                                                setState(() {
                                                                  remarksResit =
                                                                      x;
                                                                });
                                                              },
                                                                  'Reason',
                                                                  TextInputType
                                                                      .text),
                                                            ),
                                                          ],
                                                        )
                                                  : requestId == '143'
                                                      ? againstMarksJson ==
                                                                  null ||
                                                              againstMarksJson
                                                                  .isEmpty
                                                          ? SizedBox()
                                                          : ListView(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              children: <
                                                                  Widget>[
                                                                // Padding(
                                                                //   padding:
                                                                //       const EdgeInsets
                                                                //               .all(
                                                                //           5.0),
                                                                //   child: Card(
                                                                //     color: isDark(context)
                                                                //         ? Color(
                                                                //             0xFF121212)
                                                                //         : Colors
                                                                //             .white,
                                                                //     elevation:
                                                                //         5,
                                                                //     child: Row(
                                                                //       mainAxisAlignment:
                                                                //           MainAxisAlignment
                                                                //               .start,
                                                                //       children: <
                                                                //           Widget>[
                                                                //         Column(
                                                                //           children: <
                                                                //               Widget>[
                                                                //             Container(
                                                                //               child: Padding(
                                                                //                 padding: const EdgeInsets.all(10.0),
                                                                //                 child: Text(
                                                                //                   'Normal Amount',
                                                                //                   style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
                                                                //                 ),
                                                                //               ),
                                                                //             ),
                                                                //             Padding(
                                                                //               padding: const EdgeInsets.all(10.0),
                                                                //               child: Container(
                                                                //                 height: 25,
                                                                //                 child: Text(
                                                                //                   requestAmountJson == null || requestAmountJson.isEmpty ? '' : requestAmountJson['data']['NormalFees'] == null ? '' : requestAmountJson['data']['NormalFees'] == ("NA") ? "Not Avalible" : requestAmountJson['data']['NormalFees'].toString(),
                                                                //                   style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
                                                                //                 ),
                                                                //               ),
                                                                //             ),
                                                                //           ],
                                                                //         ),
                                                                //       ],
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            ClampingScrollPhysics(),
                                                                        itemCount:
                                                                            againstMarksJson
                                                                                .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return Card(
                                                                            child:
                                                                                new Container(
                                                                              padding: new EdgeInsets.all(10.0),
                                                                              child: new Column(
                                                                                children: <Widget>[
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
                                                                Form(
                                                                  key:
                                                                      againsMarks,
                                                                  child: globalForms(
                                                                      context,
                                                                      '',
                                                                      (String
                                                                          value) {
                                                                    if (value
                                                                        .trim()
                                                                        .isEmpty) {
                                                                      return 'Reason is required';
                                                                    }
                                                                    return null;
                                                                  }, (x) {
                                                                    setState(
                                                                        () {
                                                                      reasonAgains =
                                                                          x;
                                                                    });
                                                                  },
                                                                      'Reason',
                                                                      TextInputType
                                                                          .text),
                                                                ),
                                                              ],
                                                            )
                                                      : Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Card(
                                                                color: isDark(
                                                                        context)
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
                                                                              style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
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
                                                                              requestAmountJson.isEmpty || requestAmountJson == null ? '' : requestAmountJson['data'] == null ? 'Not Avalible' : requestAmountJson['data']['NormalFees'] == ("NA") ? "Not Avalible" : requestAmountJson['data']['NormalFees'].toString(),
                                                                              style: TextStyle(color: isDark(context) ? Colors.white : Colors.black),
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
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Form(
                                                                    key:
                                                                        _onlineRequest,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        globalForms(
                                                                            context,
                                                                            '',
                                                                            (String
                                                                                value) {
                                                                          if (value
                                                                              .trim()
                                                                              .isEmpty) {
                                                                            return 'Address  is required';
                                                                          }
                                                                          return null;
                                                                        }, (x) {
                                                                          setState(
                                                                              () {
                                                                            address =
                                                                                x;
                                                                          });
                                                                        }, 'Address',
                                                                            TextInputType.text),
                                                                        globalForms(
                                                                            context,
                                                                            '',
                                                                            (String
                                                                                value) {
                                                                          if (value
                                                                              .trim()
                                                                              .isEmpty) {
                                                                            return 'Remark is required';
                                                                          }
                                                                          return null;
                                                                        }, (x) {
                                                                          setState(
                                                                              () {
                                                                            remark =
                                                                                x;
                                                                          });
                                                                        }, 'Remark',
                                                                            TextInputType.text),
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

  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestFees'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'MiscID': requestId,
          'Stud_ID': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);
          },
        );

        // if (requestId == '143') {
        //   setState(() {
        //     getAgainstMarks();
        //   });
        // }

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

  // Future insertRequest() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.encodeFull(
  //           'https://skylineportal.com/moappad/api/test/InsertRequest'),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'StudentID': username,
  //         'RequestTypeid': requestId.toString(),
  //         // 'RequestType': requestType,
  //         'AddressTo': address.toString(),
  //         'Remarks': remark.toString(),
  //       },
  //     ).timeout(Duration(seconds: 35));

  //     if (response.statusCode == 200) {
  //       setState(
  //         () {
  //           requestAmountJson = json.decode(response.body);
  //         },
  //       );
  //       showLoading(false, context);
  //     }
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);
  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, getAmount);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           getAmount);
  //     }
  //   }
  // }

  // Future getCheckRequest() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.encodeFull(
  //           'https://skylineportal.com/moappad/api/test/CheckRequest'),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'RequestTypeid': requestId,
  //         'StudentID': username,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       setState(
  //         () {
  //           checkRequestJson = json.decode(response.body)['data'];
  //           checkRequestMessageJson = json.decode(response.body);
  //         },
  //       );
  //       showLoading(false, context);
  //     }
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);
  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, getRequestType);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           getRequestType);
  //     }
  //   }
  // }

  Future getRepaeatingMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedRepaeatingCourses = [];
      repaeatingMarksJson = [];
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
            for (int i = 0; i < 20; i++) {
              selectedRepaeatingCourses.add(false);
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

  Future insertRepaeatingMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = 0;

    selectedRepaeatingCourses.forEach((selectedRepaeatingCourse) async {
      if (selectedRepaeatingCourse) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/InsertRepaeatingMarks'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId,
              'Batch_ID': repaeatingMarksJson[i]['Batch_ID'],
              'CDD_ID': repaeatingMarksJson[i]['CDD_ID'],
              'CourseCode': repaeatingMarksJson[i]['CDD_Code'],
              'CourseTitle': repaeatingMarksJson[i]['CourseName'],
              'Grade': repaeatingMarksJson[i]['Grade'],
              'Remarks': remarksRepaeating,
              'RequestDate': date.toString()
            },
          ).timeout(Duration(seconds: 35));
          showLoading(false, context);

          showfailureSnackBar(context,
              'Your request submitted failed. Please contact IT department');
          // if (response.statusCode == 200) {
          //   insertMitigationJson = json.decode(response.body);
          // }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertRepaeatingMarks);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertRepaeatingMarks);
          }
        }
      }
      i++;
    });
    showLoading(false, context);

    //send confirmation
  }

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
      );
      // if (response.statusCode == 200) {
      //   setState(() {
      //     insertLeaveApplicationJson = json.decode(response.body);
      //   });
      //   showLoading(false, context);
      // }
      showLoading(false, context);

      showfailureSnackBar(context,
          'Your request submitted failed. Please contact IT department');
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

    // if (insertLeaveApplicationJson['success'] == '0') {
    //   showfailureSnackBar(context, insertLeaveApplicationJson['message']);
    // }
    // if (insertLeaveApplicationJson['success'] == '1') {
    //   showSuccessSnackBar(context, insertLeaveApplicationJson['message']);
    // }
  }

  Future getShiftTime() async {
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
            currentShiftTimeJson =
                json.decode(response.body)['data']['current_shift'];
            shiftTimesJson = json.decode(response.body)['data']['shifts'];
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
            'https://skylineportal.com/moappad/api/test/InsertShiftChange'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'ClassShiftChangeFrom': currentShiftTimeJson['Shift_Desc'],
          'ClassShiftChangeTo': newShift.toString(),
          'RequestTypeId': requestId.toString(),
          'RequestType': 'Normal',
          'Student_Id': username,
          'AddressTo': addressToTime,
          'StudRemarks': timeReason,
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
      print(x);
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
    if (insertShiftChangeJson['success'] == '1') {
      showfailureSnackBar(context, insertShiftChangeJson['message']);
    }
    if (insertShiftChangeJson['success'] == '0') {
      showSuccessSnackBar(context, insertShiftChangeJson['message']);
    }
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
              'Batch_ID': courseWithdrawalJson[i]['Batch_ID'].toString(),
              'CDD_ID': courseWithdrawalJson[i]['CDD_ID'].toString(),
              'CourseCode': courseWithdrawalJson[i]['CDD_Code'].toString(),
              'CourseTitle': courseWithdrawalJson[i]['CourseName'].toString(),
              'Grade': courseWithdrawalJson[i]['Grade'].toString(),
              'Remarks': remarksWithdrawals,
              'RequestDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));
          showLoading(false, context);

          showfailureSnackBar(context,
              'Your request submitted failed. Please contact IT department');
          // if (response.statusCode == 200) {
          //   setState(() {
          //     insertCourseWithdrawalJson = json.decode(response.body);
          //   });
          //   showLoading(false, context);
          // }
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
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

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

            for (int i = 0; i < againstMarksJson.length; i++) {
              selectedAgainsMarks.add(false);
            }
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
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
              'Grade': againstMarksJson[i]['Grade'].toString(),
              'Remarks': reasonAgains,
              'RequestDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));

          showLoading(false, context);

          showfailureSnackBar(context,
              'Your request submitted failed. Please contact IT department');

          // if (response.statusCode == 200) {
          //   setState(() {
          //     insertAgainsJson = json.decode(response.body);
          //   });

          //   showLoading(false, context);
          // }
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
              'DateOfAssessment': date.toString(),
              'RequestDate': date.toString(),
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
            for (int i = 0; i < resitMarksJson.length; i++) {
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
                'https://skylineportal.com/moappad/api/test/insertResitOrGradeImprovement'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': requestId,
              'Remarks': remarksResit,
              'Grade': resitMarksJson[i]['Grade'],
              'CourseTitle': resitMarksJson[i]['CourseName'],
              'CourseCode': resitMarksJson[i]['CDD_Code'],
              'CDD_ID': resitMarksJson[i]['CDD_ID'].toString(),
              'Batch_ID': resitMarksJson[i]['Batch_ID'].toString(),
              'RequestDate': date.toString()
            },
          ).timeout(Duration(seconds: 35));
          showLoading(false, context);

          showfailureSnackBar(context,
              'Your request submitted failed. Please contact IT department');
          // if (response.statusCode == 200) {
          //   setState(() {
          //     insertResitMarksJson = json.decode(response.body);
          //   });
          //   showLoading(false, context);
          // }
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

  Future insertStudentPassport() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/passportWithdrawal'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'LocalPersonName': localName,
          'LocalMobileNo': localNumber,
          'InternationalPersonName': internationalName,
          'InternationalMobileNo': internationalNumber,
          'ReturnDate': returnDate,
          'RequestTypeid': requestId,
          'Reason': reasonPassport,
          'RequestDate': date.toString()
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            studentPassportJson = json.decode(response.body);
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
    if (studentPassportJson['success'] == '0') {
      showfailureSnackBar(context, studentPassportJson['message']);
    }
    if (studentPassportJson['success'] == '1') {
      showSuccessSnackBar(context, studentPassportJson['message']);
    }
  }
}
