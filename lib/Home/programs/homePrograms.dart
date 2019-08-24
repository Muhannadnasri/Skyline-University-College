import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';

// Centre for continuing learning
void main() => runApp(HomePrograms());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomePrograms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeProgramsState();
  }
}

class _HomeProgramsState extends State<HomePrograms> {
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
      appBar: appBar(context, 'Programs'),
      body: Container(
        child: ListView(
          children: <Widget>[
            FittedBox(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, "/homeUndergraduate");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, right: 8.0),
                          child: Container(
                            width: 380,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //         <--- border radius here
                                  ),
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    'images/admission.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Undergraduate Programs",
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/homeGraduate");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, right: 8.0),
                          child: Container(
                            width: 380,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //         <--- border radius here
                                  ),
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    'images/admission.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Graduate Programs',
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
                  SizedBox(
                    height: 20,
                  ),

 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/professionalCourses");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, right: 8.0),
                          child: Container(
                            width: 380,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //         <--- border radius here
                                  ),
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    'images/admission.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Professional Courses',
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
                  SizedBox(height: 20,),
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
