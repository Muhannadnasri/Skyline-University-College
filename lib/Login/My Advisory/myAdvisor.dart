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
import 'package:url_launcher/url_launcher.dart';

import 'adisorAppointment.dart';

void main() => runApp(MyAdvisor());

class MyAdvisor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAdvisorState();
  }
}

Map<String, int> body;

class _MyAdvisorState extends State<MyAdvisor> {
  @override
  void initState() {
super.initState();
    getMyAdvisor();
myAdvisorJson = [];

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
                    Text("Advisor Details",style: TextStyle(color: Colors.white),),

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
          color: Colors.grey[300],
          child: ListView.builder(
                  itemCount: myAdvisorJson.length,
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
                                height: 30,
                                child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text(myAdvisorJson[index]['NAME OF THE FACULTY'],style: TextStyle(color: Colors.white),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:10.0),
                                  child: GestureDetector(

                                      onTap: (){

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdvisorAppointment(

                                                myAdvisorName: myAdvisorJson[index]
                                                ['NAME OF THE FACULTY']
                                                    .toString()),
                                          ),
                                        );

                                      },
                                      child: Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,size: 20,)),
                                ),

                              ]),
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
                                ),
                              SizedBox(height: 10,),

                              Row(
                                children: <Widget>[
                                  Text('Postion : '),
                                  Text(
                                    myAdvisorJson[index]['DESIGNATION'].toString(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              GestureDetector(                              onTap:  () {

                                launch('tel:00'+myAdvisorJson[index]['TELPHONE NO']+',1'+','+myAdvisorJson[index]['EXTENSION NO']
                                    .toString()
//
                      );
                                },

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Mobile Phone : "),
                                    Text('00'+
                                        myAdvisorJson[index]['TELPHONE NO'].toString(),
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                      ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),

                              Row(
                                children: <Widget>[
                                  Text("Extestion NO : "),
                                  Text(myAdvisorJson[index]['EXTENSION NO']
                                      .toString()),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Text('Email ID : '.padRight(10)),
                                  GestureDetector(onTap: (){
                                    launch(


                                        'mailto:'+myAdvisorJson[index]['EMAIL ID']
                                        .toString()

                                    );
                                  },
                                    child: Text(
                                      myAdvisorJson[index]['EMAIL ID'].toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              Row(
                                children: <Widget>[
                                  Text('Faclty ID : '),
                                  Text(
                                    myAdvisorJson[index]['FACULTY_ID'].toString(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ));
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
                    getMyAdvisor();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getMyAdvisor() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getMyAdvisors'),
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
            myAdvisorJson = json.decode(response.body)['data'];
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
}
