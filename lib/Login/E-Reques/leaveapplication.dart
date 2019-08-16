import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(LeaveApplication());

class LeaveApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaveApplicationState();
  }
}

final _rNumber = GlobalKey<FormState>();
final _mobile = GlobalKey<FormState>();

final _document = GlobalKey<FormState>();

final _address = GlobalKey<FormState>();

final _reasonLeave = GlobalKey<FormState>();

// Map<String, int> body;

class _LeaveApplicationState extends State<LeaveApplication> {
  List leaveTypesJson = [];
  Map leaveApplicationJson = {};
  Map leaveBalanceJson = {};

  int groupValue;
  String leaveType;
  String _dateTimeLeave = '';
  String _dateTimeReturn = '';
  int _year = 2018;
  int _month = 11;
  int _date = 11;
  String contactNo = '';
  String mobileNo = '';
  String documentSubmitted = '';
  String addressTo = '';
  String reasonLeave = '';

  @override
  void initState() {
    super.initState();
    getLeaveTypes();
    leaveBalanceJson.clear();

    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
  }

  void _showDateLeave() {
    DateTime now = DateTime.now();

    DatePicker.showDatePicker(
      context,
      minYear: now.year,
      initialYear: now.year,
      initialMonth: now.month,
      initialDate: _date,
      confirm: Text(
        'Confirm',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'Cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: 'EN',
      dateFormat: 'dd-mm-yyyy',
      onConfirm: (year, month, date) {
        _changeDateLeave(year, month, date);
      },
    );
  }

  void _showDateReturn() {
    DateTime now = DateTime.now();
    DatePicker.showDatePicker(
      context,
      minYear: now.year,
      initialYear: now.year,
      initialMonth: now.month,
      initialDate: _date,
      confirm: Text(
        'Confirm',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'Cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: 'en',
      dateFormat: 'dd-mm-yyyy',
      onConfirm: (year, month, date) {
        _changeDateReturn(year, month, date);
      },
    );
  }

  void _changeDateLeave(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dateTimeLeave = '$year-$month-$date';
    });
  }

  void _changeDateReturn(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dateTimeReturn = '$year-$month-$date';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true, //TODO: put in all page
      appBar: appBarLogin(context, 'Leave Application'),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),

                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Leave Type',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Option',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        isExpanded: true,
                        value: leaveType,
                        items: leaveTypesJson
                                ?.map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item['leaveid'].toString(),
                                    child: Text(item['leavetype'].toString()),
                                  ),
                                )
                                ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            leaveType = value;
                            getLeaveBalance();
                          });
                        },
                      ),
                    ],
                  ),

                  //TODO: From and TO
                  Column(
                    children: <Widget>[
                      Text(leaveBalanceJson.isEmpty
                          ? ''
                          : leaveBalanceJson['Bal'] == null
                              ? ' '.toString()
                              : leaveBalanceJson['Bal'].toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.lightBlueAccent,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Leave From'),
                              ))),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDateLeave();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  _dateTimeLeave == ''
                                      ? 'DD-MM-YY'
                                      : _dateTimeLeave,
                                ),
                              ),
                              Icon(Icons.date_range),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.lightBlueAccent,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Leave To'),
                              ))),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDateReturn();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  _dateTimeReturn == ''
                                      ? 'DD-MM-YY'
                                      : _dateTimeReturn,
                                ),
                              ),
                              Icon(Icons.date_range),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _rNumber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                onSaved: (x) {
                                  contactNo = x;
                                },
                                decoration: InputDecoration(
                                  labelText: "Contact No in UAE",
                                  fillColor: Colors.white,
                                  helperText: '(Required)',
                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Enter Your Contact Number i UAE',
                                  hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.mobileAlt,
                                    size: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Mobile Number'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _mobile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                onSaved: (x) {
                                  mobileNo = x;
                                },
                                decoration: InputDecoration(
                                  labelText: "Company and address",
                                  fillColor: Colors.white,
                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText:
                                      'Please enter your company and address',
                                  hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Document Submitted'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _document,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  documentSubmitted = x;
                                },
                                decoration: InputDecoration(
                                  labelText: "Company and address",
                                  fillColor: Colors.white,
                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText:
                                      'Please enter your company and address',
                                  hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Address To'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _address,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  addressTo = x;
                                },
                                decoration: InputDecoration(
                                  labelText: "Company and address",
                                  fillColor: Colors.white,
                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText:
                                      'Please enter your company and address',
                                  hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Reason For Leave'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _reasonLeave,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  reasonLeave = x;
                                },
                                decoration: InputDecoration(
                                  labelText: "Company and address",
                                  fillColor: Colors.white,
                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText:
                                      'Please enter your company and address',
                                  hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: 15,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 35,
                      width: 80,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
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
                      child: GestureDetector(
                          onTap: () {
                            getLeaveApplication();
                          },
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TODO: RequestType
  Future getLeaveTypes() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLeaveTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveTypesJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveTypes);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveTypes);
      }
    }
  }

  Future getLeaveApplication() async {
    if (_rNumber.currentState.validate()) {
      _rNumber.currentState.save();
    }
    if (_mobile.currentState.validate()) {
      _mobile.currentState.save();
    }
    if (_document.currentState.validate()) {
      _document.currentState.save();
    }
    if (_address.currentState.validate()) {
      _address.currentState.save();
    }
    if (_reasonLeave.currentState.validate()) {
      _reasonLeave.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/leaveApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'from': _dateTimeLeave.toString(),
          'to': _dateTimeReturn.toString(),
          'contact_no': contactNo,
          'mobile_no': mobileNo,
          'document_submitted': documentSubmitted,
          'address_to': addressTo,
          'reason': reasonLeave,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveApplicationJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (leaveApplicationJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: leaveApplicationJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveApplication);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveApplication);
      }
    }
  }

  Future getLeaveBalance() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLeaveTypeBalance'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'leave_type': leaveType,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveBalanceJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLeaveBalance);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLeaveBalance);
      }
    }
  }
}
