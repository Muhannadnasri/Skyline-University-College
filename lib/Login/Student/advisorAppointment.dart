import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(AdvisorAppointment());

class AdvisorAppointment extends StatefulWidget {
  final String myAdvisorName;

  const AdvisorAppointment({Key key, this.myAdvisorName}) : super(key: key);

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

  String _time;
  String _date;
  String _case;

  @override
  void initState() {
    super.initState();
    getAdvisorDate();
    groupValue = 2;
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

//
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
                    "Advisor Appointment",
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Text(
                          widget.myAdvisorName == null
                              ? ''
                              : widget.myAdvisorName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF104C90),
                                Color(0xFF3773AC),
                              ],
                              stops: [
                                0.7,
                                0.9,
                              ])),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Appointment Date',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Date',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          value: _date,
                          items: advisorDateJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                        value: item['days'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(item['days']),
                                        )),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              _date = value;
                              getAdvisorApptTime();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Appointment Time',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: DropdownButton<String>(
                          value: _time,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Time',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          items: advisorApptTimeJson
                                  ?.map((item) => DropdownMenuItem<String>(
                                      value: item['Session_Time'],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item['Session_Time']),
                                      )))
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              _time = value;
                              getAdvisorAppointment();
                            });
                          },
                        ),
                      ),
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
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Yes'),
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
                            Text('No'),
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Case Description',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _case,
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Case Description',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                items: advisorCaseJson
                                        ?.map((item) =>
                                            DropdownMenuItem<String>(
                                                value: item['case_desc'],
                                                child: Text(item['case_desc'])))
                                        ?.toList() ??
                                    [],
                                onChanged: (value) {
                                  setState(() {
                                    _case = value;
                                  });
                                },
                              ),
                            ),
                            Form(
                              key: _studentProblem,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      studentProblem = x;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Student Problem",
                                      fillColor: Colors.white,
                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Problem',
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
                            getAdvisorAppointment();
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

  Future getAdvisorDate() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getAdvisorNameDateCasedesc'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
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
            'https://skylineportal.com/moappad/api/web/getAdvisorApptTime'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'appt_date': _date,
          'token': '1',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
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

  Future getAdvisorAppointment() async {
    if (_studentProblem.currentState.validate()) {
      _studentProblem.currentState.save();
    }
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/advisorAppointment'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'degree': '1',
          'my_advisor': widget.myAdvisorName,
          'appt_date': _date,
          'appt_time': _time,
          'reg_new_case': '1',
          'case_desc': _case,
          'stud_problem': studentProblem,
          'token': '1',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            advisorAppointmentJson = json.decode(response.body);
          },
        );
      }
      if (advisorAppointmentJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: advisorAppointmentJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
      if (advisorAppointmentJson['success'] == '1') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: advisorAppointmentJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      print(x);
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
}
