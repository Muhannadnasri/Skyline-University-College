import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(GeneralAppointment());

class GeneralAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GeneralAppointmentState();
  }
}

final _remarkAppointment = GlobalKey<FormState>();

Map<String, int> body;

class _GeneralAppointmentState extends State<GeneralAppointment> {
  int groupValue;
  String _categoryID;
  String _departmentID;
  String _appointDate;
  String _caseType;
String _appointTime;
  @override
  void initState() {
    super.initState();

    getGeneralApptCatDeptTime();
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
                    "General Appointment",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                     logOut(context);},
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
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                        'Case Category',style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _caseType,
                        hint: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text('Select Option',style: TextStyle(color: Colors.black),),
                        ),
                        items: [
                              'General Appointment',
                              'Suggestions',
                              'Complaints',
                              'Improverments'
                            ]
                                ?.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text(item),
                                        ),
                                      ),
                                )
                                ?.toList() ??
                            [],
                        onChanged: (value) {

                          setState(() {
                            _caseType = value;

                          });
                        },

                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Case Category',style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _categoryID,
                        hint: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text('Select Option',style: TextStyle(color: Colors.black),),
                        ),
                        items: generalAPPtJson
                                ?.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item['CATEGORY_ID'].toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: Text(item['CATEGORY_DESCRIPTION']
                                              .toString()),
                                        ),
                                      ),
                                )
                                ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            _categoryID = value;
                            getGeneralApptCatDeptTime();
                          });
                        },
                      ),
                    ],
                  ),

_caseType == 'General Appointment' ?
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Department',style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: <Widget>[
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _departmentID,
                            hint: Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text('Select option',style: TextStyle(color: Colors.black),),
                            ),
                            items: generalAPPtDepartmentJson
                                    ?.map(
                                      (item) => DropdownMenuItem<String>(
                                            value: item['EmpNumber'],
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text(item['Department']),
                                                ),
                                              ],
                                            ),
                                          ),
                                    )
                                    ?.toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _departmentID = value;
                                getGeneralApptDate();

                              });
                            },
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Appointment Date',style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: <Widget>[
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _appointDate,
                            hint: Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text('Select option',style: TextStyle(color: Colors.black),),
                            ),
                            items: generalApptDate
                                    ?.map(
                                      (item) => DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text(item['date'].toString()),
                                                ),
                                              ],
                                            ),
                                          ),
                                    )
                                    ?.toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _appointDate = value;
                                getGeneralApptCatDeptTime();
                              });
                            },
                          ),
                        ],
                      ),


                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Appointment Time',style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),

                            Column(
                                    children: <Widget>[

                                      DropdownButton<String>(
                                        isExpanded: true,
                                        value: _appointTime,
                                        hint: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: Text('Select option',style: TextStyle(color: Colors.black),),
                                        ),
                                        items: generalAPPtTimeJson
                                            ?.map(
                                              (item) => DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text(item['timevalue'].toString()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                            ?.toList() ??
                                            [],
                                        onChanged: (value) {
                                          setState(() {
                                            _appointTime = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),



                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
    : SizedBox(),

                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Form(
                          key: _remarkAppointment,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(

                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    remarkAppointment = x;
                                  },
                                  decoration:

                                  InputDecoration(
                                    labelText: "Remark",
                                    fillColor: Colors.white,

                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please Enter Your Description',hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(FontAwesomeIcons.bookmark,size: 15,color: Colors.purple,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
                            getGeneralAppointment();
                          },
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              )))),
              SizedBox(height: 20,),

      ],
              ),
            ),
          ),
        ],
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
                    getGeneralApptCatDeptTime();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getGeneralApptDate() async {
    Future.delayed(Duration.zero, () {
      generalApptDate = [];
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getGeneralApptDate'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'emp_no': _departmentID,
          'department': '1',
          'token': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            generalApptDate = json.decode(response.body)['data'];
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

  Future getGeneralApptCatDeptTime() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getGeneralApptCatDeptTime'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'token': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            generalAPPtJson = json.decode(response.body)['data']['category'];
            generalAPPtDepartmentJson =
                json.decode(response.body)['data']['department'];
            generalAPPtTimeJson = json.decode(response.body)['data']['time'];
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

  Future getGeneralAppointment() async {
    if (_remarkAppointment.currentState.validate()) {
      _remarkAppointment.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/generalAppointment'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'case_type': _caseType,
          'case_category': _categoryID,
          'department': _caseType == 'Suggestions' ? null: _caseType == 'Complaints'? null :_caseType == 'Improverments' ? null: _departmentID,
          'appt_date':  _caseType == 'Suggestions' ? null: _caseType == 'Complaints'? null :_caseType == 'Improverments' ? null: _appointDate,
          'appt_time':  _caseType == 'Suggestions' ? null: _caseType == 'Complaints'? null :_caseType == 'Improverments' ? null: '',
          'description': '',
          'token': '1',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestJson = json.decode(response.body);
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
