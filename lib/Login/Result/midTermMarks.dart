import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(MidTermMarks());

class MidTermMarks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MidTermMarksState();
  }
}

Map<String, int> body;

class _MidTermMarksState extends State<MidTermMarks> {
  @override
  void initState() {
super.initState();
    getMidTermMarks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double c_width = MediaQuery.of(context).size.width*0.7;

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
                  Text("Mid Term Marks",style: TextStyle(color: Colors.white),),

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
      ),        body:
        midTermMarksJson == null
            ?SizedBox()
            :


        Container(
          color: Colors.grey[300],
          child: ListView.builder(
            itemCount: midTermMarksJson.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(

                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    elevation: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:15.0),
                          child: Row(

                            children: <Widget>[
                              Text('Courses : '),

                              Container(
                                width: c_width,

                                child: Text(

                                  midTermMarksJson[index]['COURSE NAME'],style: TextStyle(color: Colors.black,fontSize: 15,),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Course Code : ',style: TextStyle(fontSize: 10),),

                              Text(
                                midTermMarksJson[index]['COURSE CODE'],style: TextStyle(
                                  fontSize: 10,color: Colors.black
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10.0),
                          child: Row(

                            children: <Widget>[
                              Text('Faculty Name : ',style: TextStyle(fontSize: 10),),

                              Text(midTermMarksJson[index]['FACULTY NAME'],style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Semester : ',style: TextStyle(fontSize: 10),),
                              Text(midTermMarksJson[index]
                              ['SEMESTER NAME'],style: TextStyle(fontSize: 10,color: Colors.black),),
                            ],
                          ),
                        ),
                          SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10.0),
                          child: Row(children: <Widget>[
                             Text('Marks : ',style: TextStyle(fontSize: 10),),
                                Text(



                                    midTermMarksJson[index]['MARKS'].toString(),style: TextStyle(fontSize: 10,color: Colors.black),


                                ),
                          ],),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                  
                      ],
                    ),

                  ),
                ),
              );
            },
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
                    getMidTermMarks();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getMidTermMarks() async {
    Future.delayed(Duration.zero, () {
      midTermMarksJson = [];
      _showLoading(true);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getMidTermMarks"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          midTermMarksJson = json.decode(response.body)['data'];
          midTermMarksMessageJson = json.decode(response.body);

        });
        _showLoading(false);
      }
      if ( midTermMarksMessageJson['success'] == '0'){
        _showLoading(false);
        Fluttertoast.showToast(
            msg: midTermMarksMessageJson['message'],
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
