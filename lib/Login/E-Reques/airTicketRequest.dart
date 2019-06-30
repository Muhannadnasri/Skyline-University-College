import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(AirTicketRequest());

class AirTicketRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AirTicketRequestState();
  }
}

final _placeFrom = GlobalKey<FormState>();
final _placeTo = GlobalKey<FormState>();
final _remarksAir = GlobalKey<FormState>();

Map<String, int> body;

class _AirTicketRequestState extends State<AirTicketRequest> {
  int groupValue;
  String leaveType;
  String _dateTimeLeave = '';
  String _dateTimeReturn = '';
  String _dayLeave = '';
  String _timeLeave = '';
  String _dayLeave1 = '';
  String _timeLeave1 = '';

  //
  int _year = 2018;
  int _month = 11;
  int _date = 11;

  @override
  void initState() {
    super.initState();
    getPersonalFamilyTimes();

    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
    leaveTypesJson.clear();
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

  void _showDay() {
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
      dateFormat: 'dd',
      onConfirm: (year, month, date) {
        _changeDay(year, month, date);
      },
    );
  }

  void _showDTime() {
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
        _changeTime(year, month, date);
      },
    );
  }

  void _showDay1() {
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
        _changeDay1(year, month, date);
      },
    );
  }

  void _showTime1() {
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
        _changeTim1(year, month, date);
      },
    );
  }

  void _changeDay(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dayLeave = '$year-$month-$date';
    });
  }

  void _changeTime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _timeLeave = '$year-$month-$date';
    });
  }

  void _changeDay1(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dayLeave1 = '$year-$month-$date';
    });
  }

  void _changeTim1(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _timeLeave1 = '$year-$month-$date';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true, //TODO: put in all page
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
                    "Permission To Leave",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.powerOff,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ],
                        ),
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
                                    ? 'Date to leave'
                                    : _dateTimeLeave == null
                                        ? 'Date to leave'
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDay();
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
                                Text(_dayLeave == ''
                                    ? 'day to leave'
                                    : _dayLeave == null
                                        ? 'day to leave'
                                        : _dayLeave),
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDTime();
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
                                Text(_timeLeave == ''
                                    ? 'Date to time'
                                    : _timeLeave == null
                                        ? 'Date to time'
                                        : _timeLeave),
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDay1();
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
                                Text(_dayLeave1 == ''
                                    ? 'Date to day1'
                                    : _dayLeave1 == null
                                        ? 'Date to day1'
                                        : _dayLeave1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //TODO: From and TO
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTime1();
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
                                Text(_timeLeave1 == ''
                                    ? 'time1 to leave'
                                    : _timeLeave1 == null
                                        ? 'timne1 to leave'
                                        : _timeLeave1),
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
                                    ? 'Date to Return'
                                    : _dateTimeReturn == null
                                        ? 'Date to Return'
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
                        key: _placeFrom,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              onSaved: (x) {
                                placeFrom = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
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
                        key: _placeTo,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              onSaved: (x) {
                                placeTo = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Place To",
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

                      SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _remarksAir,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: null,
                              onSaved: (x) {
                                remarksAir = x;
                              },
                              decoration: InputDecoration(
                                labelText: "Remarks",
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
                            getAirTicketRequest();
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

  void _showLoading(isLoading) {
    if (isLoading) {
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
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: new CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: new Text('Please Wait....'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  void _showError(String msg, IconData icon) {
    _showLoading(false);
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
                    getPersonalFamilyTimes();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

//TODO: RequestType
  Future getPersonalFamilyTimes() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });
    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getPersonalFamilyTimes'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'emp_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            personalFamilyPersonalJson =
                json.decode(response.body)['data']['personal'];
            personalFamilyFamilyJson =
                json.decode(response.body)['data']['family'];

            personalFamilyTimesJson =
                json.decode(response.body)['data']['times'];

            personalFamilyTimesMessageJson = json.decode(response.body);
          },
        );
        _showLoading(false);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }

  Future getAirTicketRequest() async {
    if (_placeFrom.currentState.validate()) {
      _placeFrom.currentState.save();
    }
    if (_placeTo.currentState.validate()) {
      _placeTo.currentState.save();
    }
    if (_remarksAir.currentState.validate()) {
      _remarksAir.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/leaveDuringHolidays'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'EmoNumber': studentJson['data']['user_id'],
          'LeaveFrom': _dateTimeLeave.toString(),
          'LeaveTo': _dateTimeReturn.toString(),
          'Placefrom': placeFrom,
          'Placefrom1': placeTo,
          'Placeto': placeTo,
          'Placeto1': placeFrom,
          'Remarks': reasonLeave,
          'Day': _dayLeave,
          'Day1': _dayLeave1,
          'Time': _timeLeave,
          'Time1': _timeLeave1,
          'LoginIp': '1',
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
        _showLoading(false);
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
