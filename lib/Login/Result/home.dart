import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';

void main() => runApp(HomeResult());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeResultState();
  }
}

class _HomeResultState extends State<HomeResult> {
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
                          Navigator.pushNamed(context, "/FinalTermResults");

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
                                'Final Grade Result',
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

                        onTap: (){Navigator.pushNamed(context, "/MidTermMarks");},

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
                                'Mid Term Result',
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
                          Navigator.pushNamed(context, '/StudentGPAProfile');
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
                                'Student GPA Profile',
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: Stack(

          children: <Widget>[
            Column(
              children: <Widget>[
                ZigZag(
                  clipType: ClipType.waved,
                  child:
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(

                                    studentJson['data']['user_type'] == 'STF'?
                                    FontAwesomeIcons.userShield

                                        :
                                    Icons.person_pin,
                                    size: 20,color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      studentJson['data']['name'].toString(),style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),

                              studentJson['data']['user_type'] == 'STF'?
                              SizedBox(height: 10,)
                                  :
                              Row(
                                children: <Widget>[

                                  Icon(
                                    FontAwesomeIcons.graduationCap,color:Colors.white,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      studentJson['data']['program'].toString(),style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.calendarAlt,color: Colors.white,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      studentJson['data']['acadyear_desc']
                                          .toString(),style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ), //TODO: Name and years and type

                    height: 250,
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
                ), 


              ],
            ),

             Padding(
              padding: const EdgeInsets.only(top: 70.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  studentJson['photo'].toString() == "https:\/\/skylineportal.com\/sitgmioxg\/professor.png"?
                  Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image:

                      AssetImage(
                        'images/logosmall.png',
                      ),
                    ),
                  ),
                ),
              )

                      :
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:

                          NetworkImage(
                              studentJson['photo'].toString(),

                          ),
                        ),
                      ),
                    ),
                  ), //TODO: Image Profile
                ],
              ),
            ), //TODO: Image Profile
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

    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
