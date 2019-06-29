import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';


void main() => runApp(CourseWithdrawal());

class CourseWithdrawal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseWithdrawalState();
  }
}

final _remarkCourse = GlobalKey<FormState>();

Map<String, int> body;

class _CourseWithdrawalState extends State<CourseWithdrawal> {
  int groupValue;
  String id;

  @override
  void initState() {
super.initState();
    getCourseWithdrawalCourses();
courseNameJson.clear();

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
                  SizedBox(height: 15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Course Code',style: TextStyle(color: Colors.grey[600]),
                      ),

                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: Text('Select Option',style: TextStyle(color: Colors.black),),
                          isExpanded: true,
                          value: id,
                          items: courseWithdrawalCoursesJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                          value: item['CDD_ID'].toString(),
                                          child: Text(item['Cdd_COde']),
                                        ),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              id = value;
                              print(id);
                              getCourseName();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,


                        child: Text('Course Title',style: TextStyle(color: Colors.grey[600]),)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5),
                    child: Container(
                      height: 50 ,
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
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Center(
                          child: Text(
 courseNameJson.isEmpty
                                                    ?
                                                    ''
                                                    :
                        
                        
                              courseNameJson['data']['CourseName'],style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _remarkCourse,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  remarkCourse = x;
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
                            getCourseWithdrawal();
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
                    getCourseWithdrawalCourses();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

//TODO: RequestType
  Future getCourseWithdrawalCourses() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCourseWithdrawalCourses'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
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
            courseWithdrawalCoursesJson = json.decode(response.body)['data'];
          },
        );

        _showLoading(false);
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }

//TODO: Final Request
  Future getCourseName() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCourseName'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'course_id': id,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            courseNameJson = json.decode(response.body);
          },
        );
        print(courseNameJson);
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }

  Future getCourseWithdrawal() async {
    if (_remarkCourse.currentState.validate()) {
      _remarkCourse.currentState.save();
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
          'course_code': id,
          'course_title': courseNameJson['data']['CourseName'],
          'Remarks': remarkCourse,
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
