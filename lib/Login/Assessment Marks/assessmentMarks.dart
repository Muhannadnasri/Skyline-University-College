import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(AssessmentMarks());

class AssessmentMarks extends StatefulWidget {
  final String classID;

  final int index;

  AssessmentMarks({
    Key key,
    this.classID,
    this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AssessmentMarksState();
  }
}

Map<String, int> body;

class _AssessmentMarksState extends State<AssessmentMarks> {
  @override
  void initState() {
super.initState();
    getStudentAssessmentMarks();
assessmentMarksJson = [];

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar:PreferredSize(

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
                  Text("Assesment Marks ",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: GestureDetector(
                      onTap: (){
                        logOut(context);

                      },
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
                  ),

                ],),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),      body: Container(
        color: Colors.grey[300],
        child:
            Container(
              color: Colors.grey[300],
              child: ListView.builder(
                  itemCount: assessmentMarksJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 10,
                        child: DottedBorder(
                          color: Colors.blue,
                          gap: 3,
                          strokeWidth: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 25,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left:5),
                                        child: Text(assessmentMarksJson[index]['cname'],style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Assessment Name : '),
                                    Expanded(
                                      child: Text(
                                        assessmentMarksJson[index]['assessmenttools']
                                            .toString(),

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Marks : "),
                                    Expanded(
                                      child: Text(assessmentMarksJson[index]['total']
                                          .toString()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                    getStudentAssessmentMarks();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getStudentAssessmentMarks() async {

    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/assessmentMarks"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'course_id': widget.classID,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          assessmentMarksJson = json.decode(response.body)['data'];
          assessmentMarksJsonMessage = json.decode(response.body);

        });

        _showLoading(false);
      }
      if ( assessmentMarksJsonMessage['success'] == '0'){
        _showLoading(false);
        Fluttertoast.showToast(
            msg: assessmentMarksJsonMessage['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }
}
