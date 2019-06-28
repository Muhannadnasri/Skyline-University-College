import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:skyline_university/Home/home.dart';

void main() => runApp(HomeAdmission());



class HomeAdmission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAdmissionState();
  }
}

class _HomeAdmissionState extends State<HomeAdmission> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,

        child: ListView(
          children: <Widget>[
            SizedBox(height: 20,),
            Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/AdmissionForm");

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        height: 50,
                        width: 370,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 74,
                              width: 70,
                              child: Icon(
                                FontAwesomeIcons.newspaper,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'AdmissionForm',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/FAQ');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        height: 50,
                        width: 370,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 74,
                              width: 70,
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'FAQ?',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/GetGPARequirments');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        height: 50,
                        width: 370,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 74,
                              width: 70,

                              child: Icon(
                                FontAwesomeIcons.newspaper,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'GPA Requirments',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
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
                    "Faculty Members",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()),
                              (Route<dynamic> route) => true);
                     },
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.home,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
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

    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
