import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';


void main() => runApp(Directory());

class Directory extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DirectoryState();
  }
}



Map<String, String> body;



class _DirectoryState extends State<Directory> {
  @override
  void initState() {
    super.initState();
    getDirectory();
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
                  Text("About SUC",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[

                          Icon(FontAwesomeIcons.home,color: Colors.white,size: 15,),
                          SizedBox(width: 5,),
                          Text('Home',style: TextStyle(fontSize: 15,color: Colors.red),),
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
            Row(children: <Widget>[


            ],),

            Expanded(
              child:
              ListView.builder(
                  itemCount: getDirectoryJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top:5),
                      child: Card(

                        child:
                        Row(

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
                              child: Text(

                                getDirectoryJson[index]['name'],style: TextStyle(color: Colors.white),


                              ),
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
                    getDirectory();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }
  Future getDirectory() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getDirectory'),
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
                getDirectoryJson = json.decode(response.body)['data'];
          },
        );
        print(getDirectoryJson.toString());
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
