import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/E-Reques/StudentForm/onlineRequest%20copy.dart';
import 'package:toggle_switch/toggle_switch.dart';

// import 'package:toggle_switch/toggle_switch.dart';

import 'dropList.dart';
import 'dropdown_formfield.dart';

void main() => runApp(OnlineRequest());

class OnlineRequest extends StatefulWidget {
  final String name;
  final String id;

  const OnlineRequest({Key key, this.name, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OnlineRequestState();
  }
}

class _OnlineRequestState extends State<OnlineRequest> {
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  bool isLoading = true;
  bool resitSelected = false;
  // String miscName = '';
  int miscID = 0;
  var miscNameCnt = TextEditingController();
  var amountNameCnt = TextEditingController();
  var amountUrgentNameCnt = TextEditingController();
  var passportDateNameCnt = TextEditingController();
  var currentShiftNameCnt = TextEditingController();
  var leaveFromDateNameCnt = TextEditingController();

  var leaveToDateNameCnt = TextEditingController();
  var receiptDateNameCnt = TextEditingController();
  Map onlineRequestJson = {};
  Map requestAmountJson = {};
  List resitMarksJson = [];
  Map insertRequestJson = {};
  List<bool> selectedResitCourses = new List<bool>();
  List<bool> selectedMitigationCourses = new List<bool>();
  List<bool> selectedCourseWithdrawals = new List<bool>();
  List<bool> selectedAgainsMarks = new List<bool>();
  List<bool> selectedCourseRepaeating = new List<bool>();

  List againstMarksJson = [];
  List midMarksJson = [];
  List courseWithdrawalJson = [];
  List courseRepaeatingJson = [];
  List newShiftTimesJson = [];
  Map currentShiftTimesJson = {};
  Map insertShiftChangeJson = {};
  List cancellationTypeJson = [];
  //Strings

  //Shift
  String addressToShift = '';
  String reasonShift = '';
  //Repeating
  // String resonRepeating = '';
//Reset
  // String reasonReset = '';

  //Mitigation

  //MarksAgains
  // String reasonAgains = '';

  //cancellationType
  int cancellationTypeID;
  String reasonCancellation = '';
  //Postponement
  String reasonPostponement = '';

  String receiptNo = '';

  String requestType = 'Normal';
  int initialIndex = 0;
  String remark = '';
  String localContactPerson = '';
  String contactNo = '';
  String internationalContactPerson = '';
  String internationalContactNo = '';
  // String reasonPassport = '';
  // String reasonWithdrawals = '';
  String reasonLeave = '';
  String selectedShift = '';
  String residenceContactNo = '';
  String mobileContactNo = '';
  String contactAddress = '';
  String documentSubmitted = '';
  String addressTo = '';
  String addressToLeave = '';
  String leaveToDate = DateFormat('yyyy-MM-dd').format(now);
  String leaveFromDate = DateFormat('yyyy-MM-dd').format(now);

  String receiptDate = DateFormat('yyyy-MM-dd').format(now);

  String passportDate = DateFormat('yyyy-MM-dd').format(now);
  final _formShift = GlobalKey<FormState>();
  final _formRepaeating = GlobalKey<FormState>();
  final _formReset = GlobalKey<FormState>();
  final _formMitigation = GlobalKey<FormState>();
  final _formLeaveApplication = GlobalKey<FormState>();
  final _remarkAndAddressForm = GlobalKey<FormState>();
  final _formAgains = GlobalKey<FormState>();
  final _formCancellationVisa = GlobalKey<FormState>();
  final _formPostponement = GlobalKey<FormState>();
  final _withdrawalForm = GlobalKey<FormState>();
  final _passportForm = GlobalKey<FormState>();

  String _selectedShift;
  int _selectedShiftID;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomappBar(
        context,
        () {
          switch (widget.name) {
            case "Appeals":
              {
                switch (miscID) {
                  case 143:
                    {
                      if (_formAgains.currentState.validate()) {
                        _formAgains.currentState.save();
                        setState(() {
                          // insertRequest();
                          insertAgainsMarks();
                        });
                      }
                    }
                    break;
                  case 109:
                    {
                      if (_passportForm.currentState.validate()) {
                        _passportForm.currentState.save();
                        setState(() {
                          insertStudentPassport();
                        });
                      }

                      //TODO:SendRequest
                      //TODO: Add more forms and date picker

                    }
                    break;
                  case 141:
                    {
                      if (_remarkAndAddressForm.currentState.validate()) {
                        _remarkAndAddressForm.currentState.save();
                        setState(() {
                          sendOnlineRequest();
                        });
                      }

                      //TODO:SendRequest
                      //TODO: Add more forms and date picker

                    }
                    break;
                }
              }
              break;
          }
          switch (miscID) {
            case 110:
              {
                if (_formPostponement.currentState.validate() &&
                    receiptDate != null) {
                  _formPostponement.currentState.save();
                  setState(() {
                    inserPostponement();
                  });
                }
              }
              break;
            case 114:
              {
                if (_formCancellationVisa.currentState.validate() &&
                    cancellationTypeID != null) {
                  _formCancellationVisa.currentState.save();
                  setState(() {
                    insertVisaCancellation();
                  });
                }
              }
              break;
            case 66:
              {
                if (_formLeaveApplication.currentState.validate()) {
                  _formLeaveApplication.currentState.save();
                  setState(() {
                    insertLeaveApplication();
                  });
                }
              }
              break;
            case 1:
              {
                if (_formRepaeating.currentState.validate())
                  _formRepaeating.currentState.save();
                setState(() {
                  insertCourseRepaeating();
                });
              }
              break;
            case 5:
              {
                if (_formReset.currentState.validate()) {
                  _formReset.currentState.save();
                  setState(() {
                    insertResitOrGradeImprovement();
                  });
                }
                //TODO:SendRequest

              }
              break;
            case 6:
              {
                if (_formMitigation.currentState.validate()) {
                  _formMitigation.currentState.save();
                  setState(() {
                    insertMitigation();
                  });
                }
                //TODO:SendRequest

              }
              break;
            // case 109:
            //   {
            //     if (_passportForm.currentState.validate()) {
            //       _passportForm.currentState.save();
            //       setState(() {
            //         insertStudentPassport();
            //       });
            //     }

            //     //TODO:SendRequest
            //     //TODO: Add more forms and date picker

            //   }
            //   break;
            case 139:
              {
                if (_withdrawalForm.currentState.validate()) {
                  _withdrawalForm.currentState.save();
                  setState(() {
                    // insertRequest();
                    insertWithdrawalMarks();
                  });
                }

                //TODO:SendRequest
                //TODO:Add courses

              }
              break;
            // case 143:
            //   {
            //     if (_formAgains.currentState.validate()) {
            //       _formAgains.currentState.save();
            //       setState(() {
            //         // insertRequest();
            //         insertAgainsMarks();
            //       });
            //     }
            //   }
            //   break;
            case 31:
              {
                if (_formShift.currentState.validate() &&
                    _selectedShift != null) {
                  _formShift.currentState.save();
                  print(reasonShift);
                  setState(() {
                    insertShiftChange();
                  });
                }
              }

              break;
            default:
              {
                if (_remarkAndAddressForm.currentState.validate()) {
                  _remarkAndAddressForm.currentState.save();
                  setState(() {
                    sendOnlineRequest();
                  });
                }

                // showfailureSnackBar(context,
                //     'Your request submitted failed. Please contact IT department');
              }
          }
        },
      ),
      resizeToAvoidBottomInset: true,
      appBar: appBarLogin(context, 'Online Request'),
      body:
          //  onlineRequestTypeJson == null || onlineRequestTypeJson.isEmpty
          //     ? exception(context, isLoading)
          //     :
          GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  requestTypeWidget(),

                  amount(),
                  amountUrgent(),
                  switchAmount(),
//ClassShift

                  classShift(),
//Repeating
                  coursesRepeating(),
//Reset
                  coursesReset(),
//Mitigation
                  coursesMitigation(),

//CourseWithDrawal
                  coursesWithDrawal(),

//CourseAgains
                  coursesAgains(),

//LeaveApplication

                  leaveApplication(),

//cancellationVisa
                  cancellationVisa(),
                  passportDetails(),

                  remarkAndAddressWidget(),
                  reasonWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget classShift() {
    List<Widget> chips = new List();
    List colors = [Colors.yellow, Colors.blueGrey, Colors.amberAccent];
    for (int i = 0; i < newShiftTimesJson.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedShiftID == i,
        label: Text(
          newShiftTimesJson[i]['Shift_Desc'],
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.white),
        ),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Color(0xFF3773AC),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedShiftID = i;
              _selectedShift = newShiftTimesJson[i]['Shift_Desc'];
              print(_selectedShift);
            }
          });
        },
      );
      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }

    if (miscID == 31) {
      return Form(
        key: _formShift,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Shift',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            IgnorePointer(
              child: AbsorbPointer(
                child: TextFormField(
                  controller: currentShiftNameCnt,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'New Shift',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: chips,
            ),
            SizedBox(
              height: 25,
            ),
            globalForms(
              context,
              '',
              (String value) {
                if (value.trim().isEmpty) {
                  return 'Please enter address to';
                }
                return null;
              },
              (x) {
                setState(() {
                  addressToShift = x;
                  print(x);
                  print(addressToShift);
                });
              },
              'Address To',
              TextInputType.text,
            ),
            globalForms(
              context,
              '',
              (String value) {
                if (value.trim().isEmpty) {
                  return 'Please enter reason';
                }
                return null;
              },
              (x) {
                setState(() {
                  reasonShift = x;
                });
              },
              'Reason',
              TextInputType.text,
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  // Widget requestTypeWidgetValue() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Request Type',
  //         style:
  //             TextStyle(color: isDark(context) ? Colors.white : Colors.black),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => DropList(
  //                 type: 'ONLINE',
  //               ),
  //             ),
  //           ).then((val) async {
  //             setState(() {
  //               // miscName = val['MiscName'];
  //               miscID = val['MiscID'];
  //               miscNameCnt.text = val['MiscName'];
  //               getAmount();

  //               if (miscID == 5) {
  //                 getResitMarksCourses();
  //               }
  //               if (miscID == 6) {
  //                 getMidMarksCourses();
  //               }
  //               if (miscID == 139) {
  //                 getCourseWithdrawal();
  //               }
  //               if (miscID == 143) {
  //                 getAgainstMarks();
  //               }
  //               if (miscID == 1) {
  //                 getCourseRepeating();
  //               }
  //               if (miscID == 31) {
  //                 getShiftTime();
  //               }
  //               if (miscID == 114) {
  //                 getCancellationVisaType();
  //               }
  //               // print(requestAmountJson['data']['NormalFees']);
  //             });
  //           });
  //         },
  //         child: AbsorbPointer(
  //           child: TextFormField(
  //             validator: (x) => x.isEmpty ? "Please select request type" : null,
  //             onChanged: (x) {
  //               setState(() {
  //                 // isEditing = true;
  //               });
  //             },
  //             controller: miscNameCnt,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 25,
  //       ),
  //     ],
  //   );
  // }

  Widget requestTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Type',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'ONLINE',
                  id: widget.id,
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                miscID = val['MiscID'];
                miscNameCnt.text = val['MiscName'];
                getAmount();

                if (miscID == 5) {
                  getResitMarksCourses();
                }
                if (miscID == 6) {
                  getMidMarksCourses();
                }
                if (miscID == 139) {
                  getCourseWithdrawal();
                }
                if (miscID == 143) {
                  getAgainstMarks();
                }
                if (miscID == 1) {
                  getCourseRepeating();
                }
                if (miscID == 31) {
                  getShiftTime();
                }
                if (miscID == 114) {
                  getCancellationVisaType();
                }
                // print(requestAmountJson['data']['NormalFees']);
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: miscNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget leaveApplication() {
    if (miscID == 66) {
      return Form(
        key: _formLeaveApplication,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave From',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (Platform.isIOS) {
                    _showDatePickerLeaveFrom(context);
                  } else {
                    _showDatePickerAndroidLeaveFrom(context);
                  }
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  validator: (x) =>
                      x.isEmpty ? "Please enter date to be return" : null,
                  onChanged: (x) {
                    setState(() {
                      // isEditing = true;
                    });
                  },
                  controller: leaveFromDateNameCnt,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Leave to',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (Platform.isIOS) {
                    _showDatePickerLeaveTo(context);
                  } else {
                    _showDatePickerAndroidLeaveTo(context);
                  }
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  validator: (x) =>
                      x.isEmpty ? "Please enter date to be return" : null,
                  onChanged: (x) {
                    setState(() {
                      // isEditing = true;
                    });
                  },
                  controller: leaveToDateNameCnt,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Residence Contact Number',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please enter residence contact number" : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  residenceContactNo = x;
                });
              },
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Mobile Number',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter mobile number" : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  mobileContactNo = x;
                });
              },
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Contact Address',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter mobile number" : null,

              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  contactAddress = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Document Submitted',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please enter document submitted" : null,
              onSaved: (x) {
                setState(() {
                  documentSubmitted = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason for Leave',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  reasonLeave = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Future<void> _showDatePickerAndroidLeaveFrom(ctx) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDatePickerMode: DatePickerMode.day);
    if (picked != null)
      setState(() {
        print(picked);
        leaveFromDate = picked.toString();
        leaveFromDate = leaveFromDateNameCnt.text;
      });
  }

  Future<void> _showDatePickerLeaveFrom(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumYear: DateTime.now().year,
                        maximumYear: DateTime.now().year + 1,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            leaveFromDate = val.toString();
                            leaveFromDateNameCnt.text =
                                "${val.year}-${val.month}-${val.day}";
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  Future<void> _showDatePickerAndroidLeaveTo(ctx) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        // confirmText: 'Confirm'

        // selectableDayPredicate: (DateTime x) {
        //   print(x);
        // },
        initialDatePickerMode: DatePickerMode.day);
    if (picked != null)
      setState(() {
        print(picked);
        passportDate = picked.toString();
        leaveToDate = leaveToDateNameCnt.text;
      });
  }

  Future<void> _showDatePickerLeaveTo(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumYear: DateTime.now().year,
                        maximumYear: DateTime.now().year + 1,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            leaveToDate = val.toString();
                            leaveToDateNameCnt.text =
                                "${val.year}-${val.month}-${val.day}";
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  Future<void> _showDatePickerAndroidpostPonement(ctx) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        // confirmText: 'Confirm'

        // selectableDayPredicate: (DateTime x) {
        //   print(x);
        // },
        initialDatePickerMode: DatePickerMode.day);
    if (picked != null)
      setState(() {
        print(picked);
        receiptDate = picked.toString();
        receiptDate = receiptDateNameCnt.text;
      });
  }

  Future<void> _showDatePickerpostPonement(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumYear: DateTime.now().year,
                        maximumYear: DateTime.now().year + 1,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            receiptDate = val.toString();
                            receiptDateNameCnt.text =
                                "${val.year}-${val.month}-${val.day}";
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  Widget remarkAndAddressWidget() {
    switch (miscID) {
      case 114:
        return SizedBox();
        break;
      case 143:
        return SizedBox();
        break;
      case 6:
        return SizedBox();
        break;
      case 5:
        return SizedBox();
        break;
      case 1:
        return SizedBox();
        break;
      case 66:
        return SizedBox();
        break;
      case 31:
        return SizedBox();
        break;
      case 109:
        return SizedBox();
        break;
      case 139:
        return SizedBox();
        break;
      default:
        return Form(
          key: _remarkAndAddressForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Remarks',
                style: TextStyle(
                    color: isDark(context) ? Colors.white : Colors.black),
              ),
              TextFormField(
                validator: (x) => x.isEmpty ? "Please enter remark" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                // initialValue: widget.sessionId == null
                //     ? ''
                //     : widget.sessionInfo['remarks'],
                onSaved: (x) {
                  setState(() {
                    remark = x;
                  });
                  // sessionRemarks = x;
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 25,
              ),
              globalForms(
                context,
                '',
                (String value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter address to';
                  }
                  return null;
                },
                (x) {
                  setState(() {
                    addressTo = x;
                  });
                },
                'Address To',
                TextInputType.text,
              ),
            ],
          ),
        );
    }
  }

  Future<void> _showDatePickerAndroid(ctx) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        // confirmText: 'Confirm'

        // selectableDayPredicate: (DateTime x) {
        //   print(x);
        // },
        initialDatePickerMode: DatePickerMode.day);
    if (picked != null)
      setState(() {
        print(picked);
        passportDate = picked.toString();
        passportDate = passportDateNameCnt.text;
      });
  }

  Future<void> _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        minimumYear: DateTime.now().year,
                        maximumYear: DateTime.now().year + 1,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            passportDate = val.toString();
                            passportDateNameCnt.text =
                                "${val.year}-${val.month}-${val.day}";
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  Widget passportDetails() {
    if (miscID == 109) {
      return Form(
        key: _passportForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local Contact Person',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please enter local contact person" : null,

              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  localContactPerson = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Contact No',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter contact no" : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  contactNo = x;
                });
              },
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'International Contact Person',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty
                  ? "Please enter international contact person"
                  : null,

              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  internationalContactPerson = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'International Contact No',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please enter international contact no" : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onSaved: (x) {
                setState(() {
                  internationalContactNo = x;
                });
              },
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 25,
            ),

            Text(
              'Date to be Return',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (Platform.isIOS) {
                    _showDatePicker(context);
                  } else {
                    _showDatePickerAndroid(context);
                  }
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  validator: (x) =>
                      x.isEmpty ? "Please enter date to be return" : null,
                  onChanged: (x) {
                    setState(() {
                      // isEditing = true;
                    });
                  },
                  controller: passportDateNameCnt,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),

//TODO: Date Picker

            Text(
              'Reason',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,

              // initialValue: widget.sessionId == null
              //     ? ''
              //     : widget.sessionInfo['remarks'],
              onSaved: (x) {
                setState(() {
                  remark = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget reasonWidget() {
    switch (miscID) {
      case 139:
        return Form(
          key: _withdrawalForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reason',
                style: TextStyle(
                    color: isDark(context) ? Colors.white : Colors.black),
              ),
              TextFormField(
                validator: (x) => x.isEmpty ? "Please enter reason" : null,
                onSaved: (x) {
                  setState(() {
                    remark = x;
                  });
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        );
        break;

      default:
    }
    return SizedBox();
  }

  Widget amount() {
    if (requestAmountJson['success'] == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Normal Amount',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          IgnorePointer(
            child: AbsorbPointer(
              child: TextFormField(
                validator: (x) =>
                    x.isEmpty ? "Please select request type" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                controller: amountNameCnt,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget amountUrgent() {
    if (requestAmountJson['success'] == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Urgent Amount',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          IgnorePointer(
            child: AbsorbPointer(
              child: TextFormField(
                validator: (x) =>
                    x.isEmpty ? "Please select request type" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                controller: amountUrgentNameCnt,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget switchAmount() {
    if (requestAmountJson['success'] == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Request Type',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          // AnimatedToggle(
          //   values: ['Normal', 'Urgent'],
          //   onToggleCallback: (index) {
          //     // isDarkMode = !isDarkMode;
          //     setState(() {
          //       switch (initialIndex) {
          //         case 0:
          //           {
          //             setState(() {
          //               requestType = 'Normal';
          //             });
          //           }

          //           break;
          //         case 1:
          //           {
          //             setState(() {
          //               requestType = 'Urgent';
          //             });
          //           }
          //           break;
          //         default:
          //           {
          //             setState(() {
          //               requestType = 'Normal';
          //             });
          //           }
          //       }
          //     });
          //   },
          // ),

          ToggleSwitch(
            // minWidth: .0,
            minWidth: 100,
            minHeight: 40,

            icons: [Icons.star_outline, Icons.star_outline],
            initialLabelIndex: initialIndex,
            cornerRadius: 15.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            labels: ['Normal', 'Urgent'],
            // activeBgColor: [Colors.green, Colors.green],
            activeBgColors: [
              [Colors.green],
              [Colors.red],
            ],
            onToggle: (index) {
              print('switched to: $index');
              setState(() {
                initialIndex = index;
                switch (initialIndex) {
                  case 0:
                    {
                      setState(() {
                        requestType = 'Normal';
                      });
                    }

                    break;
                  case 1:
                    {
                      setState(() {
                        requestType = 'Urgent';
                      });
                    }
                    break;
                  default:
                    {
                      setState(() {
                        requestType = 'Normal';
                      });
                    }
                }
              });
            },
            totalSwitches: 2,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    } else if (requestAmountJson['success'] == '0' ||
        requestAmountJson == null ||
        requestAmountJson.isEmpty) {
      return SizedBox();
    }
  }

  Widget coursesReset() {
    if (miscID == 5) {
      return Form(
        key: _formReset,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courses',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    // shrinkWrap: true,
                    // shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: resitMarksJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // children: [
                        leading: Checkbox(
                          shape: CircleBorder(),
                          value: selectedResitCourses[index],
                          onChanged: (bool x) {
                            setState(() {
                              // x = resitList[index];
                              selectedResitCourses[index] = x;
                              print(selectedResitCourses);
                              // resitSelected = !resitSelected;
                            });
                          },
                          activeColor: Color(0xFF3773AC),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),

                        isThreeLine: true,

                        title: Text(
                          resitMarksJson[index]['CourseName'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resitMarksJson[index]['BatchCode'],
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              resitMarksJson[index]['CDD_Code'],
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        trailing: Text(
                          resitMarksJson[index]['Grade'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        // ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  remark = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 5) {
      return SizedBox();
    }
  }

  Widget coursesMitigation() {
    if (miscID == 6) {
      return Form(
        key: _formMitigation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courses',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    // shrinkWrap: true,
                    // shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: midMarksJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // children: [
                        leading: Checkbox(
                          shape: CircleBorder(),
                          value: selectedMitigationCourses[index],
                          onChanged: (bool x) {
                            setState(() {
                              // x = resitList[index];
                              selectedMitigationCourses[index] = x;
                              print(selectedMitigationCourses);
                              // resitSelected = !resitSelected;
                            });
                          },
                          activeColor: Color(0xFF3773AC),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),

                        isThreeLine: true,

                        title: Text(
                          midMarksJson[index]['CourseName'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              midMarksJson[index]['BatchCode'],
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              midMarksJson[index]['CDD_Code'],
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        trailing: Text(
                          midMarksJson[index]['AssessmentName'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        // ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 6) {
      return SizedBox();
    }
  }

  Widget cancellationVisa() {
    if (miscID == 114) {
      return Form(
        key: _formCancellationVisa,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visa Cancellation Type',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            DropDownFormField(
              required: true,
              // validator: (cancellationTypeID) => value.isEmpty ? "Please select type" : null,
              // titleText: '',
              hintText: 'Please choose one',
              value: cancellationTypeID,

              onChanged: (value) {
                setState(() {
                  cancellationTypeID = value;
                });
              },
              onSaved: (value) {
                setState(() {
                  cancellationTypeID = value;
                });
              },
              dataSource: cancellationTypeJson,
              textField: 'CancellationType',
              valueField: 'CancellationTypeID',
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason for Cancel',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  reasonCancellation = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 114) {
      return SizedBox();
    }
  }

  Widget postPonement() {
    if (miscID == 110) {
      return Form(
        key: _formPostponement,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visa Cancellation Type',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            // date
            Text(
              'Date to be Return',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (Platform.isIOS) {
                    _showDatePickerpostPonement(context);
                  } else {
                    _showDatePickerAndroidpostPonement(context);
                  }
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  validator: (x) =>
                      x.isEmpty ? "Please enter date to be return" : null,
                  onChanged: (x) {
                    setState(() {
                      // isEditing = true;
                    });
                  },
                  controller: passportDateNameCnt,
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            Text(
              'Receipt No',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter receipt no" : null,
              onSaved: (x) {
                setState(() {
                  receiptNo = x;
                });
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  reasonPostponement = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 110) {
      return SizedBox();
    }
  }

  Widget coursesRepeating() {
    if (miscID == 1) {
      return Form(
        key: _formRepaeating,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courses',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 5,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: courseRepaeatingJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // children: [
                        leading: Checkbox(
                          shape: CircleBorder(),
                          value: selectedCourseRepaeating[index],
                          onChanged: (bool x) {
                            setState(() {
                              // x = resitList[index];
                              selectedCourseRepaeating[index] = x;
                              print(selectedCourseRepaeating);
                              // resitSelected = !resitSelected;
                            });
                          },
                          activeColor: Color(0xFF3773AC),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),

                        title: Text(
                          courseRepaeatingJson[index]['Cdd_Description']
                              .toString(),
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              courseRepaeatingJson[index]['Cdd_Code']
                                  .toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('/'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              courseRepaeatingJson[index]['Cdd_ID'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),

                        // trailing:
                        //     Text(courseWithdrawalJson[index]['Cdd_ID'].toString()),
                        // ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  remark = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 1) {
      return SizedBox();
    }
  }

  Widget coursesWithDrawal() {
    if (miscID == 139) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Courses',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  // shrinkWrap: true,
                  // shrinkWrap: true,
                  physics: ScrollPhysics(),
                  // physics: ScrollPhysics(),
                  itemCount: courseWithdrawalJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      // children: [
                      leading: Checkbox(
                        shape: CircleBorder(),
                        value: selectedCourseWithdrawals[index],
                        onChanged: (bool x) {
                          setState(() {
                            // x = resitList[index];
                            selectedCourseWithdrawals[index] = x;
                            print(selectedCourseWithdrawals);
                            // resitSelected = !resitSelected;
                          });
                        },
                        activeColor: Color(0xFF3773AC),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),

                      title: Text(
                        courseWithdrawalJson[index]['Cdd_Description']
                            .toString(),
                        style: TextStyle(
                            color:
                                isDark(context) ? Colors.white : Colors.black),
                      ),
                      isThreeLine: true,
                      subtitle: Text(
                        courseWithdrawalJson[index]['Cdd_Code'].toString(),
                        style: TextStyle(
                            color:
                                isDark(context) ? Colors.white : Colors.black),
                      ),
                      // trailing:
                      //     Text(courseWithdrawalJson[index]['Cdd_ID'].toString()),
                      // ],
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      );
    } else if (miscID != 139) {
      return SizedBox();
    }
  }

  Widget coursesAgains() {
    if (miscID == 143) {
      return Form(
        key: _formAgains,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courses',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    // shrinkWrap: true,
                    // shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: againstMarksJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Checkbox(
                          shape: CircleBorder(),
                          value: selectedAgainsMarks[index],
                          onChanged: (bool x) {
                            setState(() {
                              // x = resitList[index];
                              selectedAgainsMarks[index] = x;
                              print(selectedAgainsMarks);
                              // resitSelected = !resitSelected;
                            });
                          },
                          activeColor: Color(0xFF3773AC),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        ),
                        isThreeLine: true,
                        title: Text(
                          againstMarksJson[index]['CourseName'].toString(),
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              againstMarksJson[index]['BatchCode'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              againstMarksJson[index]['CDD_Code'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        trailing: Text(
                          againstMarksJson[index]['Grade'].toString(),
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Reason',
              style: TextStyle(
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            TextFormField(
              validator: (x) => x.isEmpty ? "Please enter reason" : null,
              onSaved: (x) {
                setState(() {
                  remark = x;
                });
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    } else if (miscID != 143) {
      return SizedBox();
    }
  }

  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/OnlineRequestFees'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'MiscID': miscID.toString(),
          'Stud_ID': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);

            amountNameCnt.text =
                requestAmountJson['data'] == null || requestAmountJson.isEmpty
                    ? ''
                    : requestAmountJson['data']['NormalFees'] == ("NA")
                        ? "Not Avalible"
                        : requestAmountJson['data']['NormalFees'].toString();

            amountUrgentNameCnt.text =
                requestAmountJson['data'] == null || requestAmountJson.isEmpty
                    ? ''
                    : requestAmountJson['data']['UrgentFees'] == ("NA")
                        ? "Not Avalible"
                        : requestAmountJson['data']['UrgentFees'].toString();
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

  Future insertRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/InsertRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudentID': username,
          // username,
          'RequestTypeid': miscID.toString(),
          'RequestType': requestType,
          'Remarks': remark.toString(),
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            insertRequestJson = json.decode(response.body);
            showLoading(false, context);
          },
        );
      }
    } catch (x) {
      print(x);
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

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/onlineRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'RequestTypeid': miscID.toString(),
          'RequestType': requestType,
          'AddressTo': addressTo,
          'Remarks': remark,
          'StudentID': username,
          // username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestJson = json.decode(response.body);
          },
        );
      }
      if (onlineRequestJson['success'] == "1") {
        showLoading(false, context);
        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
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

  // // Future getCheckRequest() async {
  // //   Future.delayed(Duration.zero, () {
  // //     showLoading(true, context);
  // //   });

  // //   try {
  // //     final response = await http.post(
  // //       Uri.parse(
  // //           'https://skylineportal.com/moappad/api/test/CheckRequest'),
  // //       headers: {
  // //         "API-KEY": API,
  // //       },
  // //       body: {
  // //         'RequestTypeid': requestId,
  // //         'StudentID': username,
  // //       },
  // //     );

  // //     if (response.statusCode == 200) {
  // //       setState(
  // //         () {
  // //           checkRequestJson = json.decode(response.body)['data'];
  // //           checkRequestMessageJson = json.decode(response.body);
  // //         },
  // //       );
  // //       showLoading(false, context);
  // //     }
  // //   } catch (x) {
  // //     if (x.toString().contains("TimeoutException")) {
  // //       showLoading(false, context);
  // //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  // //           context, getRequestType);
  // //     } else {
  // //       showLoading(false, context);
  // //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  // //           getRequestType);
  // //     }
  // //   }
  // // }

  Future getCourseWithdrawal() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedCourseWithdrawals = [];
      courseWithdrawalJson = [];
      final response = await http.post(
        Uri.parse(
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

            for (int i = 0; i < courseWithdrawalJson.length; i++) {
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
            context, getCourseWithdrawal);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseWithdrawal);
      }
    }
  }

  Future insertWithdrawalMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();
    int i = -1;

    selectedCourseWithdrawals.forEach((selectedCourseWithdrawals) async {
      i++;

      if (selectedCourseWithdrawals) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://skylineportal.com/moappad/api/test/InsertWithdrawalCourses'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              //  username,
              'RequestTypeID': miscID.toString(),
              // 'CDD_ID': courseWithdrawalJson[i]['CDD_ID'],
              'CourseCode': courseWithdrawalJson[i]['Cdd_Code'],
              'CourseTitle': courseWithdrawalJson[i]['Cdd_Description'],
              'Remarks': remark,
              'RequestDate': date.toString()
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            showLoading(false, context);
            bottomSheetSuccess(context);
          } else {
            showLoading(false, context);
            bottomSheetFailure(context);
          }
        } catch (x) {
          print(x);
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertWithdrawalMarks);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertWithdrawalMarks);
          }
        }
      }
    });
    showLoading(false, context);
  }

  // //
  Future insertLeaveApplication() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/InsertLeaveApplications'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'LeaveFrom': leaveFromDateNameCnt.text.toString(),
          'LeaveTo': leaveToDateNameCnt.text.toString(),
          'LeaveContactNo': residenceContactNo.toString(),
          'RequestTypeID': miscID.toString(),
          'Student_Id': username,
          // username,
          'LeaveDocAttached': documentSubmitted.toString(),
          'LeaveContactAddress': contactAddress.toString(),
          'AddressTo': addressToLeave.toString(),
          'StudRemarks': reasonLeave.toString(),
          'LeaveMobile': mobileContactNo.toString(),
        },
      );

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
      }
      // showLoading(false, context);

      // showfailureSnackBar(context,
      //     'Your request submitted failed. Please contact IT department');
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

  Future getCancellationVisaType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/CancellationVisaType'),
        headers: {
          "API-KEY": API,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            cancellationTypeJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCancellationVisaType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCancellationVisaType);
      }
    }
  }

  Future getShiftTime() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
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
            newShiftTimesJson = json.decode(response.body)['data']['shifts'];
            currentShiftTimesJson =
                json.decode(response.body)['data']['current_shift'];
            currentShiftNameCnt.text = currentShiftTimesJson['Shift_Desc'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getShiftTime);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getShiftTime);
      }
    }
  }

  Future insertShiftChange() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/InsertShiftChange'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'ClassShiftChangeFrom': currentShiftTimesJson['Shift_Desc'],
          'ClassShiftChangeTo': _selectedShift.toString(),
          'RequestTypeId': miscID.toString(),
          'RequestType': requestType,
          'Student_Id': username,
          // username,
          'AddressTo': addressToShift,
          'StudRemarks': reasonShift,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
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
    // if (insertShiftChangeJson['success'] == '1') {
    //   showfailureSnackBar(context, insertShiftChangeJson['message']);
    // }
    // if (insertShiftChangeJson['success'] == '0') {
    //   showSuccessSnackBar(context, insertShiftChangeJson['message']);
    // }
  }

  Future getCourseRepeating() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedCourseRepaeating = [];
      courseRepaeatingJson = [];
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/RepaeatingMarksCourses'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': '15349',
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            courseRepaeatingJson = json.decode(response.body)['data'];

            for (int i = 0; i < courseRepaeatingJson.length; i++) {
              selectedCourseRepaeating.add(false);
            }
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourseRepeating);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseRepeating);
      }
    }
  }

  Future insertCourseRepaeating() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();

    int i = -1;

    selectedCourseRepaeating.forEach((selectedCourseRepaeating) async {
      i++;
      if (selectedCourseRepaeating) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://skylineportal.com/moappad/api/test/InsertRepaeatingCoursess'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': miscID.toString(),
              'CDD_ID': courseRepaeatingJson[i]['Cdd_ID'].toString(),
              'CourseCode': courseRepaeatingJson[i]['Cdd_Code'].toString(),
              'CourseTitle':
                  courseRepaeatingJson[i]['Cdd_Description'].toString(),
              'Remarks': remark,
              'RequestDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));

          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');
          if (response.statusCode == 200) {
            showLoading(false, context);
            bottomSheetSuccess(context);
          }

          //   showLoading(false, context);
          //   bottomSheetSuccess(context);
          // }
          else {
            showLoading(false, context);
            bottomSheetFailure(context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertCourseRepaeating);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertCourseRepaeating);
          }
        }
      }
    });

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
        Uri.parse(
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
            context, getAgainstMarks);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAgainstMarks);
      }
    }
  }

  Future insertAgainsMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();

    int i = -1;

    selectedAgainsMarks.forEach((selectedAgainsMark) async {
      i++;
      if (selectedAgainsMark) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://skylineportal.com/moappad/api/test/InsertAgainstMarks'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              // username,
              'RequestTypeID': miscID.toString(),
              'Batch_ID': againstMarksJson[i]['Batch_ID'].toString(),
              'CDD_ID': againstMarksJson[i]['CDD_ID'].toString(),
              'CourseCode': againstMarksJson[i]['CDD_Code'].toString(),
              'CourseTitle': againstMarksJson[i]['CourseName'].toString(),
              'Grade': againstMarksJson[i]['Grade'].toString(),
              'Remarks': remark.toString(),
              'RequestDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));

          // showLoading(false, context);

          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');

          if (response.statusCode == 200) {
            showLoading(false, context);
            bottomSheetSuccess(context);
          }

          //   showLoading(false, context);
          //   bottomSheetSuccess(context);
          // }
          else {
            showLoading(false, context);
            bottomSheetFailure(context);
          }
        } catch (x) {
          print(x);
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
    });

    //send confirmation
  }

  Future insertMitigation() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();

    int i = -1;

    selectedMitigationCourses.forEach((selectedMitigationCourse) async {
      i++;
      if (selectedMitigationCourse) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://skylineportal.com/moappad/api/test/InsertMitigationExam'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              // username,
              'RequestTypeID': miscID.toString(),
              'AssessmentName': midMarksJson[i]['AssessmentName'].toString(),
              'Batch_ID': midMarksJson[i]['Batch_ID'].toString(),
              'CDD_ID': midMarksJson[i]['CDD_ID'].toString(),
              'CourseCode': midMarksJson[i]['CDD_Code'].toString(),
              'CourseTitle': midMarksJson[i]['CourseName'].toString(),
              'DateOfAssessment': date.toString(),
              'RequestDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));

          if (response.statusCode == 200) {
            showLoading(false, context);
            bottomSheetSuccess(context);
          }

          //   showLoading(false, context);
          //   bottomSheetSuccess(context);
          // }
          else {
            showLoading(false, context);
            bottomSheetFailure(context);
          }
        } catch (x) {
          print(x);
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
    });

    // showLoading(false, context);
    // if (insertMitigationJson['success'] == '0') {
    //   showfailureSnackBar(context, insertMitigationJson['message']);
    // }
    // if (insertMitigationJson['success'] == '1') {
    //   showSuccessSnackBar(context, insertMitigationJson['message']);
    // }
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
        Uri.parse(
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
            context, getResitMarksCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getResitMarksCourses);
      }
    }
  }

  Future insertResitOrGradeImprovement() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();

    int i = -1;

    selectedResitCourses.forEach((selectedResitCourse) async {
      i++;
      if (selectedResitCourse) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://skylineportal.com/moappad/api/test/insertResitOrGradeImprovementss'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'RequestTypeID': miscID.toString(),
              'Remarks': remark.toString(),
              'Grade': resitMarksJson[i]['Grade'],
              'CourseTitle': resitMarksJson[i]['CourseName'],
              'CourseCode': resitMarksJson[i]['CDD_Code'],
              'CDD_ID': resitMarksJson[i]['CDD_ID'].toString(),
              'Batch_ID': resitMarksJson[i]['Batch_ID'].toString(),
              'RequestDate': date.toString()
            },
          ).timeout(Duration(seconds: 35));
          print(resitMarksJson[i]['CourseName']);
          // showLoading(false, context);

          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');
          if (response.statusCode == 200) {
            showLoading(false, context);
            bottomSheetSuccess(context);
          }

          //   showLoading(false, context);
          //   bottomSheetSuccess(context);
          // }
          else {
            showLoading(false, context);
            bottomSheetFailure(context);
          }
        } catch (x) {
          print(x);
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
    });
    // if (insertResitMarksJson['success'] == '0') {
    //   showfailureSnackBar(context, insertResitMarksJson['message']);
    // }
    // if (insertResitMarksJson['success'] == '1') {
    //   showSuccessSnackBar(context, insertResitMarksJson['message']);
    // }
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
        Uri.parse('https://skylineportal.com/moappad/api/test/MidMarksCourses'),
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
            context, getMidMarksCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getMidMarksCourses);
      }
    }
  }

  Future insertStudentPassport() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    await insertRequest();

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/passportWithdrawal'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          // username,
          'LocalPersonName': localContactPerson,
          'LocalMobileNo': contactNo.toString(),
          'InternationalPersonName': internationalContactPerson,
          'InternationalMobileNo': internationalContactNo.toString(),
          'ReturnDate': passportDate.toString(),
          'RequestTypeid': miscID.toString(),
          'Reason': remark.toString(),
          'RequestDate': date.toString()
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
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

  Future inserPostponement() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/InserPostponement'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudentID': username,
          // username,
          'RequestTypeid': miscID.toString(),
          'RequestType': requestType.toString(),

          'ReceiptDate': receiptDate.toString(),
          'ReceiptNo': receiptNo.toString(),
          'Remarks': reasonPostponement.toString(),
          // 'RequestDate': date.toString()
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
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

  Future insertVisaCancellation() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/InserVisaCancellation'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudentID': username,
          // username,
          'RequestTypeid': miscID.toString(),
          'RequestType': requestType.toString(),

          'CancellationType': cancellationTypeID.toString(),

          'Remarks': reasonCancellation,
          // 'RequestDate': date.toString()
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
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
}
