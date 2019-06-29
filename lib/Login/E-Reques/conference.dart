import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';


void main() => runApp(Conference());

class Conference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConferenceState();
  }
}

final _conference = GlobalKey<FormState>();
final _conferenceName = GlobalKey<FormState>();

Map<String, int> body;

class _ConferenceState extends State<Conference> {
  int groupValue;
  String fromTime;
  String session;
  int _year = 2018;
  int _month = 11;
  int _date = 11;
  String _dateEvent = '';


  String toTime;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
    getTimes();

  }


  void _showEventDate() {
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
        _changeEventDate(year, month, date);
      },
    );
  }

  void _changeEventDate(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dateEvent = '$year-$month-$date';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(70.0),
        child:


        Stack(

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
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(

                        children: <Widget>[

                          Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text('Back',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  Text("Course Withdrawal",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                     child: GestureDetector(
                      onTap: (){
                        logOut(context);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[

                            Icon(FontAwesomeIcons.powerOff,color: Colors.red,size: 15,),
                            SizedBox(width: 5,),
                            Text('Logout',style: TextStyle(fontSize: 15,color: Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Course Code',style: TextStyle(color: Colors.grey[600]
                      ),
                      ),

                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Form(
                    key: _conferenceName,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(

                            textCapitalization: TextCapitalization.words,
                            maxLines: null,
                            onSaved: (x) {
                              conferenceName = x;
                            },
                            decoration:

                            InputDecoration(
                              labelText: "Remark",
                              fillColor: Colors.white,

                              helperStyle: TextStyle(fontSize: 13),
                              hintText: 'Please Enter Your Reason',hintStyle: TextStyle(fontSize: 15),
                              isDense: true,
                              prefixIcon: Icon(FontAwesomeIcons.bookmark,size: 15,color: Colors.purple,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                  GestureDetector(
                      onTap: (){
                        _showEventDate();
                      },
                      child: Container(
height: 50,
                          width: 450,
                          child: Card(

                            elevation: 10,
                            child:

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(

                                children: <Widget>[
                                  Icon(FontAwesomeIcons.calendarAlt),
                                  SizedBox(width: 20,),
                                  Text(_dateEvent== null ? 'Select Date': _dateEvent == '' ? 'Select Date' : _dateEvent)
                                ],
                              ),

                            ) ,))),


                  Container(

                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('From Time',style: TextStyle(color:Colors.grey[500]),),
                    )
                    ,),
                  Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select Option',style: TextStyle(color: Colors.black),),
                          ),
                          isExpanded: true,
                          value: fromTime,
                          items: personalFamilyTimesJson
                              ?.map(
                                (item) => DropdownMenuItem<String>(
                              value: item['time_value'].toString(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['time_value']),
                              ),
                            ),
                          )
                              ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              fromTime = value;
                              print(fromTime);
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(

                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('To Time'),
                    )
                    ,),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: Text('Select Option',style: TextStyle(color: Colors.black),),
                          isExpanded: true,
                          value: toTime,
                          items: personalFamilyTimesJson
                              ?.map(
                                (item) => DropdownMenuItem<String>(
                              value: item['time_value'].toString(),
                              child: Text(item['time_value']),
                            ),
                          )
                              ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              toTime = value;
                              print(toTime);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
SizedBox(height: 15,),




                  Container(

                    alignment: Alignment.centerLeft,
                    child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Session',style: TextStyle(color:Colors.grey[500]),),
                  ),),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select Events',style: TextStyle(color: Colors.black),),
                          ),
                          isExpanded: true,
                          value: session,
                          items: ['Morning Session','Evening Session']
                              ?.map(
                                (item) => DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.toString()),
                              ),
                            ),
                          )
                              ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              session = value;
                              print(session);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _conference,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  conference = x;
                                },
                                decoration:

                                InputDecoration(
                                  labelText: "Remark",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please Enter Your Reason',hintStyle: TextStyle(fontSize: 15),
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

                          onTap: (){
                            getConference();
                          },
                          child: Center(child: Text('Submit',style: TextStyle(color: Colors.white),)))
                  ),
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
                title: Image.asset('images/logo.png',
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

  void _showError(String msg,IconData icon) {
    _showLoading(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset('images/logo.png',
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
                    getTimes();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

//TODO: RequestType

//TODO: Final Request
  Future getTimes() async {
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


            personalFamilyTimesJson = json.decode(response.body)['data']['times'];



          },
        );
      }

      print(personalFamilyTimesJson.toString());
    } catch (x) {
      print(x);
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }

  Future getConference() async {
    if (_conference.currentState.validate()) {
      _conference.currentState.save();
    }
    if (_conferenceName.currentState.validate()) {
      _conferenceName.currentState.save();
    }



    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/courseWithdrawal'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'type': 'conferenceform',
          'event_name': _conferenceName,
          'event_date': _dateEvent,
          'session': session,

          'from_time': fromTime,

          'to_time': toTime,
          'remark': conference,


          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
              () {
            courseWithdrawalJson = json.decode(response.body);
          },
        );
        _showLoading(false);
      }
      if ( courseWithdrawalJson['success'] == '0'){
        _showLoading(false);
        Fluttertoast.showToast(
            msg: courseWithdrawalJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }
    } catch (x) {if(x.toString().contains("TimeoutException")){
      _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
    }else{
      _showError("Sorry, we can't connect",Icons.perm_scan_wifi);

    }

    }
  }
}
