
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';


void main() => runApp(Location());

class Location extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LocationState();
  }
}



Map<String, String> body;



class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    getLocation();
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
                  Text("Location",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[

                          Text('Home',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
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
        child: Column(
          children: <Widget>[
            Expanded(
              child:


              ListView.builder(
                  itemCount: getLocationJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(top:5),
                        child: Card(

                          child:
                          Column(

                            children: <Widget>[

                              Container(
                                width: 500,
                                height: 30,
                                alignment: Alignment.center,
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
                                child: Text(getLocationJson[index]['name'],style: TextStyle(color: Colors.white),),
                              ),

                              SizedBox(height: 10,),

                              Row(children: <Widget>[
                                SizedBox(width: 10,),

                                Icon(FontAwesomeIcons.mapMarkerAlt,size: 15,),
                                SizedBox(width: 10,),
                                GestureDetector(

                                    onTap: (){
                                      _launchMapsUrl(getLocationJson[index]['latitude'],getLocationJson[index]['longitude']);

                                    },
                                    child: Text(getLocationJson[index]['address1'],style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),)),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: <Widget>[
                                SizedBox(width: 10,),

                                RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 50),
                                    child: Icon(FontAwesomeIcons.phone,size: 15,)),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    launch('tel:'+getLocationJson[index]['phone1'].toString()
//
                                    );
                                  },
                                  child: Text(getLocationJson[index]['phone1'],style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),),
                                ),

                              ],),
                              SizedBox(height: 10,),

                              Row(children: <Widget>[
                                SizedBox(width: 10,),

                                Icon(FontAwesomeIcons.solidEnvelope,size: 15,),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    launch(


                                        'mailto:'+getLocationJson[index]['email']
                                            .toString()

                                    );
                                  },
                                  child: Text(getLocationJson[index]['email'],style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),),
                                ),

                              ],

                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      );




                  }

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
                    getLocation();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }
  Future getLocation() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLocations'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
              () {
                getLocationJson = json.decode(response.body)['data'];
          },
        );
        print(getLocationJson.toString());
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
  void _launchMapsUrl(String lat, String lon) async {

    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
      print(url);

    } else {
      throw 'Could not launch $url';
    }
  }

}
