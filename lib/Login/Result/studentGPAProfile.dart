import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(StudentGPAProfile());

class StudentGPAProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentGPAProfileState();
  }
}

Map<String, int> body;

class _StudentGPAProfileState extends State<StudentGPAProfile> {
  @override
  void initState() {
super.initState();
    getStudentGPAProfile();
  studentGPAProfileJson.clear();

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
                  Text("GPA",style: TextStyle(color: Colors.white),),

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

                            Icon(FontAwesomeIcons.powerOff,color: Colors.red[300],size: 15,),
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
        color:Colors.grey[300],
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 20,
              child: DottedBorder(
                color: Colors.blue,
                gap: 3,
                strokeWidth: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
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

                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10.0,bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                child: Text(
                                studentGPAProfileJson.isEmpty  ? ' ':
                                  studentGPAProfileJson['data']['STUDENT NAME'] ==  'null'  ?  ''  : studentGPAProfileJson['data']['STUDENT NAME'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text('My Advisor : ', style:
                          TextStyle(fontSize: 12, color: Colors.black),),
                          Text(


                              studentGPAProfileJson.isEmpty  ? ' ':
                            studentGPAProfileJson['data']['ADVISOR'].toString() ==


                                'null'  ?  '' :

                            studentGPAProfileJson['data']['ADVISOR']  , style: TextStyle(fontSize: 13),


                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'TRANSFER OF CREDIT (TOC) : ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            studentGPAProfileJson.isEmpty  ? ' ':
                            studentGPAProfileJson['data']['TRANSFER OF CREDIT (TOC)'] == 'null' ? '' : studentGPAProfileJson['data']['TRANSFER OF CREDIT (TOC)'].toString()  , style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'TOTAL CREDIT EARNED (INCLUDING TOC) : ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(

                            studentGPAProfileJson.isEmpty  ? ' ':
                            studentGPAProfileJson['data']['TOTAL CREDIT EARNED (INCLUDING TOC)'] ==  'null' ? '' : studentGPAProfileJson['data']['TOTAL CREDIT EARNED (INCLUDING TOC)'].toString(),
                              style:
                            TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            children: <Widget>[
                              Text('GPA'),
                              Text(

                                  studentGPAProfileJson.isEmpty  ? ' ':
                                  studentGPAProfileJson['data']['CGPA']  == 'null' ? ' ' : studentGPAProfileJson['data']['CGPA'] .toString())
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text('Level'),
                            Text(

                              studentGPAProfileJson.isEmpty  ? ' ':
                              studentGPAProfileJson['data']

                            ['LEVEL']  =='null' ? '' :  studentGPAProfileJson['data']
                            ['LEVEL'] .toString(),),
                          ],
                        ),

                        Column(
                          children: <Widget>[
                            Text('Credit To Completed'),
                            Container(
                              child: Text(
                                  studentGPAProfileJson.isEmpty  ? ' ':
                                  studentGPAProfileJson['data']['CREDIT TO BE COMPLETED']  == 'null' ? '': studentGPAProfileJson['data']['CREDIT TO BE COMPLETED'].toString()   ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('CREDIT ATTENDED'),
                            Text(

                                studentGPAProfileJson.isEmpty  ? ' ':
                                studentGPAProfileJson['data']['CREDIT ATTENDED'] == 'null' ? '': studentGPAProfileJson['data']['CREDIT ATTENDED'].toString()),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
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
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          studentGPAProfileJson = json.decode(response.body);
        });


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
}
