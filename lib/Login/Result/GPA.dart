import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;

import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(GPA());

class GPA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GPAState();
  }
}

final _userId = GlobalKey<FormState>();
final _staffId = GlobalKey<FormState>();
String staffids = '';

String userids = '';


Map<String, int> body;

class _GPAState extends State<GPA> {
  @override
  void initState() {
    super.initState();
selectStudent=0;
selectStaff=0;
    gpaJson = {};
    imageJson = [];
    finalJson = [];
    marksJson=[];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
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
                    "Admin Tools",
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
      body: Column(
        children: <Widget>[
          Form(
            key: _userId,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    maxLines: null,
                    autofocus: false,
                    onSaved: (x) {
                      userids = x;
                    },
                    decoration: InputDecoration(
                      labelText: "Student ID",
                      fillColor: Colors.white,
                      helperStyle: TextStyle(fontSize: 13),
                      hintText: 'Please Enter Student ID',
                      hintStyle: TextStyle(fontSize: 15),
                      isDense: true,
                      prefixIcon: Icon(
                        FontAwesomeIcons.hackerNews,
                        size: 15,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('GPA'),
                    Radio(
                      value: 1,
                      groupValue: selectStudent,
                      onChanged: (int e) {
                        setState(() {
                          selectStudent = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                    Text('Makrs'),
                    Radio(
                      value: 2,
                      groupValue: selectStudent,
                      onChanged: (int e) {
                        setState(() {
                          selectStudent = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                    Text('Final'),
                    Radio(
                      value: 3,
                      groupValue: selectStudent,
                      onChanged: (int e) {
                        setState(() {
                          selectStudent = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                    Text('Image'),
                    Radio(
                      value: 4,
                      groupValue: selectStudent,
                      onChanged: (int e) {
                        setState(() {
                          selectStudent = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                    Text('Pass'),
                    Radio(
                      value: 5,
                      groupValue: selectStudent,
                      onChanged: (int e) {
                        setState(() {
                          selectStudent = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
selectStudent == 4 ? getStudentImage() : selectStudent == 1 ?  getStudentGPAProfile() : selectStudent == 3 ? getFinalMarks() : selectStudent == 5 ? getStudentP() : selectStudent == 2 ? getMarks() : getMarks();






                  },
                  child: Text('UserId'),
                ),
              ],
            ),
          ),
          Form(
            key: _staffId,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (x) {
                      staffids = x;
                    },
                    decoration: InputDecoration(
                      labelText: "Staff ID",
                      fillColor: Colors.white,
                      helperStyle: TextStyle(fontSize: 13),
                      hintText: 'Please Enter Student ID',
                      hintStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(
                        FontAwesomeIcons.hackerNews,
                        size: 15,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Pass'),
                    Radio(
                      value: 1,
                      groupValue: selectStaff,
                      onChanged: (int e) {
                        setState(() {
                          selectStaff = e;
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                  ],
                ),
                RaisedButton(
                    child: Text('Staff ID'),
                    onPressed: () {




                      setState(() {

                        if (selectStaff == 1)
                        {
  getStaffP() ;
                        }else{}
                        

                      
                        
                        
                        
                      



                      });
                    }),
              ],
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
                    getStudentGPAProfile();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getStudentGPAProfile() async {
    if (_userId.currentState.validate()) {
      _userId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStudentGPAProfile"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': userids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          gpaJson = json.decode(response.body)['data'];
                  _showLoading(false);

        });
           Navigator.pushNamed(context, "/GPASS");

      }
      print(gpaJson.toString());
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }

  Future getStudentImage() async {
    if (_userId.currentState.validate()) {
      _userId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getStudent"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': userids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          imageJson = json.decode(response.body)['data'];
          _showLoading(false);
        });
         Navigator.pushNamed(context, "/GPASS");
        
        print(response.body.toString());
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

  Future getFinalMarks() async {
    if (_userId.currentState.validate()) {
      _userId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getFinal"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': userids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          finalJson = json.decode(response.body)['data'];
           _showLoading(false);
        });
         Navigator.pushNamed(context, "/GPASS");
       
        print(response.body.toString());
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

  Future getMarks() async {
    if (_userId.currentState.validate()) {
      _userId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getMarks"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': userids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          marksJson = json.decode(response.body)['data'];
           _showLoading(false);
        });
         Navigator.pushNamed(context, "/GPASS");
       
        print(response.body.toString());
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

  Future getStaffP() async {
    if (_staffId.currentState.validate()) {
      _staffId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getStaffP"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': staffids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          staffPJson = json.decode(response.body)['data'];
              _showLoading(false);
        });

 Navigator.pushNamed(context, "/GPAS");
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
  Future getStudentP() async {
    if (_userId.currentState.validate()) {
      _userId.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getStudentP"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': userids.toString(),
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          studentPJson = json.decode(response.body)['data'];
              _showLoading(false);
        });

 Navigator.pushNamed(context, "/GPASS");
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
}




