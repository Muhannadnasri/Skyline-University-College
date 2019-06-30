import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3773AC),
              Color(0xFF104C90),
            ],
            stops: [
              0.2,
              0.6,
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              5, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Image.asset(
                      'images/logo.png',
                      height: 200,
                      width: 230,
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/HomeAdmission");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                               boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                              color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                            ),
                            width: 110,
                            height: 100,
                            child: Container(
                              width: 80,
                              height: 80,
                              child:Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/register.png',
                                        height: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Admission',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                              ),
                              
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/Programs");
                          },
                          child: Container(
                             decoration: BoxDecoration(
                               boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                              color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                            ),
                            width: 110,
                            height: 100,
                            child:Container(
                                
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                          'images/programs.png',
                                          height: 50,
                                        ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Programs',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/News");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                               color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                         color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                            width: 110,
                            height: 100,
                            
                              child: Container(
                                width: 80,
                                height: 80,
                                
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('images/news.png',height: 50,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'News',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                
                              ),
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/Location');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2, // has the effect of extending the shadow
                          offset: Offset(
                             5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                            width: 110,
                            height: 100,
                            
                              
                              child: Container(
                                width: 80,
                                height: 80,
                               
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('images/location.png',height: 50,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Location',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                
                              ),
                            
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/HomeInfo");
                          },
                          child: Container(
                            width: 110,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2,  // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                            
                              child: Container(
                                width: 90,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                   Image.asset('images/info.png',height: 50,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'SUC Info',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/LoginApp");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Container(
                            width: 110,
                          
                            decoration: BoxDecoration(
                                color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                         color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2,  // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0,  // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                            height: 100,
                           
                              child: Container(
                                width: 80,
                                height: 80,
                                
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                     Image.asset('images/login.png',height: 50,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'SUC Login',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                
                              ),
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                    Navigator.pushNamed(context, "/Events");
                  },
                                                   
                              child: Container(
                                  width: 110,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(
                                            15.0) //         <--- border radius here
                                        ),
                                         boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius:
                                    100.0, // has the effect of softening the shadow
                                spreadRadius:
                                    2, // has the effect of extending the shadow
                                offset: Offset(
                                   5.0, // horizontal, move right 10
                                  5.0,  // vertical, move down 10
                                ),
                              )
                      ],
                                      ),
                                  
                                   
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset('images/events.png',height: 50,),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Events',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      
                                    ),
                                  
                                ),
                              ),
                            
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/FAQ");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                          spreadRadius:
                              2,  // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                             
                                child: Container(
                                  width: 90,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                     Image.asset('images/questions.png',height: 50,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'FAQ?',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/Gallery");
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //         <--- border radius here
                                  ),
                                   boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          blurRadius:
                              100.0, // has the effect of softening the shadow
                         spreadRadius:
                              2,  // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ],
                                ),
                              
                                child: Container(
                                  width: 90,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                     Image.asset('images/gallery.png',height: 50,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
