import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';

void main() => runApp(HomeERequest());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeERequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeERequestState();
  }
}

class _HomeERequestState extends State<HomeERequest> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
return Scaffold(
        body:
            studentJson ['data']['user_type'] == "STUDENT" ?
            Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/OnlineRequest");
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
                                'Online Request',
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
                          Navigator.pushNamed(context, "/ChangeClassTime");
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
                                'ChangeClassTime',
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
                          Navigator.pushNamed(context, "/ReinStatement");
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
                                'ReinStatement',
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
                          Navigator.pushNamed(context, "/CourseWithdrawal");
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
                                'CourseWithdrawal',
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
                          Navigator.pushNamed(context, "/UpdateInformation");
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
                                'UpdateInformation',
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
                          Navigator.pushNamed(context, "/PassportWithdrawal");
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
                                'PassportWithdrawal',
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
                          Navigator.pushNamed(context, "/GeneralAppointment");
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
                                'GeneralAppointment',
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
            ],
          ),
        ):
            studentJson ['data']['user_type'] == "STF" ?
            Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15,),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/PassportRetaining");
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
                                FontAwesomeIcons.passport,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Passport Retaining',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/SalaryCertificate");
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
                                FontAwesomeIcons.gratipay,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Leave Application',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/LeaveApplication");
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
                                FontAwesomeIcons.doorOpen,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Salary Certificate',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/PassportWithdrawal");
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
                                FontAwesomeIcons.passport,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Passport Withdrawal',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/LeaveHoliday");
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
                                FontAwesomeIcons.planeDeparture,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Leave Holiday',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
             
                
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/BookRequisition");
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
                                FontAwesomeIcons.book,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Book Requisition',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/MembershipForm");
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
                                FontAwesomeIcons.userFriends,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Membership Form',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/AirTicketRequest");
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
                                FontAwesomeIcons.userFriends,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'AirTicketRequest',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            )
          ],
        ),
      ):




            studentJson ['data']['user_type'] == "FAC" ?
            Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
SizedBox(height:20 ,),

                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/PassportRetaining");
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
                                    'Passport Retaining',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),//TODO:
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/LeaveApplication");
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
                                    'Leave Application',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/SalaryCertificate");
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
                                    'Salary Certificate',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/PassportWithdrawal");
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
                                    'Passport Withdrawal',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/LeaveHoliday");
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
                                    'Leave Holiday',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/Conference");
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
                                    'Conference',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),//TODO: Air Ticket
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/BookRequisition");
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
                                    'Book Requisition',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/MembershipForm");
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
                                    'Membership Form',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/AirTicketRequest");
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
                                    'AirTicketRequest',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),//TODO: Conference
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/OnlineRequest");
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
                                    'Online Request',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),//TODO: Outdoor Event
                      SizedBox(height: 20,),
                    ],
                  )
                ],
              ),
            ):
            SizedBox(),





      key: _scaffoldKey,
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ZigZag(
                    clipType: ClipType.waved,
                    child: Container(
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
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 12.0, // has the effect of softening the shadow
            spreadRadius: 3.0, // has the effect of extending the shadow
            
          )
        ],
                                      ),
                                      child: Image.asset(

                                         studentJson['data']['user_type'] == 'FAC'
                                            ? 'images/professor-male.png'
                                            :studentJson['data']['Gender'] =='M'?'images/male.png':studentJson['data']['Gender'] =='F' ? 'images/female.png' :'images/professor-male.png',height: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        studentJson['data']['name'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                studentJson['data']['user_type'] == 'STF'
                                    ? SizedBox(
                                        height: 10,
                                      )
                                    : Row(
                                        children: <Widget>[
                                          Container(
                                              decoration: BoxDecoration(
                                        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 12.0, // has the effect of softening the shadow
            spreadRadius: 3.0, // has the effect of extending the shadow
            
          )
        ],
                                      ),
                                            child:Image.asset('images/degree.png',height: 25,),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              studentJson['data']['program']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                       decoration: BoxDecoration(
                                        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 12.0, // has the effect of softening the shadow
            spreadRadius: 3.0, // has the effect of extending the shadow
            
          )
        ],
                                      ),
                                      child: Image.asset('images/year.png',height:25,),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        studentJson['data']['acadyear_desc']
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
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
                    studentJson['photo'].toString() ==
                            "https:\/\/skylineportal.com\/sitgmioxg\/professor.png"
                        ? Container(
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
                                  image: AssetImage(
                                    'images/logosmall.png',
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
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
                                  image: NetworkImage(
                                    studentJson['photo'].toString(),
                                  ),
                                ),
                              ),
                            ),
                          ), //TODO: Image Profile
                  ],
                ),
              ), //TODO: Image Profile
              Row(
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
                  Padding(
                    padding: const EdgeInsets.all(15),
                    
                    child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            FontAwesomeIcons.powerOff,
                            color: Colors.red,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 17, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //TODO: Put all Icon Container
            ],
          ),
        ),
    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
