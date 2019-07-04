import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';

void main() => runApp(HomeInfo());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeInfoState();
  }
}

class _HomeInfoState extends State<HomeInfo> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      key: _scaffoldKey,
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
                  Text("SUC Info",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         Icon(FontAwesomeIcons.home,color: Colors.white,size: 15,),

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
      body:
      Container(

        child: ListView(
          children: <Widget>[
            FittedBox(
                          child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/Directory");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10.0,
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
                                'Directory',
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
                        onTap: () {
                          Navigator.pushNamed(context, "/Faculty");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black,
                                                                 blurRadius: 10.0,

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
                                'Faculty Members',
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
                        onTap: () {
                          Navigator.pushNamed(context, "/Staff");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black,
                                                                 blurRadius: 10.0,

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
                                'Staff',
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

                ],
              ),
            ),
          ],
        ),
      ),







    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
