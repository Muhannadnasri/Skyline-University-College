import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(LeaveHoliday());

class LeaveHoliday extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaveHolidayState();
  }
}

final _addressLeave = GlobalKey<FormState>();
final _reasonTravel = GlobalKey<FormState>();
final _eName = GlobalKey<FormState>();
final _eEmail = GlobalKey<FormState>();
final _eRelationship = GlobalKey<FormState>();
final _eMobile = GlobalKey<FormState>();
final _eResidence = GlobalKey<FormState>();
final _eOffice = GlobalKey<FormState>();
final _eAddress = GlobalKey<FormState>();

// Map<String, int> body;

class _LeaveHolidayState extends State<LeaveHoliday> {
  Map leaveHolidayJson = {};

  String addressLeave = '';
  String reasonTravel = '';
  String eName = '';
  String eEmail = '';
  String eRelationship = '';

  String eMobile = '';
  String eResidence = '';
  String eOffice = '';
  String eAddress = '';
  int groupValue;
  String leaveType;
  String _dateTimeLeave = '';
  String _dateTimeReturn = '';
  int _year = 2018;
  int _month = 11;
  int _date = 11;

  @override
  void initState() {
    super.initState();

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
      appBar: appBarLogin(context, 'Permission To Leave'),
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
                  //TODO: From and TO
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDateLeave();
                        },
                        child: Container(
                          height: 60,
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: Colors.purple,
                                    size: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(_dateTimeLeave == ''
                                    ? 'Leave From'
                                    : _dateTimeLeave == null
                                        ? 'Leave From'
                                        : _dateTimeLeave),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDateReturn();
                        },
                        child: Container(
                          height: 60,
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: Colors.purple,
                                    size: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(_dateTimeReturn == ''
                                    ? 'Leave From'
                                    : _dateTimeReturn == null
                                        ? 'Leave From'
                                        : _dateTimeReturn),
                              ],
                            ),
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
                        key: _addressLeave,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              onSaved: (x) {
                                addressLeave = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Address",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Your Address while on leave',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //TODO: Space with text

                      Form(
                        key: _reasonTravel,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              onSaved: (x) {
                                reasonTravel = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Reason",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Reason for travel',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.question,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        color: Colors.red,
                        width: 300,
                      ),
                      Form(
                        key: _eName,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eName = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Name to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.user,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eEmail,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eEmail = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Email to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.envelopeOpen,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eRelationship,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eRelationship = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Relationship",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Your relationship with person',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.users,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eMobile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eMobile = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Mobile",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter mobile number to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.mobileAlt,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eResidence,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eResidence = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Residence No",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Residence No to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.building,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eOffice,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eOffice = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Office No",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Office No to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.briefcase,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _eAddress,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                eAddress = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Address",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText:
                                    'Please Enter Address to be contacted in case of emergency',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
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
                            getLeaveHoliday();
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

  void _showError(String msg, IconData icon) {
    showLoading(false, context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset(
                'images/logo.png',
                height: 50,
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getLeaveHoliday();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

//TODO: RequestType

  Future getLeaveHoliday() async {
    if (_addressLeave.currentState.validate()) {
      _addressLeave.currentState.save();
    }
    if (_reasonTravel.currentState.validate()) {
      _reasonTravel.currentState.save();
    }
    if (_eName.currentState.validate()) {
      _eName.currentState.save();
    }
    if (_eEmail.currentState.validate()) {
      _eEmail.currentState.save();
    }
    if (_eRelationship.currentState.validate()) {
      _eRelationship.currentState.save();
    }
    if (_eMobile.currentState.validate()) {
      _eMobile.currentState.save();
    }
    if (_eResidence.currentState.validate()) {
      _eResidence.currentState.save();
    }
    if (_eOffice.currentState.validate()) {
      _eOffice.currentState.save();
    }
    if (_eAddress.currentState.validate()) {
      _eAddress.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/leaveDuringHolidays'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'from': _dateTimeLeave.toString(),
          'to': _dateTimeReturn.toString(),
          'address_to': addressLeave,
          'reason': reasonTravel,
          'name': eName,
          'email': eEmail,
          'relationship': eRelationship,
          'mobile_no': eMobile,
          'residance_no': eResidence,
          'office_no': eOffice,
          'address': eAddress,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveHolidayJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (leaveHolidayJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: leaveHolidayJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }
}
