import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

void main() => runApp(AdmissionForm());

class AdmissionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdmissionFormState();
  }
}

final _fname = GlobalKey<FormState>();
final _mName = GlobalKey<FormState>();
final _lname = GlobalKey<FormState>();
final _pbox = GlobalKey<FormState>();
final _ptown = GlobalKey<FormState>();
final _pstate = GlobalKey<FormState>();

final _ppost = GlobalKey<FormState>();
final _ptel = GlobalKey<FormState>();
final _pmobile = GlobalKey<FormState>();
final _hbox = GlobalKey<FormState>();
final _htown = GlobalKey<FormState>();
final _hstate = GlobalKey<FormState>();
final _hpost = GlobalKey<FormState>();
final _htel = GlobalKey<FormState>();
final _hmobile = GlobalKey<FormState>();
final _hemail = GlobalKey<FormState>();
final _q1school = GlobalKey<FormState>();
final _q1duration = GlobalKey<FormState>();
final _q1result = GlobalKey<FormState>();
final _q2school = GlobalKey<FormState>();
final _q2duration = GlobalKey<FormState>();
final _q2result = GlobalKey<FormState>();
final _q3school = GlobalKey<FormState>();
final _q3duration = GlobalKey<FormState>();
final _q3result = GlobalKey<FormState>();
final _q4school = GlobalKey<FormState>();
final _q4duration = GlobalKey<FormState>();
final _q4result = GlobalKey<FormState>();

final _year = GlobalKey<FormState>();
final _overall = GlobalKey<FormState>();
final _e1time = GlobalKey<FormState>();
final _e1name = GlobalKey<FormState>();
final _e1location = GlobalKey<FormState>();
final _e1position = GlobalKey<FormState>();
final _e2time = GlobalKey<FormState>();
final _e2name = GlobalKey<FormState>();
final _e2location = GlobalKey<FormState>();
final _e2position = GlobalKey<FormState>();
final _aname = GlobalKey<FormState>();

// Map<String, int> body;

class _AdmissionFormState extends State<AdmissionForm> {
  String _gender;
  String _title;
  String _visa;
  String _hostel;
  String _cCountry;
  String _hCountry;
  String _nationality;
  String _pCountry;
  String _bCountry;
  String _liveOutside;

  String _1Program;
  String _1cName;

  String _2Program;

  String _2cName;
  String _dDate;
  String _online;
  String _sat;
  String _bDate;

  String _1q;
  String _1qCountry;
  String _1qDate = '';

  String _2q;
  String _2qCountry;
  String _2qDate = '';

  String _3q;
  String _3qCountry;
  String _3qDate = '';

  String _4q;
  String _4qCountry;
  String _4qDate = '';

  String _test;

  String _1eFDate = '';
  String _1eTdate = '';

  String _2eFDate = '';
  String _2eTdate = '';
  int _years = 2018;
  int _month = 11;
  int _date = 11;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    _years = now.year;
    _month = now.month;
    _date = now.day;

    getAdmissionFormDropdownRecords();
  }

  void _showDateBirth() {
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
        _changeDateBirth(year, month, date);
      },
    );
  }

  void _showDateCompleted1() {
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
        _changeDateCompleted1(year, month, date);
      },
    );
  }

  void _showDateCompleted2() {
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
        _changeDateCompleted2(year, month, date);
      },
    );
  }

  void _showDateCompleted3() {
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
        _changeDateCompleted3(year, month, date);
      },
    );
  }

  void _showDateCompleted4() {
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
        _changeDateCompleted4(year, month, date);
      },
    );
  }

  void _showDateEmployementFrom1() {
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
        _changeDateEmployementFrom1(year, month, date);
      },
    );
  }

  void _showDateEmployementTo1() {
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
        _changeDateEmployementTo1(year, month, date);
      },
    );
  }

  void _showDateEmployementFrom2() {
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
        _changeDateEmployementFrom2(year, month, date);
      },
    );
  }

  void _showDateEmployementTo2() {
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
        _changeDateEmployementTo2(year, month, date);
      },
    );
  }

  void _changeDateBirth(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _bDate = '$year-$month-$date';
    });
  }

  void _changeDateCompleted1(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _1qDate = '$year-$month-$date';
    });
  }

  void _changeDateCompleted2(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _2qDate = '$year-$month-$date';
    });
  }

  void _changeDateCompleted3(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _3qDate = '$year-$month-$date';
    });
  }

  void _changeDateCompleted4(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _4qDate = '$year-$month-$date';
    });
  }

  void _changeDateEmployementFrom1(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _1eFDate = '$year-$month-$date';
    });
  }

  void _changeDateEmployementTo1(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _1eTdate = '$year-$month-$date';
    });
  }

  void _changeDateEmployementFrom2(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _2eFDate = '$year-$month-$date';
    });
  }

  void _changeDateEmployementTo2(int year, int month, int date) {
    setState(() {
      _years = year;
      _month = month;
      _date = date;
      _2eTdate = '$year-$month-$date';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
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
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Admission",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.home,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Colors.grey[300],
              child: Column(
                children: <Widget>[
                  // todo: Personal Details

                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
//TODO: Title
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Title',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                )),
                            DropdownButton<String>(
                              value: _title,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Relations',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: <String>[
                                    'Mr',
                                    'Mrs',
                                    'Ms',
                                    'Miss',
                                    'Other'
                                  ]
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _title = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
//TODO: Gender
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Gender',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _gender,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Your Gender',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: <String>['Male', 'Female']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Form(
                          key: _fname,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pFName = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your First Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.user,
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

                        Form(
                          key: _mName,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pMName = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Middle Name",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Middle Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.user,
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
                        Form(
                          key: _lname,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pLName = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Last Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.user,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

//TODO: here date of birth //
                        GestureDetector(
                          onTap: () {
                            _showDateBirth();
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
                                  Text(_bDate == ''
                                      ? 'Date Of Birth'
                                      : _bDate == null
                                          ? 'Date Of Birth'
                                          : _bDate),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

//TODO: Visa
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Visa',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _visa,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Select Option',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              items: <String>['Yes', 'No']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _visa = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
//TODO: Hostel
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Hostel',
                                    style: TextStyle(color: Colors.grey[600])),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _hostel,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Select Option',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              items: <String>['Yes', 'No']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _hostel = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _pbox,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pBox = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "PO Box",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your PO Box',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.box,
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
                        Form(
                          key: _ptown,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pTown = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Town",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Town Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.building,
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
                        Form(
                          key: _pstate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pState = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "State",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your State Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.building,
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
                        Form(
                          key: _ppost,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  keyboardType: TextInputType.number,
                                  onSaved: (x) {
                                    pPost = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Post Code",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Post Code',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.searchLocation,
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
//TODO: Country
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Country',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                )),
                            DropdownButton<String>(
                              value: _cCountry,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Select Option',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['country']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _cCountry = value;
                                  print(_cCountry);
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _ptel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pTel = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Telephone",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText:
                                        'Please Enter Your Telephone Number',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.phone,
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
                        Form(
                          key: _pmobile,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  onSaved: (x) {
                                    pMobile = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Mobile",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Mobile Number',
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
                        Container(
                          height: 40,
                          width: 300,
                          color: Colors.red,
                          child: Center(child: Text('Home Address')),
                        ),
//TODO : home address
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _hbox,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hBox = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "PO Box",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your PO Box',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.box,
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
                        Form(
                          key: _htown,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hTown = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Town",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Town Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.building,
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
                        Form(
                          key: _hstate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hState = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "State",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your State Name',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.building,
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
                        Form(
                          key: _hpost,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hState = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Post Code",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText:
                                        'Please Enter Your Post Code Number',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.searchLocation,
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
//todo: country
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Country',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                )),
                            DropdownButton<String>(
                              value: _hCountry,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Select Option',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['country']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _hCountry = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _htel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hTel = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Telephone",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Home Telephone ',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.phone,
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
                        Form(
                          key: _hmobile,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hMobile = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Mobile",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText:
                                        'Please Enter Home Mobile Number ',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _hemail,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: null,
                                  onSaved: (x) {
                                    hEmail = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Email',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.envelopeOpen,
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

                        //todo: Nationality
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Nationality',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _nationality,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownCountriesJson
                                      ?.map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['country']),
                                          ),
                                        ),
                                      )
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _nationality = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //TODO: Country Permanent
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Country',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _pCountry,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                item['Country'].toString()),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _pCountry = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //TODO: Birth Country
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Country of Birthday',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _bCountry,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['country']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _bCountry = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //TODO: live outside
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Are you an international student living outside the UAE?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _liveOutside,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: <String>['Yes', 'No']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _liveOutside = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  // TODO: Program

                  Container(
                    height: 40,
                    width: 300,
                    color: Colors.red,
                    child: Center(
                      child: Text('Program Preference'),
                    ),
                  ),

                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '1st Program',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _1Program,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownProgramJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['program']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _1Program = value;
                                  getProgramsByCategory1();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Course Name',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _1cName,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: programsByCategory1Json
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['name']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _1cName = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '2st Program',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _2Program,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownProgramJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['program'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _2Program = value;
                                  getProgramsByCategory2();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Course Name',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _2cName,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: programsByCategory2Json
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['name']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _2cName = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'When do you which to begin your degree ?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _dDate,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: admissionFormDropdownTermsJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item['term']),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _dDate = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 40,
                    width: 300,
                    color: Colors.red,
                    child: Center(
                      child: Text('Acadamic background'),
                    ),
                  ),

                  //TODO: Acadamic background
                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),

                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Have you completed any studies through distance or online learning ? ',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _online,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: <String>['Yes', 'No']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _online = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Have you underwent SAT exam ?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _sat,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Option',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: <String>['Yes', 'No']
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item),
                                          )))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _sat = value;
                                });
                              },
                            ),
                          ],
                        ),
                        //TODO: qualification 1

                        SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Qualification',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: _1q,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items:
                                        admissionFormDropdownQualificationJson
                                                ?.map((item) =>
                                                    DropdownMenuItem<String>(
                                                        value: item['id']
                                                            .toString(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(item[
                                                              'qualification']),
                                                        )))
                                                ?.toList() ??
                                            [],
                                    onChanged: (value) {
                                      setState(() {
                                        _1q = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Country',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: _1qCountry,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Select Option',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: admissionFormDropdownCountriesJson
                                            ?.map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item['id'].toString(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(item['country']),
                                                )))
                                            ?.toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        _1qCountry = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Form(
                          key: _q1school,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q1School = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Form(
                          key: _q1duration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q1Duration = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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

                        Form(
                          key: _q1result,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q1Result = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TODO: qualification 2

                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Qualification'),
                            DropdownButton<String>(
                              value: _2q,
                              isExpanded: true,
                              hint: Text('Facility'),
                              items: admissionFormDropdownQualificationJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['qualification'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _2q = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Country'),
                            DropdownButton<String>(
                              value: _2qCountry,
                              isExpanded: true,
                              hint: Text('Select Option'),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['country'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _2qCountry = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Form(
                          key: _q2school,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q2School = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Form(
                          key: _q2duration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q2Duration = x;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Reason',
                                    border: InputBorder.none,
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
                          key: _q2result,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q2Result = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TODO: qualification 3

                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Qualification'),
                            DropdownButton<String>(
                              value: _3q,
                              isExpanded: true,
                              hint: Text('Select Option'),
                              items: admissionFormDropdownQualificationJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['qualification'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _3q = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Country'),
                            DropdownButton<String>(
                              value: _3qCountry,
                              isExpanded: true,
                              hint: Text('Select Option'),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['country'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _3qCountry = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Form(
                          key: _q3school,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q3School = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Form(
                          key: _q3duration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q3Duration = x;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Reason',
                                    border: InputBorder.none,
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
                          key: _q3result,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q3Result = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TODO: qualification 4

                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Qualification'),
                            DropdownButton<String>(
                              value: _4q,
                              isExpanded: true,
                              hint: Text('Select Option'),
                              items: admissionFormDropdownQualificationJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['qualification'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _4q = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Country'),
                            DropdownButton<String>(
                              value: _4qCountry,
                              isExpanded: true,
                              hint: Text('Select Option'),
                              items: admissionFormDropdownCountriesJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['country'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _4qCountry = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Form(
                          key: _q4school,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q4School = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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

                        Form(
                          key: _q4duration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q4Duration = x;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Reason',
                                    border: InputBorder.none,
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
                          key: _q4result,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    q4Result = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TODO: Certificate

                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Test type'),
                            DropdownButton<String>(
                              value: _test,
                              isExpanded: true,
                              hint: Text('Facility'),
                              items: admissionFormDropdownIELTSJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['test_type'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _test = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Form(
                                key: _year,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        maxLines: null,
                                        onSaved: (x) {
                                          year = x;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Reason',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: Form(
                                key: _overall,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        maxLines: null,
                                        onSaved: (x) {
                                          overall = x;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Reason',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  //TODO: Employment Details
                  Card(
                    child: Column(
                      children: <Widget>[
                        //TODO: Employment 1
                        //TODO: Date
                        //TODO: Date
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _e1time,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e1time = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e1name,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e1name = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e1location,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e1location = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e1position,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e1position = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
                                      size: 15,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TODO: Employment 2
                        //TODO: Date
                        //TODO: Date
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _e2time,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e2time = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e2name,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e2name = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e2location,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e2location = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                        Form(
                          key: _e2position,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    e2position = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                  ),

                  //TODO: Advance standing

                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _aname,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    aName = x;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,
                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Reason',
                                    hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.bookmark,
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
                  ),

                  SizedBox(
                    height: 15,
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
                            getAdmissionForm();
                          },
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getAdmissionFormDropdownRecords() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getAdmissionFormDropdownRecords'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'ipaddress': '1',
          'token': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionFormDropdownCountriesJson =
                json.decode(response.body)['data']['countries'];
            admissionFormDropdownProgramJson =
                json.decode(response.body)['data']['program'];
            admissionFormDropdownTermsJson =
                json.decode(response.body)['data']['terms'];
            admissionFormDropdownQualificationJson =
                json.decode(response.body)['data']['qualification'];
            admissionFormDropdownIELTSJson =
                json.decode(response.body)['data']['IELTS_tests'];
          },
        );
        print(admissionFormDropdownIELTSJson[0].toString());
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }

  Future getProgramsByCategory1() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
      programsByCategory1Json.clear();
    });
    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getProgramsByCategory'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'category_id': _1Program,
          'usertype': '1',
          'ipaddress': '1',
          'token': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            programsByCategory1Json = json.decode(response.body)['data'];
          },
        );

        print(programsByCategory1Json);
        print(_1Program);

        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }

  Future getProgramsByCategory2() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
      programsByCategory2Json.clear();
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getProgramsByCategory'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'category_id': _2Program,
          'usertype': '1',
          'ipaddress': '1',
          'token': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            programsByCategory2Json = json.decode(response.body)['data'];
          },
        );
        print(programsByCategory2Json);
        print(_2Program);
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }

  Future getAdmissionForm() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/membershipForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'title': '',
          'gender': '',
          'fname': '',
          'mname': '',
          'lname': '',
          'email': '',
          'dob': '',
          'student_visa': '',
          'hostel_facility': '',
          'address': '',
          'suburb': '',
          'state': '',
          'postal_code': '',
          'country_id': '',
          'telphone_no': '',
          'mobile_no': '',
          'home_address': '',
          'home_suburb': '',
          'home_state': '',
          'home_postal_code': '',
          'home_country_id': '',
          'home_telphone_no': '',
          'home_mobile_no': '',
          'nationality_id': '',
          'country_permanent': '',
          'country_of_birth': '',
          'is_international_student': '',
          'program_preference1': '',
          'course_preference1': '',
          'program_preference2': '',
          'course_preference2': '',
          'begin_degree': '',
          'distance_learning': '',
          'underwent_sat_exam': '',
          'sat_score': '',
          'english_proficiency': '',
          'english_proficiency_year': '',
          'english_proficiency_overall': '',
          'institution_name': '',
          'qualifications': '',
          'employements': '',
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionForm = json.decode(response.body);
          },
        );
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionFormDropdownRecords);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionFormDropdownRecords);
      }
    }
  }
}
